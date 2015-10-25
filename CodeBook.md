Overview
========

Variables of cleaned data
-------------------------

* `activity`: one of six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
* `subject`: subject number 1 through 30
* sensor signals: `tBodyAccMeanX` `tBodyAccMeanY` `tBodyAccMeanZ` `tBodyAccStdX` `tBodyAccStdY` `tBodyAccStdZ` `tGravityAccMeanX` `tGravityAccMeanY` `tGravityAccMeanZ` `tGravityAccStdX` `tGravityAccStdY` `tGravityAccStdZ` `tBodyAccJerkMeanX` `tBodyAccJerkMeanY` `tBodyAccJerkMeanZ` `tBodyAccJerkStdX` `tBodyAccJerkStdY` `tBodyAccJerkStdZ` `tBodyGyroMeanX` `tBodyGyroMeanY` `tBodyGyroMeanZ` `tBodyGyroStdX` `tBodyGyroStdY` `tBodyGyroStdZ` `tBodyGyroJerkMeanX` `tBodyGyroJerkMeanY` `tBodyGyroJerkMeanZ` `tBodyGyroJerkStdX` `tBodyGyroJerkStdY` `tBodyGyroJerkStdZ` `tBodyAccMagMean` `tBodyAccMagStd` `tGravityAccMagMean` `tGravityAccMagStd` `tBodyAccJerkMagMean` `tBodyAccJerkMagStd` `tBodyGyroMagMean` `tBodyGyroMagStd` `tBodyGyroJerkMagMean` `tBodyGyroJerkMagStd` `fBodyAccMeanX` `fBodyAccMeanY` `fBodyAccMeanZ` `fBodyAccStdX` `fBodyAccStdY` `fBodyAccStdZ` `fBodyAccJerkMeanX` `fBodyAccJerkMeanY` `fBodyAccJerkMeanZ` `fBodyAccJerkStdX` `fBodyAccJerkStdY` `fBodyAccJerkStdZ` `fBodyGyroMeanX` `fBodyGyroMeanY` `fBodyGyroMeanZ` `fBodyGyroStdX` `fBodyGyroStdY` `fBodyGyroStdZ` `fBodyAccMagMean` `fBodyAccMagStd` `fBodyBodyAccJerkMagMean` `fBodyBodyAccJerkMagStd` `fBodyBodyGyroMagMean` `fBodyBodyGyroMagStd` `fBodyBodyGyroJerkMagMean` `fBodyBodyGyroJerkMagStd`, where:
  - prefix `t` denotes time
  - prefix `f` denotes frequency domain
  - `body` denotes body signal
  - `gravity` denotes gravity signal
  - `acc` denotes signal from accelerometer
  - `gyro` denotes signal from gyroscope
  - `jerk` denotes Jerk signal
  - `mag` denotes magnitude
  - `mean` denotes a median value
  - `std` denotes standard deviation
  - `X`, `Y` and `Z` denote direction (axis)

See `UCI HAR Dataset/features_info.txt` for more details.
  
Data
----

Human Activity Recognition Using Smartphones Dataset Version 1.0
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

* 3 files each for training and test:
    + A 561-feature vector with time and frequency domain variables (`<DATASET_NAME>/X_<DATASET_NAME>.txt`)
    + Activity code vector (`<DATASET_NAME>/y_<DATASET_NAME>.txt`)
    + Subject ID vector (`<DATASET_NAME>/subject_<DATASET_NAME>.txt`)
* Information about the variables used on the feature vector (`features_info.txt`)
* Feature list (`features.txt`)
* Activity labels linking the class labels with their activity name (`activity_labels.txt`)

### Notes:

- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

Data Transformations
--------------------

* Extracted only measurements on the mean and standard deviation for
  each measurement.
* Translated activity numerical values into descriptive names.
* Combined subject, activity and features of all measurements from specific datasets.
* Labeled data sets with descriptive variable names:
  - Replaced dashes from sensor signal names with `camelCaseValue`
  - Removed all non-letter characters.
* Merged training and the test sets into one data set.

See `run_analysis.R` for more details.