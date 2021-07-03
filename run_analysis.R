library(dplyr)
##donwload file
fileData<-"Clean Data project.zip"
if(!file.exists(fileData))
  {fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL,fileData,method = "curl")}
if(!file.exists("UCI HAR Dataset"))
{unzip(fileData)}
##achieve the tables
activity<-read.table("UCI HAR Dataset/activity_labels.txt",col.names = c("code","activities"))
feature<-read.table("UCI HAR Dataset/features.txt",col.names = c("numbers","features"))
subjectInTest<-read.table("UCI HAR Dataset/test/subject_test.txt",col.names="subject")
xInTest<-read.table("UCI HAR Dataset/test/X_test.txt",col.names = feature$features)
yInTest<-read.table("UCI HAR Dataset/test/y_test.txt",col.names ="code")
subjectInTrain<-read.table("UCI HAR Dataset/train/subject_train.txt",col.names ="subject")
xInTrain<-read.table("UCI HAR Dataset/train/X_train.txt",col.names =feature$features)
yInTrain<-read.table("UCI HAR Dataset/train/y_train.txt",col.names ="code")
##Merge the training and the test sets to create one data set
Xbind<-rbind(xInTrain,xInTest)
Ybind<-rbind(yInTrain,yInTest)
Subjectbind<-rbind(subjectInTrain,subjectInTest)
Allbind<-cbind(Subjectbind,Ybind,Xbind)
head(Allbind,n=1)
##Extract only the measurements on the mean and standard deviation for each measurement
ExtractData<-Allbind%>%select(subject,code,contains("mean"),contains("std"))
head(ExtractData,n=1)
##Use descriptive activity names to name the activities in the data set
ExtractData$code<-activity[ExtractData$code,2]
head(ExtractData,n=1)
##relabel the data set with descriptive variable names
names(ExtractData)[2]="activity"
names(ExtractData)<-gsub("Acc","Accelaerometer",names(ExtractData))
names(ExtractData)<-gsub("Gyro","Gyroscope",names(ExtractData))
names(ExtractData)<-gsub("BodyBody","Body",names(ExtractData))
names(ExtractData)<-gsub("Mag","Magnitude",names(ExtractData))
names(ExtractData)<-gsub("^t","Time",names(ExtractData))
names(ExtractData)<-gsub("^f","Frequency",names(ExtractData))
names(ExtractData)<-gsub("tBody","TimeBody",names(ExtractData))
names(ExtractData)<-gsub("-mean()","Mean",names(ExtractData))
names(ExtractData)<-gsub("-std()","Standard deviation",names(ExtractData))
names(ExtractData)<-gsub("-freq()","Frequency",names(ExtractData))
names(ExtractData)<-gsub("angle","Angle",names(ExtractData))
names(ExtractData)<-gsub("gravity","Gravity",names(ExtractData))
##create an independent tidy data set with the average of each variable for each activity and each subject
Output<-ExtractData%>%group_by(subject,activity)%>%summarise_all(list(mean))
write.table(Output, "Data Set.txt", row.name=FALSE)
head(Output)