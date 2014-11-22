run_analysis <- function(){
	
	# Step-1: Combines the training and the test sets to create one data set
	# read in the training data
	X_train <- read.table("./train/X_train.txt")
	y_train <- read.table("./train/y_train.txt")
	subject_train <- read.table("./train/subject_train.txt")
	print("Training data: sucessfully load in.")

	# combine the training data
	train_combined <- cbind(subject_train, y_train, X_train)
	print("Training data: sucessfully combined.")

	# read in the testing data
	X_test <- read.table("./test/X_test.txt")
	y_test <- read.table("./test/y_test.txt")
	subject_test <- read.table("./test/subject_test.txt")
	print("Testing data: sucessfully load in.")

	# combine the testing data
	test_combined <- cbind(subject_test, y_test, X_test)
	print("Testing data: sucessfully combined.")

	# combine all into one
	all_combined <- rbind(train_combined, test_combined)
	print("Step-1 is successful.")



	# Step-2: Extracts only the measurements on the mean and standard deviation for each measurement
	# read in the features.txt & name the all_combined
	features <- read.table("./features.txt", as.is = T)  # "as.is <- T" keeps all the column as character
	features <- features[, 2]  # we only need names
	colnames(all_combined) <- c("subjectID", "activityType", features)  # name the all_combined

	# extract those columns whose name contains "mean()" or "std"
	# first two columns will be reserved
	all_mean_std <- all_combined[, grepl("subjectID|activityType|mean\\(\\)|std\\(\\)", colnames(all_combined), ignore.case = T)]
	print("Step-2 is successful.")



	# Step-3: Uses descriptive activity names to name the activities in the data set
	# read in the activity_labels.txt 
	activity_labels <- read.table("activity_labels.txt", as.is = T)

	# name and factorize the original activityType-column of all_mean_std
	all_mean_std$activityType <- factor(all_mean_std$activityType, labels = activity_labels[,2])
	print("Step-3 is successful.")



	# Step-4: Appropriately labels the data set with descriptive variable names.
	# delete "()"
	colnames(all_mean_std) <- gsub("\\(\\)", "", colnames(all_mean_std))
	# replace "-" with "."
	colnames(all_mean_std) <- gsub("-", ".", colnames(all_mean_std))
	print("Step-4 is successful.")



	# Step-5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	# load the dplyr-package
	require("dplyr")
	# summarise the mean of each group
	meanOfEverySubjectEveryActivity <-
		(
			all_mean_std %>%
			group_by(subjectID, activityType) %>%  # group by  subjectID and activityType
			summarise_each(funs(mean))
		)
	print("Step-5 is successful.")



	# Step-6: output the tidy data created in step5
	# add "totalMean." to every calculated column
	newNames <- colnames(meanOfEverySubjectEveryActivity)
	newNames[3:length(newNames)] <- paste("totalMean", newNames[3:length(newNames)], sep = ".")
	colnames(meanOfEverySubjectEveryActivity) <- newNames

	# output
	write.table(meanOfEverySubjectEveryActivity, "meanOfEverySubjectEveryActivity.txt", row.names = F)
	print("All done. The tidy data is stored in '~/meanOfEverySubjectEveryActivity.txt'")
}