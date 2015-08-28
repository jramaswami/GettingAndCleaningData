# download data
if (!dir.exists("data")) {
        dir.create("data")
}

dataFilePath = "data/ss06hid.csv"
if (!file.exists(dataFilePath)) {
        dataFileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
        download.file(dataFileUrl, dataFilePath, method="curl")
}

# load data
df <- read.csv(dataFilePath)

# answer quiz question
ndf <- names(df)
s <- strsplit(ndf, "wgtp")
cat("The answer to question 1 is the value of 123 element is:\n ")
print(s[123])
cat("\n")
