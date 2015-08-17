library(dplyr)
gdp <- read.csv("data/getdata_data_GDP.csv",skip=5, header=FALSE, nrows=190)
gdp <- gdp[,c(1,2,4,5)]
names(gdp)<-c("CountryCode", "GdpRank", "GdpCountryName","GdpMillionsUsd")
edstats <- read.csv("data/getdata_data_EDSTATS_Country.csv")
mrgdf <- merge(gdp, edstats)
mrg_t <- tbl_df(mrgdf)
result <- mrg_t %>% 
                group_by(Income.Group) %>% 
                summarize(meanGdpRank = mean(GdpRank)) %>% 
                filter(Income.Group %in% c("High income: nonOECD", "High income: OECD")) %>%
                arrange(meanGdpRank)
cat("The answer to question 4 is: \n")
print(result)
cat("\n")