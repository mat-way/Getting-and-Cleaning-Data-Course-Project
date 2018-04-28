library(dplyr)

activity_lbl <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE, header = FALSE)
activity_lbl <- activity_lbl[[2]]
activity_lbl <- tolower(activity_lbl)
activity_lbl <- gsub('_','',activity_lbl)

## Names for columns in data set

features <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE, header = FALSE)

##----------------------------------------------------------------
## Pre-processing Training data set

train_data <- read.table("./UCI HAR Dataset/train/X_train.txt", stringsAsFactors = FALSE, header = FALSE)
train_var <- read.table("./UCI HAR Dataset/train/y_train.txt", stringsAsFactors = FALSE, header = FALSE)
tr_subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", stringsAsFactors = FALSE, header = FALSE)



for (i in 1:nrow(train_var)) {
        
        train_var[i,2] = activity_lbl[train_var[i,1]]
}

colnames(train_data)<-features$V2


##---------------------------------------------------------------
## Final training data set
        
train_ds <- cbind(subject = tr_subjects[,1], activity = train_var[,2], train_data)

##----------------------------------------------------------------
## Pre-processing Test data set

test_data <- read.table("./UCI HAR Dataset/test/X_test.txt", stringsAsFactors = FALSE, header = FALSE)
test_var <- read.table("./UCI HAR Dataset/test/y_test.txt", stringsAsFactors = FALSE, header = FALSE)
ts_subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt", stringsAsFactors = FALSE, header = FALSE)



for (i in 1:nrow(test_var)) {
        
        test_var[i,2] = activity_lbl[test_var[i,1]]
}

colnames(test_data)<-features$V2

##---------------------------------------------------------------
## Final test data set

test_ds <- cbind(subject = ts_subjects[,1], activity = test_var[,2], test_data)


##---------------------------------------------------------------
## General Data set wich contains training and test data

g_ds <- rbind(train_ds,test_ds)


##---------------------------------------------------------------
## Subsetting

## Column numbers where are there names mean and std
col_n_mean <- grep('mean[()]',names(g_ds))
col_n_std <- grep('std[()]',names(g_ds))
col_num <- sort(c(col_n_mean,col_n_std))

## Subset only with column's names mean and std

g_ds_sub<-subset(g_ds, select = c(subject, activity, col_num))


##--------------------------------------------------------------
## Work with column labels

colnames(g_ds_sub) <- tolower(names(g_ds_sub))
colnames(g_ds_sub) <- gsub('-','',names(g_ds_sub))
colnames(g_ds_sub) <- gsub('[()]','',names(g_ds_sub))

##--------------------------------------------------------------
## Final step 5: tidy data set with the average of each variable for each activity and each subject

tidy_ds <- aggregate(x = g_ds_sub[,3:ncol(g_ds_sub)], by = list(activity = g_ds_sub$activity, subject = g_ds_sub$subject), FUN = mean)

write.table(tidy_ds,"results_set.txt",row.names = FALSE)