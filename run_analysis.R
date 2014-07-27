# 1. Read data from files and merge the training and the test sets to create one data set:
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
activity_test <- read.table("UCI HAR Dataset/test/y_test.txt")
signal_test <- read.table("UCI HAR Dataset/test/X_test.txt")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
activity_train <- read.table("UCI HAR Dataset/train/y_train.txt")
signal_train <- read.table("UCI HAR Dataset/train/X_train.txt")

subject_total <- rbind(subject_test, subject_train)
activity_total <- rbind(activity_test, activity_train)
signal_total <- rbind(signal_test, signal_train)

nameActivity <- read.table("UCI HAR Dataset/activity_labels.txt")
nameSignal <- read.table("UCI HAR Dataset/features.txt")

# 2. Extracts only the measurements on the mean and standard deviation for each measurement:
vecMean <- grep('mean', nameSignal[,2])
vecStd <- grep('std', nameSignal[,2])
vecMeanFreq <- grep('meanFreq', nameSignal[,2])
vecMean[vecMean %in% vecMeanFreq] <- 0
vecUse <-sort(c(vecMean[vecMean != 0], vecStd))

signal_use <- signal_total[, vecUse]

# 3. Use descriptive activity names to name the activities in the data set and put the data together:
for(i in 1:6)
	activity_total[,1][activity_total[,1]==i]<-as.vector(nameActivity[,2])[i]

signal_tidy <- cbind(subject_total, activity_total, signal_use)

# 4. Label the data set with descriptive variable names:
names(signal_tidy) <- c('SUBJECT', 'ACTIVITY', as.vector(nameSignal[vecUse, 2]))

# 5. Creat the tidy data set
write.table(signal_tidy, file = "tidy_dataset_1.txt")

# 6. Creat a second, independent tidy data set with the average of each variable for
#    each activity and each subject:
signal_temp <- data.frame()
v1 <- c()
v2 <- c()
for(sub in 1:30)  {
  for(act in 1:6) {
    signal_temp <- rbind(signal_temp, sapply(signal_tidy[signal_tidy$SUBJECT == sub & signal_tidy$ACTIVITY == as.vector(nameActivity[,2])[act],-c(1,2)],mean))
    v1 <- c(v1, sub)
    v2 <- c(v2, as.vector(nameActivity[,2])[act])
  }
}

signal_second <- cbind(v1, v2, signal_temp)
names(signal_second) <- c('SUBJECT', 'ACTIVITY', as.vector(nameSignal[vecUse, 2]))
write.table(signal_second, file = "tidy_dataset_2.txt")
