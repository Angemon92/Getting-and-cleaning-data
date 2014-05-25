Data description:
----------------------------------------
"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data... 

For each record it is provided:
1. Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
2. Triaxial Angular velocity from the gyroscope. 
3. A 561-feature vector with time and frequency domain variables. 
4. Its activity label. 
5. An identifier of the subject who carried out the experiment."
**Complete description about experiment, collected and stored data are included in 'Human Activity Recognition Using Smartphones - Data set.rar', where should start from README.txt inside that zip file**

Description of functions:
-------------------------
`All functions are writen in run_analysis.R script`

run_analysis.R is script (also function) which is one of the things that I had to do for passing the course project. Script should do: 

    1.Merges the training and the test sets to create one data set.
    2.Extracts only the measurements on the mean and standard deviation for each measurement. 
    3.Uses descriptive activity names to name the activities in the data set
    4.Appropriately labels the data set with descriptive activity names. 
    5.Creates a second, independent tidy data set with the average of each variable for each activity and 	each subject. 

In run_analysis.R four functions are implemented: run_analysis(), getCleanDataSet(), getMSDataSet(), getAverage()

- 1,2,3 instructions are implemented in getCleanDataSet() function.
- 4th instruction is implemented in getMSDataSet() function.
- 5th instruction is implemented in getAverage() function.

**Important about functions:**
	1. Functions should be runned in Working Directory where 'Human Activity Recognition Using 	Smartphones -Data set.rar' is extracted.
	2. Clean data set is data set where columns are in order: subject, ... , activityName 
		- ... = numeric features, numeric variables, etc
		- "subject" is numeric vector that represents volunteers ID, performer of the experiment
		- "activityName" is character vector that can take values {"WALKING
", "WALKING_UPSTAIRS",
 "WALKING_DOWNSTAIRS",
 "SITTING
", "STANDING",
 "LAYING
"}
	3. MSDataSet represents  Mean and Standard deviation Data Set. MSDataSet is also cleanDataSet 	becose its form is: subject, ..., activityName
	4. getAverage() returns data set that consist of average for each variable for each activity and 	each subject for input clean data set.
	5. run_analysis() will return tidy data set that is reqired for project goal. Tidy data includes 	all features, so `fullFeatures` is TRUE by default, whitch is one and only paramethar of this 	function, if you want to get tidy data set where features are only mean and standard deviation 	(getAverage(SMDataSet)) , change fullFeatures to FALSE.

**Fully working steps are described inside functions by commentars '#'.**