The run_analysis.R script performs the following steps, as described in the course project description.
	1. Download the dataset
	Dataset downloaded and unzipped. The files can be found in UCI HAR Dataset.
	2. Achieve each table and assign each data to a variable
	    feature has 561 rows, 2 columns, and comes from the accelerometer and gyroscope’s raw signals.
	    activity has 6 rows, 2 columns , and contains activities and their codes.
	    subjectInTest has 2947 rows, 1 column, and contains test data of test subjects.
      xInTest has 2947 rows, 561 columns ,and contains recorded features
      yInTest has 2947 rows, 1 columns ,and contains test data of activity	    subjectInTrain has 7352 rows, 1 column, and contains train data    
      xInTrain has 7352 rows, 561 columns, and contains recorded features train data
      yInTrain has 7352 rows, 1 columns , and contains train data of activitiy
	3.Merges the training and the test sets to create one data set
	    Xbind (10299 rows, 561 columns) is created by merging xInTrain and xInTest using rbind() 
      Ybind (10299 rows, 1 column) is created by merging yInTrain and yInTest using rbind() 
      Subjectbind (10299 rows, 1 column) is created by merging subjectInTrain and subjectInTest     using rbind()
	    Allbind(10299 rows, 563 column) is created by merging Subjectbind, Ybind and Xbind using cbind() function
	4. Extracts only the measurements on the mean and standard deviation for each measurement
	    ExtractData (10299 rows, 88 columns) is created by subsetting Allbind, selecting only columns: subject, code and the measurements on the mean and standard deviation for each measurement
	5. Uses descriptive activity names to name the activities in the data set
	   Entire numbers in code column of the ExtractData replaced with corresponding activity taken from second column of the activity variable
	6. Appropriately labels the data set with descriptive variable names
	 code column in ExtractData renamed into activity
	 All Acc in column’s name replaced by Accelerometer
	 All Gyro in column’s name replaced by Gyroscope
	 All BodyBody in column’s name replaced by Body
	 All Mag in column’s name replaced by Magnitude
	 All start with character f in column’s name replaced by Frequency
	 All start with character t in column’s name replaced by Time
	7.Creates a second, independent tidy data set with the average of each variable for each activity and each subject
	 Output (180 rows, 88 columns) is created by summarizing ExtractData taking the means of each variable for each activity and each subject, after group_by subject and activity.
	8.Export Output into Data Set.txt file.