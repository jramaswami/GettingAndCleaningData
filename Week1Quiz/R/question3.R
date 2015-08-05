cat("Answering question 3 ...\n\n")
library(xlsx)

if (!file.exists("data")) {
	cat("Creating data directory ...\n")
	dir.create("data")
}

destFilePath <- "data/FDATA_gov_NGAP.xlsx"
dateDownloadedPath <- "data/FDATA_gov_NGAP_dateDownloaded.RData"
if (file.exists(destFilePath)) {
	cat("Data already downloaded.\n") 
	load(dateDownloadedPath)
} else {
	cat("Downloading data to", destFilePath, "...\n")
	url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
	download.file(url, destfile=destFilePath, method="curl")
	dateDownloaded <- date()
	save(dateDownloaded, file=dateDownloadedPath)
}

cat("Data downloaded", dateDownloaded, "\n") 
cat("Reading data ...\n")
dat <- read.xlsx(destFilePath,sheetIndex=1,colIndex=7:15,rowIndex=18:23,header=T)
cat("Analysing data ...\n")
answer <- sum(dat$Zip*dat$Ext,na.rm=T) 
q3_answer <- paste("The answer is", answer)
cat(q3_answer,"\n\n\n")
