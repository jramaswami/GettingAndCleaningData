library(dplyr)
gdp <- read.csv("data/getdata_data_GDP.csv",skip=5, header=FALSE, nrows=190)
gdp <- gdp[,c(1,2,4,5)]
names(gdp)<-c("CountryCode", "GdpRank", "GdpCountryName","GdpMillionsUsd")
edstats <- read.csv("data/getdata_data_EDSTATS_Country.csv")
mrgdf <- merge(gdp, edstats)
mrg_t <- tbl_df(mrgdf)
mrg_a <- arrange(mrg_t, desc(GdpRank))
result_nrows <- nrow(mrg_t)
result_country <- as.character(mrg_a[13,]$Long.Name)
cat("The answer to question 3 is", result_nrows, "matches, and",
    result_country, "is the 13th country when GDP rank is in descending order.\n")

g <- tbl_df(gdp)
e <- tbl_df(edstats)
g <- select(g, CountryCode, GdpCountryName, GdpRank)
g <- mutate(g, gdp="G")
e <- select(e, CountryCode, Long.Name)
e <- mutate(e, ed="E")
m <- merge(g,e,all=TRUE)
cat("\n(The row from the gdp data that didn't merge is", as.character(m[is.na(m$ed),2]), ")\n")
#cat ("(The rows from the ed data that didn't merge are", paste(as.character(m[is.na(m$gdp),5]), collapse=", "), ")\n\n")