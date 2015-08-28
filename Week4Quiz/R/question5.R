library(quantmod)
library(lubridate)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
d <- ymd(sampleTimes)
y2015 <- d[year(d) == 2012]
y2015dMon <- y2015[wday(y2015,label=TRUE)=='Mon']
cat ("The answer to question 5 is there are", length(y2015), "values from 2015 ")
cat ("and", length(y2015dMon), "values from Mondays in 2015.\n")