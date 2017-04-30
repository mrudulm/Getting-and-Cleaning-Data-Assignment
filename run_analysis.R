# Define variables for source url and desitnation file name
source_fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dest_filename <- "HARDataset.zip"

## Download source file from url and unzip the file in working directory

download.file(source_fileurl,dest_filename, mode="wb")
unzip(dest_filename ,exdir="." ,overwrite = TRUE)

# Set path for all txt files to be read

trainingset_x <- "./UCI HAR Dataset/train/X_train.txt"
traininglabel_y <- "./UCI HAR Dataset/train/y_train.txt"
trainingsubjects <- "./UCI HAR Dataset/train/subject_train.txt" 
testset_x <- "./UCI HAR Dataset/test/X_test.txt"
testlabel_y <- "./UCI HAR Dataset/test/y_test.txt"
testsubjects <- "./UCI HAR Dataset/test/subject_test.txt" 
feature_names <- "./UCI HAR Dataset/features.txt"
activity_names <- "./UCI HAR Dataset/activity_labels.txt"

## Read all training files into data frame

df_trainingset_x = read.table(trainingset_x ,sep="")
df_traininglabel_y = read.table(traininglabel_y,col.names = "activityId" ,sep="")
df_trainingsubjects = read.table(trainingsubjects,col.names = "subjectId" ,sep="")

## Read all test files into data frame

df_testset_x = read.table(testset_x ,sep="")
df_testlabel_y = read.table(testlabel_y,col.names = "activityId"  ,sep="")
df_testsubjects = read.table(testsubjects,col.names = "subjectId",sep="")

#Read Feature names into data frame

df_feature_names = read.table(feature_names,col.names = c("featureId","featureName")  ,sep="")

#Read Activity names into data frame

df_activity_names = read.table(activity_names,col.names =  c("activityId","activityName")  ,sep="")

## Assign feature names to test and training sets

names(df_testset_x) <- df_feature_names$featureName
names(df_trainingset_x) <- df_feature_names$featureName

# combine subject, activitity and feature readings into one single data frame 
# for training and test data

df_training_set <- cbind(df_trainingsubjects, df_traininglabel_y, df_trainingset_x)
df_test_set <- cbind(df_testsubjects, df_testlabel_y, df_testset_x)

################################################################################
#1.	Merges the training and the test data sets to create one combined data set.
################################################################################

df_combined_set <- rbind(df_training_set, df_test_set) 


###########################################################################################
#2.	Extracts only the measurements on the mean and standard deviation for each measurement.
###########################################################################################


# retrieve column indices for mean and std. deviation for every subject and activity

filtercolindices <- grep("mean|std|subjectId|activityId", names(df_combined_set), ignore.case=T)

# get subset of combined data for mean and std. deviation

df_mean_std_set <- df_combined_set[,filtercolindices]

###########################################################################################
#3.	Uses descriptive activity names to name the activities in the data set
###########################################################################################

# assign activity name for each record in the data set

df_mean_std_set  <- merge(df_activity_names ,df_mean_std_set  , "activityId")

# remove activity ID column from the data set
df_mean_std_set  <- df_mean_std_set [,-1]


###########################################################################################
#4 Appropriately label the data set with descriptive variable names.
###########################################################################################


# Provide Descriptive names and remove any special characters 
# based on feature info file t- Time , f-Frequency , Acc- Acceleration , Mag - Magnitude , mean - Mean , std- StdDev

names(df_mean_std_set ) <- gsub("\\(|\\)", "", names(df_mean_std_set ))
names(df_mean_std_set ) <- gsub("-", "", names(df_mean_std_set ))
names(df_mean_std_set ) <- gsub(",", "", names(df_mean_std_set ))
names(df_mean_std_set ) <- gsub("^t", "time", names(df_mean_std_set ))
names(df_mean_std_set ) <- gsub("^f", "frequency", names(df_mean_std_set ))
names(df_mean_std_set ) <- gsub("Acc", "Acceleration", names(df_mean_std_set ))
names(df_mean_std_set ) <- gsub("Mag", "Magnitude", names(df_mean_std_set ))
names(df_mean_std_set ) <- gsub("mean",  "Mean", names(df_mean_std_set ))
names(df_mean_std_set ) <- gsub("BodyBody", "Body", names(df_mean_std_set ))
names(df_mean_std_set ) <- gsub("std", "StdDev", names(df_mean_std_set ))

###########################################################################################
# 5. From the data set in step 4, creates a second, independent tidy data set with the 
#    average of each variable for each activity and each subject.
###########################################################################################

# find mean of each activity for every subject and order the resulting set by subject and activity 
df_mean_std_tidy_set <- aggregate(. ~subjectId + activityName, df_mean_std_set, mean)
df_mean_std_tidy_set <- df_mean_std_tidy_set[order(df_mean_std_tidy_set$subjectId,df_mean_std_tidy_set$activityName),]

# Create txt file for the tidy data and save the file into working directory
write.table(df_mean_std_tidy_set, file = "tidydata.txt",row.name=FALSE)


