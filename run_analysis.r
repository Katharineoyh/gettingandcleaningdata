## Coursera Getting and Cleaning Data Course Project

# run analysis.r script will perform the following on the UCI HAR datasets: 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names.
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## set working directory to the location where the UCI HAR Dataset was unzipped
setwd('/Users/Katharine/datasciencecoursera/UCI HAR Dataset/')

install.packages("data.table")
install.packages("reshape2")

require("data.table")
require("reshape2")

## Read in the data from files

activity_labels <- read.table("./activity_labels.txt")[,2] #imports activity labels

features <- read.table("./features.txt")[,2]  #imports features (data column name)

## Extract only the measurements on the mean and standard deviation for each measurement.
extract_features <- grepl("mean|std", features)

## Read in test data
X_test <- read.table("./test/X_test.txt")  #imports x_test
y_test <- read.table("./test/y_test.txt")  #imports y_test
subject_test <- read.table("./test/subject_test.txt")  #imports subject_test

names(X_test) = features  #Assign column name

## Extract only the measurements on the mean and standard deviation for each measurement.
X_test = X_test[,extract_features]

# Load activity labels
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"

## Combine test datasets
test_data <- cbind(as.data.table(subject_test), y_test, X_test)

# Load and process X_train & y_train data.
X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")

subject_train <- read.table("./train/subject_train.txt")

names(X_train) = features     #Assign column name

# Extract only the measurements on the mean and standard deviation for each measurement.
X_train = X_train[,extract_features]

# Load activity data
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")  #Assign column name
names(subject_train) = "subject"                     #Assign column name

# Combine train datasets
train_data <- cbind(as.data.table(subject_train), y_train, X_train)

## Combine training and test data to create a final data set
data = rbind(test_data, train_data)

id_labels   = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data      = melt(data, id = id_labels, measure.vars = data_labels)

# Apply mean function to dataset using dcast function
tidy_data   = dcast(melt_data, subject + Activity_Label ~ variable, mean)

## Export the tidy dataset
write.table(tidy_data, file = "./tidy_data.txt",row.names=FALSE,sep='\t')
