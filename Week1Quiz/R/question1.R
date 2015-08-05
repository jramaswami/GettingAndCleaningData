cat("Answering question 1 ...\n\n")
if (!file.exists("data")) {
	cat("Creating data directory ...\n")
	dir.create("data")
}

destFilePath <- "data/idaho_housing_data_ss06hid.csv"
dateDownloadedPath <- "data/idaho_housing_data_ss06hid_dateDownloaded.RData"
if (file.exists(destFilePath)) {
	cat("Data already downloaded.\n")
	load(dateDownloadedPath)
} else {
	cat("Downloading data to", destFilePath, "...\n")
	url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
	download.file(url, destfile=destFilePath, method="curl")
	dateDownloaded <- date()
	save(dateDownloaded, file=dateDownloadedPath)
}

cbFilePath <- "data/2FPUMSDataDict06.pdf"
if (!file.exists(cbFilePath)) {
	cat("Downloading codebook to", cbFilePath, "...\n")
	cbUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
	download.file(cbUrl, destfile=cbFilePath, method="curl")
}

dateDownloaded <- date()
cat("Data downloaded", dateDownloaded, "\n")

cat("Reading data from file ...\n")
df <- read.csv(destFilePath)
cat("Analysing data ...\n")
df.complete <- df[complete.cases(df$VAL),c('SERIALNO','VAL')]
answer <- nrow(df.complete[df.complete$VAL==24,])
q1_answer <- paste("The number of houses valued more than $1,000,000 is", answer)
cat(q1_answer, "\n\n\n")

