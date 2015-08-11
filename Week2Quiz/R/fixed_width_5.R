widths <- c(1, 9, 5, 4, 4, 5, 4, 4, 5, 4, 4, 5, 4, 4)
colnames <- c("junk1", "Week", "junk2", "Nino1+2 SST", "Nino1+2 SSTA",
			  "junk3", "Nino3 SST", "Nino3 SSTA", "junk4", "Nino34 SST",
			  "Nino34 SSTA", "junk5", "Nino4 SST", "Nino4 SSTA")
data <- read.fwf("data/wksst8110.for", skip=4, width=widths, 
				 col.names=colnames)
data <- data[-c(1,3,6,9,12)]
answer <- sum(data[,4])
cat("The answer to question 5 is", answer, "\n")

