# CodeBook

This codebook modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.

## Source data

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.

A full description is available at the site where the data was obtained [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones )

Data for the project can be obtained [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Description

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

## Files used in the original dataset

1. 'features_info.txt': Shows information about the variables used on the feature vector.
2. 'activity_labels.txt': Links the class labels with their activity name.
3. 'X_train.txt': Training set.
4. 'y_train.txt': Training labels.
5. 'subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
6. 'X_test.txt': Test set.
7. 'y_test.txt': Test labels.
8. 'subject_test.txt': Each row identifies the subject who performed the activity for each window sample for the test set. Its range is from 1 to 30.

## Data transformation

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## Resulting data

Resulting data is stored in 'tidyData.RData' and can be loaded into R using the following command:

```
load('tidyData.RData')
tidyData
```

tidyData is a tibble formated dataset, please see [here](https://cran.r-project.org/web/packages/tibble/vignettes/tibble.html) for more details about tibble format. 

## Variables

1. subject: it is an integer that describes the ID of the subject.
2. activity: it is a factor that describes the type of activity of the corresponding subject.
3. average: it is a float that describes the average value of the mean of the activity of the corresponding subject.


 
