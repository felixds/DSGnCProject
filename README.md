## DSGnCProject
## file explaining the process of getting and cleaning the data.

The project of getting and cleaning course of datascience master. below and explanation
about how cleaning the data.

1.- I’m reading the readme file to understand clearly what I have to do, before going forward. I mean what file means, what are the different variables and rows, and so on.

2.- I create a R script called run analysis where set my own working directory and start loading all the files using as variable name the name of the file load (e:g: y_train.txt as file, and the variable will be y_train)

3.- I loaded the files with activities and features to use later when I’ll be cleaning the data and doing it a little bit more friendly the datasets. the program will be structured in different phases to simplify the process of getting and cleaning.

4.- the files with the activities labels and the Y_<files> are loaded with the name of the column “activity” to manage better later.

5.- I merge all the files in one dataset and modify the labels name of the variables to a friendly name.

6.- I loaded the activity and subject values into a two new columns in dataset to summarize later.

7.- I aggregate by activity and subject with the average of all features and creating a new one dataset with this information.

the script to do that is run_analysis.R with the next actions



load files with activity and features.


###########################################################################################
###################################### GETTING PHASE ######################################
###########################################################################################
###########################################################################################
##
load the files from test directory. the name of the column will be f + column number
initially and then it'll be changed by a friendly name.


load the files from train directory. the name of the column will be f + column number
initially and then it'll be changed by a friendly name.


sum the total number of variables and i'll use later to scan the file


###########################################################################################
###################################### CLEANING PHASE ######################################
###########################################################################################
###########################################################################################

load the files from test directory. the name of the column will be f + column number.
and cleaning the data frame with mean and std.


merging all data sets and obtaning only a dataset with the mean and standard 
deviations values. we'll need to use rbind to add values and merge to add new columns.

add the values of rbind for all data frames.


add new two columns to the x_all data frame.


changing the column name to a friendly column name based on features data frame value


changing the numeric value of activity to a friendly label from activity dataframe



extract only the mean and standard deviation column from x_all dataset.


aggregate by activity and subject and changing both column names

create the output file with write.table function