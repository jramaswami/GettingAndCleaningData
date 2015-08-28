library(dplyr)
# download data
if (!dir.exists("data")) {
        dir.create("data")
}

gdpDataFilePath = "data/GDP.csv"
edDataFilePath = "data/EDSTATS_Country.csv"
if (!file.exists(gdpDataFilePath)) {
        gdpDataFileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
        download.file(gdpDataFileUrl, gdpDataFilePath, method="curl")
}
if (!file.exists(edDataFilePath)) {
        edDataFileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
        download.file(edDataFileUrl, edDataFilePath, method="curl")
}

gdp <- read.csv(gdpDataFilePath,skip=5, header=FALSE, nrows=190)
gdp <- gdp[,c(1,2,4,5)]
names(gdp)<-c("CountryCode", "GdpRank", "GdpCountryName","GdpMillionsUsd")
edstats <- read.csv(edDataFilePath, encoding="UTF-8")
mrgdf <- merge(gdp, edstats)
juneEnd <- mrgdf[grep("Fiscal year end: June", mrgdf$Special.Notes),]
x <-nrow(juneEnd)
cat ("The answer to question 4 is", x, "countries have a fiscal year ending in June.\n")

