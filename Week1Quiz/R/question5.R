cat ("Answering question 5 ...\n\n")
library(data.table)
library(microbenchmark)
library(ggplot2)

if (!file.exists("data")) {
	cat("Creating data directory ...\n")
	dir.create("data")
}

dateDownloadedPath <- "data/idaho_housing_data_ss06pid_dateDownloaded.RData"
destFilePath <- "data/idaho_housing_data_ss06pid.csv"
if (file.exists(destFilePath)) {
	cat("Data already downloaded.\n")
	load(dateDownloadedPath)
} else {
	cat("Downloading data to", destFilePath, "\n")
	url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
	download.file(url, destFilePath, method="curl")
	dateDownloaded <- date()
	save(dateDownloaded, file=dateDownloadedPath)
}

if (!file.exists(cbFilePath)) {
	cbFilePath <- "data/2FPUMSDataDict06.pdf"
	cat("Downloading codebook to", cbFilePath, "...\n")
	cbUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
	download.file(cbUrl, destfile=cbFilePath, method="curl")
}

cat("Data downloaded", dateDownloaded, "\n")

cat("Reading data from file ...\n\n")
DT <- fread(destFilePath)

print(mean(DT$pwgtp15,by=DT$SEX))
cat("mean(DT$pwgtp15,by=DT$SEX) produces a single output when we are looking for two.\n\n")

print(DT[,mean(pwgtp15),by=SEX])
cat("DT[,mean(pwgtp15),by=SEX] produces the expected output.\n\n")

print(sapply(split(DT$pwgtp15,DT$SEX),mean))
cat("sapply(split(DT$pwgtp15,DT$SEX),mean) produces the expected output.\n\n")

try(print({rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]}))
cat("{rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]} produces an error.\n\n")

print(tapply(DT$pwgtp15,DT$SEX,mean))
cat("tapply(DT$pwgtp15,DT$SEX,mean) produces the expected output.\n\n")

cat(mean(DT[DT$SEX==1,]$pwgtp15), mean(DT[DT$SEX==2,]$pwgtp15),"\n")
cat("{mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)} produces expected output\n\n")

test_runs = 1000L
cat("So ... only 4 of 6 are candidates for measurement ...\n")
cat("Benchmarking using microbenchmark ...\n")
cat("Running each expression ", test_runs, "times, this may take a moment ...\n")

bench <- microbenchmark (DT[,mean(pwgtp15),by=SEX],
						sapply(split(DT$pwgtp15,DT$SEX),mean),
						tapply(DT$pwgtp15,DT$SEX,mean),
						{mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)},
						times=test_runs)

cat("And the results are:\n")
print(bench)

b <- summary(bench)
m <- min(b$mean)
winner <- b[b$mean==m,]

q5_answer <- paste("The winner is:", as.character(winner$expr))
cat("\n\n", q5_answer, "\n\n\n")



