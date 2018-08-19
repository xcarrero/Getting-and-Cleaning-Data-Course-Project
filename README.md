# Getting-and-Cleaning-Data-Course-Project

## Objectives:
* Merge the training and the test sets to create one data set.
* Extract only the measurements on the mean and standard deviation for each measurement.
* Use descriptive activity names to name the activities in the data set
* Appropriately label the data set with descriptive variable names.
* From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

## This R script called run_analysis.R does the above by:
* Downloading the data file
* Unzipping the data file
* Loading all source data
* Creating a features filter
* Merging test and train data
* Labeling merged data
* Reshaping merged data
* Exporting tidy dataset
