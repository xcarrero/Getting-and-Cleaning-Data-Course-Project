# Getting and Cleaning Data Course Project

# Preps
library(reshape2)

# Inits
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileName <- "getdata_projectfiles_UCI HAR Dataset.zip"

# Download data file
if(!file.exists(fileName)){
  download.file(fileURL,fileName)
}

# Unzip data file
if(!file.exists("UCI HAR Dataset")) { 
  unzip(fileName) 
}

# Load all data
testData <- read.table("UCI HAR Dataset/test/X_test.txt")
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
trainData <- read.table("UCI HAR Dataset/train/X_train.txt")
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

# Create features filter
featuresFilter <- grep(".*-mean().*|.*-std().*",features[,2])
featuresFilterNames <- features[featuresFilter,2]
featuresFilterNames <- gsub('mean\\(\\)','Mean',featuresFilterNames)
featuresFilterNames <- gsub('std\\(\\)','Std',featuresFilterNames)
featuresFilterNames <- gsub('[-]','',featuresFilterNames)

# Merge test and train data
testData <- testData[featuresFilter]
testData <- cbind(testSubjects,testActivities,testData)
trainData <- trainData[featuresFilter]
trainData <- cbind(trainSubjects,trainActivities,trainData)
mergedData <- rbind(testData,trainData)

# Label merged data
colnames(mergedData) <- c("subject","activity",featuresFilterNames)

# Reshape merged data
mergedData$subject <- as.factor(mergedData$subject)
mergedData$activity <- factor(mergedData$activity,levels=activities[,1],labels=activities[,2])
mergedDataMelted <- melt(mergedData,id=c("subject","activity"),measure.vars=featuresFilterNames)
mergedDataMean <- dcast(mergedDataMelted,subject + activity ~ variable,mean)

# Export tidy dataset
write.table(mergedDataMean,"tidydataset.txt",row.names=FALSE,quote=FALSE)