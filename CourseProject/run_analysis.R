library(dplyr)
library(stringr)
library(reshape2)

inputDataDir = file.path("UCI HAR Dataset")
outputDataDir = file.path(".")

###############################################################################
# Function to rename columns
###############################################################################
nameColumn <- function(cname) {
        # measure -- Mean or Std. Dev.
        measure = "Uknown_Measure"
        if (str_detect(cname, "\\.std")) {
                measure = "Standard_Deviation"
        } else if (str_detect(cname, "\\.mean")) {
                measure = "Mean"
        }
        # signal domain -- Time or Frequency
        signalDomain = "Unknown_Signal_Domain"
        if (substring(cname, 0, 1) == "f") {
                signalDomain = "Frequency"
        } else if (substring(cname, 0, 1) == "t") {
                signalDomain = "Time"
        }
        
        # acceleration component -- Body or Gravity
        accelerationComponent = "Unknown_Acceleration_Component"
        if (str_detect(cname, "Body")) {
                accelerationComponent = "Body"
        } else if (str_detect(cname, "Gravity")) {
                accelerationComponent = "Gravity"
        }
        
        
        # acceleration type -- Linear, Angular, Linear Jerk, Angular Jerk
        accelerationType = "Unknown_Acceleration_Type"
        if (str_detect(cname, "Acc")) {
                accelerationType = "Linear"
        } else if (str_detect(cname, "Gyro")) {
                accelerationType = "Angular"
        }
        if (str_detect(cname, "Jerk")) {
                accelerationType = paste(accelerationType, "Jerk", sep="_")
        }
        
        # vector characteristic -- X, Y, Z, Magnitude
        vectorCharacteristic = "Uknown_Vector_Characteristic"
        if (str_detect(cname, "Mag")) {
                vectorCharacteristic = "Magnitude"
        } else if (str_detect(cname, "\\.X")) {
                vectorCharacteristic = "X"
        } else if (str_detect(cname, "\\.Y")) {
                vectorCharacteristic = "Y"
        } else if (str_detect(cname, "\\.Z")) {
                vectorCharacteristic = "Z"
        }
        
        newName <- paste(measure, signalDomain, accelerationComponent, accelerationType, vectorCharacteristic, sep=".")
        newName <- str_to_upper(newName)
        newName
}

###############################################################################
# Read and clean data
###############################################################################

# read the names of the x data columns
x_names <- read.table(file.path(inputDataDir, "features.txt"))

# read train x data
x_train <- read.table(file.path(inputDataDir, "train", "X_train.txt"))
names(x_train) <- make.names(as.vector(x_names[,2]), unique=TRUE)
#read train y data
y_train <- read.table(file.path(inputDataDir, "train", "y_train.txt"))
names(y_train) <- c("activity.code")

# read train subject data
subj_train <- read.table(file.path(inputDataDir, "train", "subject_train.txt"))
names(subj_train) <- c("subject")

# bind all the columns together to create full training dataset
df_train <- cbind(subj_train, y_train, x_train)
rm(subj_train, y_train, x_train)
tdf_train <- tbl_df(df_train)
rm(df_train)

# read test x data
x_test <- read.table(file.path(inputDataDir, "test", "X_test.txt"))
names(x_test) <- make.names(as.vector(x_names[,2]), unique=TRUE)

# read test y data
y_test <- read.table(file.path(inputDataDir, "test", "y_test.txt"))
names(y_test) <- c("activity.code")

# read test subject data
subj_test <- read.table(file.path(inputDataDir, "test", "subject_test.txt"))
names(subj_test) <- c("subject")

# bind all the columns together to create full test dataset
df_test <- cbind(subj_test, y_test, x_test)
rm(subj_test, y_test, x_test, x_names)
tdf_test <- tbl_df(df_test)
rm(df_test)

# bind rows from both datasets together
tdf_data <- rbind(tdf_test, tdf_train) 
rm(tdf_test, tdf_train)

# Select columns for analysis: subject, activity code, mean and std. dev. columns.
# Exclude angle columns because they are actually measures of the angles between
# the mean measures, not a mean measure.
tdf_data <- select(tdf_data, subject, activity.code,
                    contains("mean"), contains("std"), 
                   -contains("angle"), -contains("meanFreq"))

###############################################################################
# Rename all the columns to be more informatively named
###############################################################################
n = names(tdf_data)
n2 <- as.character(sapply(n[-c(1:2)], nameColumn))
n2 <- c(n[1:2], n2)
names(tdf_data) <- n2
rm(n, n2)

###############################################################################
# Add in meaningful activity labels
###############################################################################
# read activity labels
activity_labels <- read.table(file.path(inputDataDir, "activity_labels.txt"))
names(activity_labels) <- c("activity.code", "activity.label")
activity_labels <- tbl_df(activity_labels)
# merge activity labels into data
tdf_data <- merge(tdf_data, activity_labels)
rm(activity_labels)
# turn tdf_data back into a tbl_df; merge makes it a data.frame
tdf_data <- tbl_df(tdf_data)
# rearrange data
tdf_data <- select(tdf_data, subject, activity.label, 3:68)

###############################################################################
# Tidy Data
###############################################################################
tidy <- melt(tdf_data, id.vars = c("subject", "activity.label"))
tidy$descriptive.statistic <- as.factor(word(tidy$variable, 1, sep=fixed(".")))
tidy$signal.domain <- as.factor(word(tidy$variable, 2, sep=fixed(".")))
tidy$acceleration.component <- as.factor(word(tidy$variable, 3, sep=fixed(".")))
tidy$acceleration.type <- as.factor(word(tidy$variable, 4, sep=fixed(".")))
tidy$vector.characteristic <- as.factor(word(tidy$variable, 5, sep=fixed(".")))
tidy <- select(tidy, subject, activity.label, descriptive.statistic, 
               signal.domain, acceleration.component, acceleration.type, 
               vector.characteristic, value)
tidy <- tbl_df(tidy)
rm(tdf_data)
###############################################################################
# Summarize data
###############################################################################
summary <- tidy %>%
        group_by(subject, activity.label, 
                 descriptive.statistic, signal.domain,
                 acceleration.component, acceleration.type,
                 vector.characteristic) %>%
        summarize(mean.value=mean(value))

###############################################################################
# Output data
###############################################################################
if (!dir.exists(file.path(outputDataDir))) {
        dir.create(file.path(outputDataDir))
}
write.table(summary, file.path(outputDataDir,"summary.dat"),row.names=FALSE)