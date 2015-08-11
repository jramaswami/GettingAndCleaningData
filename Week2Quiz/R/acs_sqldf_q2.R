library(sqldf)

acs <- read.csv("data/american-community-survey-data.csv")
data <- sqldf("select pwgtp1 from acs where AGEP < 50")

