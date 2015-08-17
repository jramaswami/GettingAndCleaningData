library(dplyr)
gdp <- read.csv("data/getdata_data_GDP.csv",skip=5, header=FALSE, nrows=190)
gdp <- gdp[,c(1,2,4,5)]
names(gdp)<-c("CountryCode", "GdpRank", "GdpCountryName","GdpMillionsUsd")
edstats <- read.csv("data/getdata_data_EDSTATS_Country.csv")
mrgdf <- merge(gdp, edstats)
mrg_t <- tbl_df(mrgdf)
result <- mrg_t %>% 
        select(CountryCode, GdpRank, GdpCountryName, Income.Group) %>%
        mutate(GdpRankQuintile=ntile(GdpRank, 5)) %>% 
        filter(GdpRankQuintile==1, Income.Group=="Lower middle income") %>%
        print
cat ("\n\nThe answer to question 5 is that there are", nrow(result),
     "countries in the Lower middle income that are among the 38 nations",
     "with the highest GDP.")