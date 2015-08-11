library(sqldf)

acs <- read.csv("data/american-community-survey-data.csv")

distinct <- sqldf("select distinct AGEP from acs")
unique <- unique(acs$AGEP)
identical(unique, as.vector(t(distinct)))

