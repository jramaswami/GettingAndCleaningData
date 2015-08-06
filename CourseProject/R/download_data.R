library("rjson")

checkDataDir <- function() {
	if (!file.exists("data")) {
		cat("Creating data directory ...\n")
		dir.create("data")
	}
}

downloadData <- function() {

	urls <- c("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
				"http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip")
	filenames <- c("coursera_dataset.zip", "uci_dataset.zip")
	jsonFilenames <- c("coursera_download_metadata.json", "uci_download_metadata.json")
	
	prompt <- "Where would you like me to download data from?"
	choices <- c("1. Coursera",
				  "2. Original data source (UC Irvine)")
	response <- getUserInput(prompt, choices)

	#response <- determineURL()
	if (response == 0) {
		# user quit or wouldn't choose
		return(FALSE)
	}

	checkDataDir()

	destFilePath <- file.path("data", filenames[response])
	jsonFilePath <- file.path("data", jsonFilenames[response])
	doDownload <- TRUE

	if (file.exists(destFilePath)) {
		cat("Data already downloaded.\n")
		if (file.exists(jsonFilePath)) {
			# read metadata
			cat("Reading existing download metadata from",
				jsonFilePath, "...\n")
			jsonData <- fromJSON(file=jsonFilePath)
			cat("Data was downloaded from", jsonData$url, "on",
				jsonData$downloadDate, "\n")
		} else {
			cat("Download metadata is missing, so I don't know",
				"when this file was downloaded.\n")
		}

		prompt <- "Do you want me to download a fresh copy?"
		choices <- c("Yes", "No")
		response <- getUserInput(prompt, choices)
		if (response == 0) {
			return(FALSE)
		} else if (response == 1) {
			file.remove(destFilePath)
			if (file.exists(jsonFilePath)) {
				file.remove(jsonFilePath)
			}
		} else {
			doDownload <- false
		}
	} 

	if (doDownload) {
		# download data
		cat("Downloading data to", destFilePath, "...\n")
		download.file(urls[response], destfile=destFilePath, method="curl")

		# write download metadata to json file
		json <- toJSON(list(downloadDate = date(), url = urls[response],
							filename = filenames[response]))
		if (file.exists(jsonFilePath)) {
			cat("Removing old download metadata ...\n")
			file.remove(jsonFilePath)
		}
		cat("Writing download metadata to", jsonFilePath, "...\n")
		cat(json, file=jsonFilePath)
	}
}

getUserInput <- function(prompt, choices) {
	waiting <- TRUE
	tries <- 0
	while(waiting) {
		cat(prompt, "\n")
		n = 1
		for (c in choices) {
			cat(n, ": ", c, "\n")
			n <- n + 1
		}
		cat(n, ": Quit\n")
		quit_response <- n
		response <- as.numeric(readline(">>>"))

		if (is.na(response)) {
			response <- 0
		}
		if (response > 0 & response < length(choices)) {
			return(response)
		} else if (response == quit_response) {
			waiting <- FALSE
		}

		tries <- tries + 1

		if (tries > 5) {
			cat("Obviously, you're just messing with me.\n")
			waiting <- FALSE
		}
	}
	cat ("Goodbye!\n")
	0
}

determineURL <- function() {
	waiting <- TRUE
	tries <- 0
	while (waiting) {
		cat("Would you like me to download data from\n")
		cat("1. Coursera?\n")
		cat("2. Original data source (UC Irvine)?\n")
		cat("3. Quit?\n")
		response <- as.numeric(readline(">>>"))
		if (is.na(response)) {
			response <- 0
		}
		if (response == 1) {
			return(response)
		} else if (response == 2) {
			return(response)
		} else if (response == 3) {
			waiting <- FALSE
		}

		tries <- tries + 1

		if (tries > 5) {
			cat("Obviously, you're just messing with me.\n")
			waiting <- FALSE
		}
	}
	cat ("Goodbye!\n")
	0
}
