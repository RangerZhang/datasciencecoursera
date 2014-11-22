###Input - Data Source
  * What is it?
    * This dataset contains readings of the accelerometer and gyroscope of smartphones on 30 subjects' waist. 
  * Where was it downloaded from?
    * Origianl source: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  * basic information
    * 10299 instances
    * 561-feature vector with time and frequency domain variables
    * ID of each subect and the activities she was doing when the readings were recorded
  * more infomation
    * For more infomation about the dataset, ***especially the meaning, units and format of each variable***, please turn to http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  
###Process
  * Goal
    * Creates a tidy data set with the average of each `mean` and `std` variable for each activity and each subject
  * What did I do?
    * Combines the training and the test sets into one.
      * ID of subjects and activity type were also merged.
    * Name the columns of the data with `features.txt`.
    * Extract columns whose name contains `mean()` or `std()`.
    * Name and factorize the `activityType`-column with `activity_labels.txt`
    * Modify some illegal column names.
      * delete `()`
      * replace `-` with `.`
    * Using `summarise_each()` to calculate the average of each variable for each activity and each subject
    * Add `totalMean.` to the name of every calculated column

###Output
  * output file
    * file name: `meanOfEverySubjectEveryActivity.txt`
    * attribute
      * 1st column - subjectID: ID of the subject
      * 2nd column - activityType: one of the 6 different activity types (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
      * all the left columns: mean of the variable of the corresponding subject and activity
       * ***the original meaning, units and format of each variable***, please turn to http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  * How to read in the output file? 
    * ```read.table("meanOfEverySubjectEveryActivity.txt", header = T)```
