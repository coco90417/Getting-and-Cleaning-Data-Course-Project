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
  mutate(frequency = ifelse(str_detect(category, "^f"), 1, 0),  # whether or not this is a frequency measure, or time
         body = ifelse(str_detect(category, "Body"), 1, 0), # whether this is a body measurement or gravity
         acc = ifelse(str_detect(category, "Acc"), 1, 0), # whether this is a acceleration or gyroscope
         jerk = ifelse(str_detect(category, "Jerk"), 1, 0), # whether this is a jerk signal or not
         mag = ifelse(str_detect(category, "Mag"), 1, 0), # whether this is a magnitude signal or not
         mean = ifelse(str_detect(category, "mean()"), 1, 0), # whether this is a mean or a sd
         X = ifelse(str_detect(category, "-X"), 1, 0),
         Y = ifelse(str_detect(category, "-Y"), 1, 0),
         Z = ifelse(str_detect(category, "-Z"), 1, 0)
         ) %>%
  gather(direction, directionValue, X:Z) %>%
  select(-c(category, directionValue))

write.table(tidyData, file = "./tidyData.txt", row.name = F)





