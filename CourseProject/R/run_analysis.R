library(dplyr)
library(stringr)
library(reshape2)

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
        # input type -- Time or Fast Fourier Transform
        inputType = "Unknown_Input_Type"
        if (substring(cname, 0, 1) == "f") {
                inputType = "Fast_Fourier_Transform"
        } else if (substring(cname, 0, 1) == "t") {
                inputType = "Time"
        }
        
        # acceleration component -- Body or Gravity
        accelerationComponent = "Unknown_Acceleration_Component"
        if (str_detect(cname, "Body")) {
                accelerationComponent = "Estimated_Body"
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
        
        newName <- paste(measure, inputType, accelerationComponent, accelerationType, vectorCharacteristic, sep=".")
        newName
}

selectColumnName <- function(value, index) {
        
}

###############################################################################
# Read and clean data
###############################################################################

# read the names of the x data columns
x_names <- read.table(file.path("data", "UCI\ HAR\ Dataset", "features.txt"))

# read train x data
x_train <- read.table(file.path("data", "UCI\ HAR\ Dataset", 
                               "train", "X_train.txt"))
names(x_train) <- make.names(as.vector(x_names[,2]), unique=TRUE)
#read train y data
y_train <- read.table(file.path("data", "UCI\ HAR\ Dataset", 
                               "train", "y_train.txt"))
names(y_train) <- c("activity.code")

# read train subject data
subj_train <- read.table(file.path("data", "UCI\ HAR\ Dataset", 
                                  "train", "subject_train.txt"))
names(subj_train) <- c("subject")

# bind all the columns together to create full training dataset
df_train <- cbind(subj_train, y_train, x_train)
rm(subj_train, y_train, x_train)
tdf_train <- tbl_df(df_train)
rm(df_train)

# read test x data
x_test <- read.table(file.path("data", "UCI\ HAR\ Dataset", 
                        "test", "X_test.txt"))
names(x_test) <- make.names(as.vector(x_names[,2]), unique=TRUE)

# read test y data
y_test <- read.table(file.path("data", "UCI\ HAR\ Dataset", 
                        "test", "y_test.txt"))
names(y_test) <- c("activity.code")

# read test subject data
subj_test <- read.table(file.path("data", "UCI\ HAR\ Dataset", 
                           "test", "subject_test.txt"))
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
                    contains("mean"), contains("std"), -contains("angle"), -contains("meanFreq"))

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
activity_labels <- read.table(file.path("data", "UCI HAR Dataset", "activity_labels.txt"))
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
# Summarize data by getting means on all the data cols (3:81)
###############################################################################
# tdf_summary <- tdf_data %>%
#         group_by(subject, activity.label) %>%
#         summarise_each(funs(mean), 3:81)
# # clean up names
# n <- names(tdf_summary)
# n <- n[3:81]
# paste("Mean.of.", n, sep="")
# n <- c("subject","activity_label",n)
# names(tdf_summary) <- n

###############################################################################
# TODO: TIDY DATA!
###############################################################################
tidy <- melt(tdf_data, id.vars = c("subject", "activity.label"))
tidy$descriptive.statistic <- word(tidy$variable, 1, sep=fixed("."))
tidy$input.type <- word(tidy$variable, 2, sep=fixed("."))
tidy$acceleration.component <- word(tidy$variable, 3, sep=fixed("."))
tidy$acceleration.type <- word(tidy$variable, 4, sep=fixed("."))
tidy$vector.characteristic <- word(tidy$variable, 5, sep=fixed("."))
tidy <- select(tidy, subject, activity.label, descriptive.statistic, 
               input.type, acceleration.component, acceleration.type, 
               vector.characteristic, value)
tidy <- tbl_df(tidy)
tdf_summary <- tidy %>%
        group_by(subject, activity.label, 
                 descriptive.statistic, input.type,
                 acceleration.component, acceleration.type,
                 vector.characteristic) %>%
        summarize(mean.value=mean(value))