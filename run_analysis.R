library(dplyr)
library(reshape2)

## download and unzip the data file
filename <- "uci.zip"
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists(filename)){
        download.file(url, filename, method = "curl")
}

if (!file.exists("UCI HAR Dataset")) {
        unzip(filename)
}

## Load data and features
act_labels <-  read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])


## look for features with mean and std in them 
meanstdfeatures <- grep(".*std*|.*mean.*", features[,2])
meanstdfeatures_names <- features[meanstdfeatures,2]
meanstdfeatures_names <- gsub('[()]', '', meanstdfeatures_names)


# Load the train dataset
train <- read.table("UCI HAR Dataset/train/X_train.txt", stringsAsFactors = FALSE)[ ,meanstdfeatures]
trainact <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainsub <- read.table("UCI HAR Dataset/train/subject_train.txt")
train_cbinded <- cbind(trainsub, trainact, train)

# Load the test dataset
test <- read.table("UCI HAR Dataset/test/X_test.txt", stringsAsFactors = FALSE)[ ,meanstdfeatures]
testact <- read.table("UCI HAR Dataset/test/Y_test.txt")
testsub <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_cbinded <- cbind(testsub, testact, test)

# merge all
merged_train_test <- rbind(train_cbinded, test_cbinded)
colnames(merged_train_test) <- c("subject", "activity", meanstdfeatures_names)

merged_train_test$activity <- factor(merged_train_test$activity, levels = act_labels[,1], labels = act_labels[,2])

merged_train_test_tbl <- tbl_df(merged_train_test)

merged_train_test_grouped_tbl <- group_by(merged_train_test_tbl, subject, activity)

merged_mean <- summarize_all(merged_train_test_grouped_tbl, mean)

write.table(merged_mean, "tidy.txt", row.names = FALSE, quote = FALSE)
