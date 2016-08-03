# Load the dplyr library to be used in the program

library(dplyr)

# Down the required files and unzip them

url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile='smartphone.zip')
unzip('smartphone.zip')

# Read the column names for the datasets and also the activity lables

colnames<- read.table('UCI HAR Dataset/features.txt')
act_lable<- read.table('UCI HAR Dataset/activity_labels.txt')


# Read the datasets in the test folder

testset<- read.table('UCI HAR Dataset/test/X_test.txt')
test_activity<- read.table('UCI HAR Dataset/test/y_test.txt')
test_subject<- read.table('UCI HAR Dataset/test/subject_test.txt')

# Read the datasets in the train folder

trainset<- read.table('UCI HAR Dataset/train/X_train.txt')
train_activity<-read.table('UCI HAR Dataset/train/y_train.txt')
train_subject<-read.table('UCI HAR Dataset/train/subject_train.txt')

# merge the test and train datasets including the activity and subject

mergedf<-rbind(testset,trainset)
merged_activity<- rbind(test_activity,train_activity)
merged_subject<- rbind(test_subject,train_subject)

# Assign the names to the columns of the merged dataset

names(mergedf)<-colnames[,2]

# select only the required columns (mean and std)

reqcols<- which(grepl("mean\\(\\)",names(mergedf)) | grepl("std\\(\\)",names(mergedf)))
extractdf<- mergedf[,reqcols]

# Add the activity and subject data to the dataset and arrange the columns

extractdf<- mutate(extractdf,activity=merged_activity[,1])
extractdf<- mutate(extractdf,subject=merged_subject[,1])
tidydf<- select(extractdf,67,68, 1:66)

# Assign the proper activity description to each activity code and also provide proper names to the columns. 
# This is the first tidy dataset

tidydf[,1]<- factor(tidydf[,1],labels=act_lable[,2])
names(tidydf)<-gsub("^t", "time", names(tidydf))
names(tidydf)<-gsub("^f", "frequency", names(tidydf))
names(tidydf)<-gsub("Acc", "Accelerometer", names(tidydf))
names(tidydf)<-gsub("Gyro", "Gyroscope", names(tidydf))
names(tidydf)<-gsub("Mag", "Magnitude", names(tidydf))
names(tidydf)<-gsub("BodyBody", "Body", names(tidydf))
names(tidydf)<-gsub("\\(\\)", "", names(tidydf))

# Group the first tidy dataset by activity and subject and summarize the dataset to get the mean 

groupdf<- group_by(tidydf,activity,subject)
meandf<- summarize_each(groupdf,funs(mean))

# Write the dataset to a text file

write.table(meandf, 'means.txt', row.names=FALSE)