# Place this file and `UCI HAR Dataset` into `data` folder in your working directory
# Otherwise script will download dataset from the webserver

# Check if the data directory exists and create if it doesn't
if(!file.exists("./data")) {
        dir.create("./data")
# Download and unzip dataset
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        tempFile <- tempfile()
        download.file(fileURL, tempFile)
        unzip(tempFile, exdir = "./data")
}

# Load and process X_test, y_test & Subject data
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt",
                     header = F, stringsAsFactors = F, fill = T)
Y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt",
                     header = F, stringsAsFactors = F, fill = T)
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt",
                      header = F, stringsAsFactors = F, fill = T)
Y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt",
                      header = F, stringsAsFactors = F, fill = T)
Subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", 
                      header = F, stringsAsFactors = F, fill = T)
Subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",
                      header = F, stringsAsFactors = F, fill = T)


# Merging and binding the training and the test sets
Data <- cbind(rbind(Subject_test, Subject_train),
              rbind(Y_test, Y_train),
              rbind(X_test, X_train))

# Load: data column names
features <- read.table("./data/UCI HAR Dataset/features.txt",
                       header = F, stringsAsFactors = F, fill = T)

# Set meaningful names for the first columns
colnames(Data)[1:2] <- c("Subject", "Activity")
# Set names for all other columns, according to features data file
colnames(Data)[3:563] <- features[, 2]

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

# Subset Data to only include columns that have "mean", "std", "Activity" or "Subject", exluding "meanFreq" column
Data <- Data[, grepl("mean()|std()|Activity|Subject", colnames(Data)) & !grepl("meanFreq", colnames(Data))]

# Load: activity labels
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt",
                         header = F, stringsAsFactors = F, fill = T)

# Label the data set with descriptive activity names
Data$Activity <- factor(Data$Activity, levels = activities[, 1], labels = activities[, 2])


# Create a second, independent tidy data set with the average of each variable for each activity and each subject.
library(plyr)
tidyData <- ddply(Data,
                  .(Subject, Activity),
                  .fun=function(x) { colMeans(x[ ,-c(1:2)]) })

# Write out resulting tidy data set into CSV
write.csv(tidyData, "./data/tidydata.txt", row.names = FALSE)
