library(dplyr)

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
                    contains("mean"), contains("std"), -contains("angle"))

###############################################################################
# Rename all the columns to be more informatively named
###############################################################################
n = names(tdf_data)
# mean columns
n2 <- sub("tBodyAcc.mean\\.\\.\\.", "Mean.EstimatedBody.LinearAcceleration.",n)
n2 <- sub("tGravityAcc.mean\\.\\.\\.", "Mean.Gravitational.LinearAcceleration.",n2)
n2 <- sub("tBodyAccJerk.mean\\.\\.\\.", "Mean.EstimatedBody.Linear.Acceleration.Jerk.",n2)
n2 <- sub("tBodyGyro.mean\\.\\.\\.", "Mean.EstimatedBody.Angular.Acceleration.", n2)
n2 <- sub("tBodyGyroJerk.mean\\.\\.\\.", "Mean.EstimatedBody.Angular.Acceleration.Jerk.", n2)
n2 <- sub("tBodyAccMag.mean\\.\\.", "Mean.EstimatedBody.LinearAcceleration.Magnitude", n2)
n2 <- sub("tGravityAccMag.mean\\.\\.", "Mean.Gravitational.LinearAcceleration.Magnitude", n2)
n2 <- sub("tBodyAccJerkMag.mean\\.\\.", "Mean.EstimatedBody.Linear.Acceleration.Jerk.Magnitude",n2)
n2 <- sub("tBodyGyroMag.mean\\.\\.", "Mean.EstimatedBody.Angular.Acceleration.Magnitude", n2)
n2 <- sub("tBodyGyroJerkMag.mean\\.\\.","Mean.EstimatedBody.Angular.Acceleration.Jerk.Magnitude", n2)
n2 <- sub("fBodyAcc.mean\\.\\.\\.", "Mean.FastFourierTransform.EstimatedBody.LinearAcceleration.", n2)
n2 <- sub("fBodyAcc.meanFreq\\.\\.\\.", "Mean.Frequency.FastFFourierTransform.EstimatedBody.LinearAcceleration", n2)
n2 <- sub("fBodyAccJerk.mean\\.\\.\\.", "Mean.FastFourierTransform.EstimatedBody.Linear.Acceleration.Jerk.",n2)
n2 <- sub("fBodyAccJerk.meanFreq\\.\\.\\.", "Mean.Frequency.FastFourierTransform.EstimatedBody.Linear.Acceleration.Jerk.",n2)
n2 <- sub("fBodyGyro.mean\\.\\.\\.", "Mean.FastFourierTransform.EstimatedBody.Angular.Acceleration.", n2)
n2 <- sub("fBodyGyro.meanFreq\\.\\.\\.", "Mean.Frequency.FastFourierTransform.EstimatedBody.Angular.Acceleration.", n2)
n2 <- sub("fBodyAccMag.mean\\.\\.", "Mean.FastFourierTransform.EstimatedBody.LinearAcceleration.Magnitude", n2)
n2 <- sub("fBodyAccMag.meanFreq\\.\\.", "Mean.Frequency.FastFourierTransform.EstimatedBody.LinearAcceleration.Magnitude", n2)
n2 <- sub("fBodyBodyAccJerkMag.mean\\.\\.", "Mean.FastFourierTransform.EstimatedBody.Linear.Acceleration.Jerk.Magnitude",n2)
n2 <- sub("fBodyBodyAccJerkMag.meanFreq\\.\\.", "Mean.Frequency.FastFourierTransform.EstimatedBody.Linear.Acceleration.Jerk.Magnitude",n2)
n2 <- sub("fBodyBodyGyroMag.mean\\.\\.", "Mean.FastFourierTransform.EstimatedBody.Angular.Acceleration.Magnitude", n2)
n2 <- sub("fBodyBodyGyroMag.meanFreq\\.\\.", "Mean.Frequency.FastFourierTransform.EstimatedBody.Angular.Acceleration.Magnitude", n2)
n2 <- sub("fBodyBodyGyroJerkMag.mean\\.\\.","Mean.FastFourierTransform.EstimatedBody.Angular.Acceleration.Jerk.Magnitude", n2)
n2 <- sub("fBodyBodyGyroJerkMag.meanFreq\\.\\.","Mean.Frequency.FastFourierTransform.EstimatedBody.Angular.Acceleration.Jerk.Magnitude", n2)

# std. dev. columns
n2 <- sub("tBodyAcc.std\\.\\.\\.", "StdDev.EstimatedBody.LinearAcceleration.",n2)
n2 <- sub("tGravityAcc.std\\.\\.\\.", "StdDev.Gravitational.LinearAcceleration.",n2)
n2 <- sub("tBodyAccJerk.std\\.\\.\\.", "StdDev.EstimatedBody.Linear.Jerk.Acceleration.",n2)
n2 <- sub("tBodyGyro.std\\.\\.\\.", "StdDev.EstimatedBody.Angular.Acceleration.", n2)
n2 <- sub("tBodyGyroJerk.std\\.\\.\\.", "StdDev.EstimatedBody.Angular.Acceleration.Jerk.", n2)
n2 <- sub("tBodyAccMag.std\\.\\.", "StdDev.EstimatedBody.LinearAcceleration.Magnitude", n2)
n2 <- sub("tGravityAccMag.std\\.\\.", "StdDev.Gravitational.LinearAcceleration.Magnitude", n2)
n2 <- sub("tBodyAccJerkMag.std\\.\\.", "StdDev.EstimatedBody.Linear.Acceleration.Jerk.Magnitude",n2)
n2 <- sub("tBodyGyroMag.std\\.\\.", "StdDev.EstimatedBody.Angular.Acceleration.Magnitude", n2)
n2 <- sub("tBodyGyroJerkMag.std\\.\\.","StdDev.EstimatedBody.Angular.Acceleration.Jerk.Magnitude", n2)
n2 <- sub("fBodyAcc.std\\.\\.\\.", "StdDev.FastFourierTransform.EstimatedBody.LinearAcceleration.", n2)
n2 <- sub("fBodyAccJerk.std\\.\\.\\.", "StdDev.FastFourierTransform.EstimatedBody.Linear.Jerk.Acceleration.",n2)
n2 <- sub("fBodyGyro.std\\.\\.\\.", "StdDev.FastFourierTransform.EstimatedBody.Angular.Acceleration.", n2)
n2 <- sub("fBodyAccMag.std\\.\\.", "StdDev.FastFourierTransform.EstimatedBody.LinearAcceleration.Magnitude", n2)
n2 <- sub("fBodyBodyAccJerkMag.std\\.\\.", "StdDev.FastFourierTransform.EstimatedBody.Linear.Acceleration.Jerk.Magnitude",n2)
n2 <- sub("fBodyBodyGyroMag.std\\.\\.", "StdDev.FastFourierTransform.EstimatedBody.Angular.Acceleration.Magnitude", n2)
n2 <- sub("fBodyBodyGyroJerkMag.std\\.\\.","StdDev.FastFourierTransform.EstimatedBody.Angular.Acceleration.Jerk.Magnitude", n2)
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
tdf_data <- select(tdf_data, subject, activity.label, 3:81)

###############################################################################
# Summarize data by getting means on all the data cols (3:81)
###############################################################################
tdf_summary <- tdf_data %>%
        group_by(subject, activity.label) %>%
        summarise_each(funs(mean), 3:81)
# clean up names
n <- names(tdf_summary)
n <- n[3:81]
paste("Mean.of.", n, sep="")
n <- c("subject","activity_label",n)
names(tdf_summary) <- n

###############################################################################
# TODO: TIDY DATA!
###############################################################################
