# Getting and Cleaning Data Course Project

The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

`run_analysis.R` script performs the following: 

1. Donloads data from `https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip` and unzips it to `./data` folder
2. Using `read.table` function script loads data from files for Subject, X and Y variables.
3. Test and train datasets are merged with `rbind` function.
4. Subject, Activity and Measurements datasets are mergerd into the general dataset using `cbind` function.
5. Columns of the dataset are given descriptive and appropriate labels from `features.txt`
6. Extracts only the measurements on the mean and standard deviation for each measurement by substracting all column names containing "mean" or "std" with `grepl` function.
7. Labels the data set with descriptive activity names from `activity_labels.txt`
8. Creates a second, independent tidy data set with the average of each variable for each activity and each subject with `ddply` function from `plyr` package.
9. Writes out resulting tidy dataset as a CSV file names `./data/tidydata.txt`.

## Dependencies

```run_analysis.R``` file depends on ```plyr``` package and requires it for correct work.  
