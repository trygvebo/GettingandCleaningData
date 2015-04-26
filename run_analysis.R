##Getting R ready
library(plyr)
library(dplyr)
library(tidyr)
setwd("~/Documents/Couersa/3 Getting and Cleaning Data/Assignments/Assignment/")
#Working directory should be set to file that contained the unpacked filed cont-
#aining the dataset.
##Load column names
nfile<-file("./UCI HAR Dataset/features.txt",open="r")
cnames<-readLines(nfile)
close(nfile)
##Load train table
train_id<-read.table("./UCI HAR Dataset/train/subject_train.txt", col.names="ID")
train_exercise<-read.table("./UCI HAR Dataset/train/y_train.txt", col.names="Excerise")
train_data<-read.table("./UCI HAR Dataset/train/x_train.txt", sep="", col.names=cnames)
train_table<-cbind(train_id,train_exercise,train_data)
##Load test table
test_id<-read.table("./UCI HAR Dataset/test/subject_test.txt", col.names="ID")
test_exercise<-read.table("./UCI HAR Dataset/test/y_test.txt", col.names="Excerise")
test_data<-read.table("./UCI HAR Dataset/test/X_test.txt", sep="", col.names=cnames)
test_table<-cbind(test_id,test_exercise,test_data)
##Combine train and test table
combined_table<-rbind(train_table,test_table)
##Select mean and standard deviation
mean_table<-select(combined_table, contains("mean", ignore.case=TRUE))
std_table<-select(combined_table, contains("std", ignore.case=TRUE))
id_table<-select(combined_table, c(1,2))
mstd_table<-cbind(id_table,mean_table,std_table)
##Reformating the table
s_mstd_table<-gather(mstd_table,data_type,measurement,-ID,-Excerise)
##Rename activites
s_mstd_table<-mutate(s_mstd_table, Excerise=factor(as.factor(Excerise), labels=c("WALKING","WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")))
##Rename columns
s_mstd_table<-rename(s_mstd_table, Subject_ID=ID,Type_of_Activity=Excerise,Type_of_Measurement_Data=data_type,Measurement_Data=measurement)
##Summarise the data
group_by(s_mstd_table,Subject_ID,Type_of_Activity,Type_of_Measurement_Data)->mstd_group
summarise(mstd_group,Mean_of_Measurements=mean(Measurement_Data))->mstd_group_mean
##Print data
write.table(mstd_group_mean, "./mean_table.txt", row.name=FALSE)