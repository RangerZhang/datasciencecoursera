#### This README explains how the run_analysis.R works

1. Initialization – I need your help~
  * install the `dplyr` package
  * set the working directory to be `/UCI HAR Dataset`
  * source the `run_analysis.R`
  * Now, you can call `run_analysis()` and it will do all the job for you
    * The whole process takes about 20 seconds on my computer.
    * The result will be stored in `meanOfEverySubjectEveryActivity.txt` under the working directory.
2. Step by Step Analysis
  * **Step 1** - Combines the training and the test sets to create one data set
    * **This step will cost about 15 seconds. When it’s done, there will be messages printed on the console.**
    * training data
      * read in (WARNING：In Windows, `./` means the working directory for the moment. Not sure if this fits Mac. If you fail to see the successful message, pay attention to this.)
        * `./train/X_train`
        * `./train/y_train`
        * `./train/subject_train.txt`
        * `print("Training data: successfully loaded in.")`
      * combine them
        * `X_train` is a 7352*561 data frame, as `subject_train` and `y_train` are both 7352*1.
        * Simply `cbind()` `subject_train` and `y_train` to the left of the X_train.
        * Store the result into a new data frame called `train_combined`.
        * `print("Training data has been successfully combined.")`
    * testing data
      * read in
        * `./test/X_test`
        * `./test/y_test`
        * `./test/subject_test.txt`
        * `print("Testing data: successfully loaded in.")`
      * combine them
        * `X_test` is a 2947*561 data frame, as `subject_test` and `y_test` are both 2947*1.
        * Simply `cbind()` `subject_test` and `y_test` to the left of the X_test.
        * Store the result into a new data frame called `test_combined`.
        * `print("Testing data has been successfully combined.")`
    * combine the training & testing data into one: `rbind()`
      * Store the result into a new data frame called `all_combined`
      * 'print("Training data & testing data: successfully combined.")'
  * **Step 2** - Extracts only the measurements on the mean and standard deviation for each measurement
    * read in the 'features.txt' and name the 'all_combined'
      * When read in `features.txt` with `read.table()`, I set the `as.is = T` so as to keep the content as characters, rather than factors.
      * There are duplicated names in features.txt, such as those ended with `bandsEnergy()`.
        * I leave them unchanged. If you prefer deleting those duplicated ones, you can:
          ```
          noDuplicatedColumnDF = originalDF [, !duplicated(colnames(origianlDF))]
          ```
    * extract mean and std measurements
      * My criteria is that whether the column name contains `mean()` or `std()`.
        * Of course the first 2 column (i.e. `subjectID` & `activityType`) won’t be discarded.
      * Store the result into a new data frame called `all_mean_std`.
  * **Step 3** - Uses descriptive activity names to name the activities in the data set
    * read in the activity_labels.txt
    * name and factorize the original `activityType`-column of `all_mean_std`
  * **Step 4** - Appropriately labels the data set with descriptive variable names
    * make all the column names legal
      * delete `()`
      * replace `-` with `.`
    * make all the column names more descriptive
      * I did nothing.
      * I think the current names are already descriptive. Maybe it can be more descriptive if I change the `t` to `time`, `f` to `frequency` and `Acc` to `Accelerometer`, as one of the TA suggested, but some of the column names will be too long then.
  * **Step 5** - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    * The `dplyr` package is needed. So, load it first.
    * Group the `all_mean_std` by `subjectID` and `activityType`.
    * Summarise the mean of each group.
    * Store the result into a data frame called `meanOfEverySubjectEveryActivity`.
  * **Step 6** – Output the tidy data created in step 5
    * Add `totalMean.` to every calculated column.
    * Output to `meanOfEverySubjectEveryActivity.txt`.
3. Thank you for spending so much time to review my project. If you need any further discussion, just send me an mail: rangerbin@gmail.com.
