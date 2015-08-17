df <- read.csv("data/getdata_data_ss06hid.csv")
logical_v <- df$ACR==3 & df$AGS==6
selected <- df[which(logical_v),]
result <- row.names(selected[1:3,])
cat("The answer to question 1 is ", result, "\n")