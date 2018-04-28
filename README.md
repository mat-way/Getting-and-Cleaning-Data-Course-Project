# Getting-and-Cleaning-Data-Course-Project


1. First, unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Make sure the folder **UCI HAR Dataset** and the **run_analysis.R** script are both in the current working directory
2. For running skript you should open **R Studio** and write command **source("run_analysis.R")** and press **Enter**
3. After that script read all files with data and create data sets, merge it and create subset for all columns where it find key words **mean()** and **std()**.
4. After that create new tida data subset with the average of each variable for each activity and each subject, and there are 6 activities in total and 30 subjects in total, we have 180 rows with all combinations for each.
5. All results you can find in the current workind directory, file name **results_set**.
