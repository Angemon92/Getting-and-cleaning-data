#run_analysis() function will return tidy data set that is reqired for project
#Important: Tidy data includes all features, so fullFeatures are TRUE by default, if you want to get tidy data
# where features are only mean and standard deviation features, the change fullFeatures to FALSE
run_analysis <- function(fullFeatures=T){
        
# get data set with full features
        dataSet = getCleanDataSet()
        
# if you want to extracts only mean and standard deviation features (fullFeatures=FALSE)
        if(!fullFeatures)   dataSet = getMSDataSet(dataSet)

# calculate tidy data set
        tidyDataSet = getAverage(dataSet)

        tidyDataSet        
}


# getCleanDataSet is function that returns clean (tidy) data set
# Clean data set is data set where columns are in order: subject, ... , activityName (... = numeric features, variables, etc)
# Important: function should be runned in Working Directory where 
# 'Human Activity Recognition Using Smartphones - Data set.rar' is extracted.
getCleanDataSet <- function(){
        
# MyRead for faster loading data set
        myRead<-function(path,...){
                tab5rows <- read.table(file=path, header = F, nrows = 5)
                classes <- sapply(tab5rows, class)
                read.table(file=path, nrows=7352, header = F, colClasses = classes)
        }
        
# path of train and test dataSet        
        filesPathTrain = c("./train/X_train.txt","./train/y_train.txt","./train/subject_train.txt")                        
        filesPathTest = c("./test/X_test.txt","./test/y_test.txt","./test/subject_test.txt")
        
        print("loading large data tabe, please wait few seconds... ")
# get X, y and subject both test and train
        X_test = myRead(filesPathTest[1])
        y_test = myRead(filesPathTest[2])
        subject_test = myRead(filesPathTest[3])
        
        X_train = myRead(filesPathTrain[1])
        y_train = myRead(filesPathTrain[2])
        subject_train = myRead(filesPathTrain[3])
        
# get features and activity_labels       
        features = myRead("./features.txt")
        activity_labels = myRead("./activity_labels.txt")
        
        features = as.character(features[,2])        
        
# 1) Merges the training and the test sets to create one data set. 
# join test and train X       
        X = rbind(X_test, X_train)
        
# 4) Appropriately labels the data set with descriptive activity names.
# add primary key for X named "rowNumber" ( for later merging with y)
# name features ( columns )
        X = cbind(X, 1:10299)
        colnames(X) = c(features, "rowNumber")
        
# join test and train y
        y = rbind(y_test,y_train)
        
# join test and train subject       
        subject = rbind(subject_test,subject_train)
        
# add primary key for y named "rowNumber" ( for later merging with X)
        y = cbind(1:10299, y)
# 3) Uses descriptive activity names to name the activities in the data set. -
# get y that contains: subject who is performing activity column, activity name column and primary key column 
        y = cbind(y, subject)
        colnames(y) = c("rowNumber","activityNumber","subject")
        colnames(activity_labels) = c("activityNumber", "activityName")
        
        y = merge(y, activity_labels, by = "activityNumber")
# drop activityNumber column
        y = y[,2:4]
        
# merge X and y
        dataSet = merge(y, X, by = "rowNumber")
        
# remove primary key "rowNumber"
        dataSet = dataSet[,2:564]
        
# reorder columns to: subject, ...features..., activityName
        cleanDataSet = subset(dataSet, select=c("subject", features, "activityName")) 

        cleanDataSet
}

# 2) Extracts only the measurements on the mean and standard deviation for each measurement.
# function returns data.frame with
# MS Data Set =  Mean and Standard deviation Data Set
# MSDataSet is also cleanDataSet (subject, ..., activityName)
getMSDataSet <-function(cleanDataSet){
        
        dataSet = cleanDataSet
        
# get only mean and std columns       
        colNames = names(dataSet)
        logicalMean = colNames %in% grep("mean", colNames, value = TRUE)
        logicalStd = colNames %in% grep("std", colNames, value = TRUE)
        logicalSubject = colNames %in% grep("subject", colNames, value = TRUE) 
        logicalActivityName = colNames %in% grep("activityName", colNames, value = TRUE)
        logicalRemoveFreq = !( colNames %in% grep("Freq", colNames, value = TRUE) )

        logicalNeededColumns = (logicalMean | logicalStd | logicalSubject | logicalActivityName) & logicalRemoveFreq

        dataSet = dataSet[,logicalNeededColumns]

        dataSet 
        
}



# - 5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject. -
#getAverage function returns data set that contains
#average for each variable for each activity and each subject for input data set.
getAverage <- function(cleanDataSet){
    

        dataSet = cleanDataSet
        names = names(dataSet)
        
# get all features from dataSet (skip "subject" and "activityName" columns, whitch are first and last column)
        features = names[2: (length(names)-1)]

# calculate mean of all features, grouped by subject and activityName
        dataSet = aggregate( dataSet[,features], dataSet[,c( 1, ncol(dataSet))], FUN = mean )

# order dataSet by subject  
        dataSet = dataSet[order(dataSet$subject),]

# reorder columns to: subject, ...features..., activityName (transform dataSet to cleanDataSet)
        cleanDataSet = subset(dataSet, select=c("subject", features, "activityName"))

        cleanDataSet
}










