# download data
if (!dir.exists("data")) {
        dir.create("data")
}

dataFilePath = "data/GDP.csv"
if (!file.exists(dataFilePath)) {
        dataFileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
        download.file(dataFileUrl, dataFilePath, method="curl")
}

# load data
df <- read.csv(dataFilePath, skip=4, nrows=190, encoding="UTF-8")
df <- df[, c(1,2,4,5)]
names(df) <- c("countrycode","rank", "countryname","gdp")
df$gdpclean <- as.numeric(gsub(",", "", df$gdp))
m <- mean(df$gdpclean)
cat("The answer to question 2 is the mean value  of the 190 ranked GDPs in millions of USD is", m, ".\n")

united <- grep("^United", df$countryname)
cat ("The answer to question 3 is the following expression 'grep(\"^United\", df$countryName),")
cat ("will tell you the number of countries that start with 'United'.  There are ")
cat (length(united), "of them.\n")
