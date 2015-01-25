## Author: Félix Ángel Fernández Alonso
## 
## Course: Master Data Science (Getting and Cleaning course)
## 
## Date: 25 January 2015
## 
## Description:  You should create one R script called run_analysis.R 
## that does the following. Merges the training and the test sets 
## to create one data set.Extracts only the measurements on the mean and standard deviation 
## for each measurement.
## dees descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names. 
## From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.

## loading libraries
library(dplyr);

## root directory for project with all datasets
setwd("/Users/felixangelfernandezalonso/datasciencecoursera/GettingNClean/Project/");

## load file with activity and features.
activity <- read.table("./file/activity_labels.txt", 
                                   sep="",
                                   col.names=c("id", "activity"),
                                   fill=FALSE);

features <- read.table("./file/features.txt", 
                       sep="",
                       col.names=c("id", "feature"),
                       fill=FALSE);

# change from factor to character. 
features$feature <- as.character(features$feature);
activity$activity <- as.character(activity$activity);

###########################################################################################
###################################### GETTING PHASE ######################################
###########################################################################################
###########################################################################################
##
## load the files from test directory. the name of the column will be f + column number
## initially and then it'll be changed by a friendly name.
##
###########################################################################################

## count the number of variable to use later and rename the column with f + number
ncol <- max(count.fields("./file/test/X_test.txt", sep = ""));
x_test <- read.table("./file/test/X_test.txt", 
                    sep="",
                    col.names = paste0("f", seq_len(ncol)));

y_test <- read.table("./file/test/Y_test.txt", 
                     sep="",
                     col.names=c("activity"));

subject_test <- read.table("./file/test/subject_test.txt", 
                     sep="",
                     col.names=c("subject"));

###########################################################################################
##
## load the files from train directory. the name of the column will be f + column number
## initially and then it'll be changed by a friendly name.
##
###########################################################################################

## count the number of variable to use later and rename the column with f + number
ncol <- max(count.fields("./file/train/X_train.txt", sep = ""));
x_train <- read.table("./file/train/X_train.txt", 
                     sep="",
                     col.names = paste0("f", seq_len(ncol)));

y_train <- read.table("./file/train/Y_train.txt", 
                     sep="",
                     col.names=c("activity"));

subject_train <- read.table("./file/train/subject_train.txt", 
                      sep="",
                      col.names=c("subject"));

###########################################################################################
###################################### CLEANING PHASE ######################################
###########################################################################################
###########################################################################################
##
## load the files from test directory. the name of the column will be f + column number.
## and cleaning the data frame with mean and std.
##
###########################################################################################

## merging all data sets and obtaning only a dataset with the mean and standard 
## deviations values. we'll need to use rbind to add values and merge to add new columns.

## add the values of rbind for all data frames.

x_all <- rbind(x_test,x_train);
y_all <- rbind(y_test,y_train);
subject_all <- rbind(subject_test,subject_train);

## add new two columns to the x_all data frame.

x_all["activity"]<-NA;
x_all["subject"]<-NA;

total_xall <- dim(x_all);

for (i in 1:total_xall[1])
{
    x_all$activity[i] <-y_all[i,1];
    x_all$subject[i] <-subject_all[i,1];
}


## changing the column name to a friendly column name based on features data frame value

for (i in 1:ncol)
{
    
    colnames(x_all)[i] <- features$feature[i];
}

## changing the numeric value of activity to a friendly label from activity dataframe

total_xall <- dim(x_all);
total_activity <- dim(activity);

for (i in 1:total_xall[1])
{
    for (j in 1:total_activity[1])
    {
        if (x_all$activity[i] == activity$id[j]) 
            {
                x_all$activity[i] <- activity$activity[j]
            }
   }
    
}

## extract only the mean and standard deviation column from x_all dataset.

x_allpartial<-x_all[,grepl("mean|std|activity|subject",colnames(x_all))];
x_allsm <- select(x_allpartial, -contains("Freq"));

## aggregate by activity and subject and changing both column names

x_final <- aggregate(x_allsm[,1:66], by=list(x_allsm$subject, x_allsm$activity), mean)

colnames(x_final)[1] <- "subject";
colnames(x_final)[2] <- "activity";

## create the output file with write.table function

write.table(x_final,"/Users/felixangelfernandezalonso/datasciencecoursera/GettingNClean/Project/x_final.txt", row.name=FALSE);
