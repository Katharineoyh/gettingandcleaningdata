## Getting and Cleaning Data Course Project

# Steps to work on this course project

Download the data source and put into a folder on working directory. You'll have a UCI HAR Dataset folder.
Set it as your working directory using setwd() function in RStudio.

# A R script called run_analysis.R is created to carry out the following tasks.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
6. Run source("run_analysis.R"), then it will generate a new file tiny_data.txt in your working directory.

# Dependencies

run_analysis.r file will help to install the dependencies automatically. It depends on reshape2 and data.table.

# How run_analysis.R implements the above steps:

1. Require reshape2 and data.table libraries.
2. Load both test and train data.
3. Load the features and activity labels.
4. Extract the mean and standard deviation column names and data.
5. Process the data. There are two parts processing test and train data respectively.
6. Merge data set.

