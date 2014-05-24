getDataSet <- function(){
        
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
       
# join test and train X       
        X = rbind(X_test, X_train)

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
         dataSet = subset(dataSet, select=c("subject", features, "activityName")) 

# get only mean and std columns
     
         colNames = names(dataSet)
         logicalMean = colNames %in% grep("mean", colNames, value = TRUE)
         logicalStd = colNames %in% grep("std", colNames, value = TRUE)
         logicalSubject = colNames %in% grep("subject", colNames, value = TRUE) 
         logicalActivityName = colNames %in% grep("activityName", colNames, value = TRUE)
         logicalRemoveFreq = !( colNames %in% grep("Freq", colNames, value = TRUE) )

         logicalNeededColumns = (logicalMean | logicalStd | logicalSubject | logicalActivityName) & logicalRemoveFreq
         #logicalNeededColumns = logical & logicalRemoveFreq

         dataSet = dataSet[,logicalNeededColumns]

         dataSet

}