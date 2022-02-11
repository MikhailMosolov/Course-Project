url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(url,destfile="20Dataset.zip",method="curl")
dataFile<-unzip("20Dataset.zip")
#dataFile

# Load activite labels + mean and std features
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])

features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

wantedFeatures<-grep("mean|std", features[,2])
wantedFeatures.names<-features[wantedFeatures,2]

# Tidying wantedFeatures
wantedFeatures.names = gsub('-mean', 'MEAN', wantedFeatures.names)
wantedFeatures.names = gsub('-std', 'STD', wantedFeatures.names)
wantedFeatures.names <- gsub('[-|()]', '', wantedFeatures.names)

# Loading datasets
train<-read.table("UCI HAR Dataset/train/X_train.txt")[wantedFeatures]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[wantedFeatures]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# Merging two datasets together and labeling the resulting one
RESULT<-rbind(train,test)
colnames(RESULT)<-c("subject","activity", wantedFeatures.names)

# Renaming activity values
RESULT$activity[RESULT$activity==1]<-"walking"
RESULT$activity[RESULT$activity==2]<-"walkingUpstairs"
RESULT$activity[RESULT$activity==3]<-"walkingDownstairs"
RESULT$activity[RESULT$activity==4]<-"sitting"
RESULT$activity[RESULT$activity==5]<-"standing"
RESULT$activity[RESULT$activity==6]<-"laying"

# Turning subjects and activities into factors
RESULT$subject<-as.factor(RESULT$subject)
RESULT$activity<-as.factor(RESULT$activity)

RESULT.melted<-reshape2::melt(RESULT, id=c("subject","activity"))
RESULT.mean<-reshape2::dcast(RESULT.melted, subject + activity ~ variable, mean)

write.table(RESULT.mean,"tidyData.txt", row.names=F, quote=F)




