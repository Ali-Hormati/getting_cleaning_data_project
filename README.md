# Getting and Cleaning Data Course Project



The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

The R script, named run_analysis.R does the following:

1. Download the dataset (if not already loaded)
2. Load the features and activity data sets
3. Load train and test data sets and keep only those measurements which includes mean and std 
4. Merge the activity and subject columns with the train set, columnwise
5. Merge the activity and subject columns with the test set, columnwise
6. Merge train and test sets, rowwise
7. Converts the activity variables into factors
8. Creates a tidy dataset that consists of the average of each
   measurement selected above for each subject and activity pair. Saving the result in tidy.txt
