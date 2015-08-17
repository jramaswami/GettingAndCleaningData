library("jpeg")
jpg.img <- readJPEG("data/getdata_jeff.jpg",native=TRUE)
result <- quantile(jpg.img, c(0.3,0.8))
cat("The answer to question 2 is ", result, "\n")
