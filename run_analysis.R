# You should create one R script called run_analysis.R that does the following.
# 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# load library ------------------------------------------------------------
rm(list = ls())

library(dplyr)
library(tidyr)
library(readr)
library(stringr)

# data download --------------------------------------------

setwd("C:/Users/cd433676/Documents/Coursera/dataCleaning/project/")
sourceUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destPath <- "UCI HAR Dataset"
destFile <- "UciHarDataset.zip"

if(!file.exists(destFile)) {
  download.file(url = sourceUrl, destfile = destFile)
}


# data extraction ---------------------------------------------------------

if(!file.exists(destPath)) {
  unzip(zipfile = destFile, exdir = ".")
}


# data loading ------------------------------------------------------------
activityLabels <- read_table2(paste0(destPath, "/activity_labels.txt"), col_names = F)
features <- read_table2(paste0(destPath, "/features.txt"), col_names = F)

subjectTrain <- read_table2(paste0(destPath, "/train/subject_train.txt"), col_types = "i", col_names = F)
xTrain <- read_table2(paste0(destPath, "/train/X_train.txt"), col_names = F)
yTrain <- read_table2(paste0(destPath, "/train/y_train.txt"), col_types = "i", col_names = F)


subjectTest <- read_table2(paste0(destPath, "/test/subject_test.txt"), col_types = "i", col_names = F)
xTest <- read_table2(paste0(destPath, "/test/X_test.txt"), col_names = F)
yTest <- read_table2(paste0(destPath, "/test/y_test.txt"), col_types = "i", col_names = F)

# merge training and testing dataset --------------------------------------

dataSet <- bind_rows(xTrain, xTest)
dataY <- bind_rows(yTrain, yTest)
dataSubject <- bind_rows(subjectTrain, subjectTest)

# extract only the measurements on means and sd of each measurement -------

indexOfMeanSd <- features %>%
  filter(str_detect(X2, "mean|std")) 

dataSetMeanSd <- dataSet[, indexOfMeanSd$X1]

# use descriptive activity names to name the activity in the datas --------

dataY$X1 <- factor(dataY$X1)
levels(dataY$X1) <- activityLabels$X2

# appropriately label the data set with descriptive variable names --------

names(dataSetMeanSd) <- indexOfMeanSd$X2
names(dataY) <- "activity"
names(dataSubject) <- "subject"

# create a second, independent tidy dataset --------

dataCombined <- bind_cols(dataSubject, dataY, dataSetMeanSd)
tidyData <- dataCombined %>% 
  gather(category, value, -c(subject, activity)) %>%
  group_by(subject, activity) %>%
  summarise(average = mean(value, rm.na = TRUE))

save(tidyData, file = "./tidyData.RData")


















