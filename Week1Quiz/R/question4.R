cat("Answering question 4\n\n")
library(XML)

if (!file.exists("data")) {
	cat("Creating data directory ...\n")
	dir.create("data")
}

destFilePath <- "data/baltimore_restaurants.xml"
dateDownloadedPath <- "data/baltimore_restaurants_dateDownloaded.RData"

if (file.exists(destFilePath)) {
	cat("Data already downloaded.\n")
	load(dateDownloadedPath)
} else {
	cat("Downloading data to", destFilePath, "\n")
	url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
	download.file(url, destFilePath, method="curl")
	dateDownloaded <- date()
	save(dateDownloaded, file=dateDownloadedPath)
}
cat("Data downloaded", dateDownloaded, "\n")

cat("Reading data ...\n")
doc <- xmlTreeParse(destFilePath, useInternal=T)

cat("Analysing data ...\n")
df <- as.data.frame(xpathSApply(doc, "//row/zipcode/text()", xmlValue))
names(df) <- c('zipcode')
answer <- length(df[df$zipcode=="21231",])
q4_answer <- paste("The number of restaurants with a zipcode of 21231 is", answer)
cat(q4_answer, "\n\n\n")

