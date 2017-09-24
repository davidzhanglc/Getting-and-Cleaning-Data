setwd("D:/Files/Data Scientist/Course Project")

# Step1. Merges the training and the test sets to create one data set.

subject_train <- read.table('./UCI HAR Dataset/train/subject_train.txt'
                          ,header=FALSE)
subject_test <- read.table('./UCI HAR Dataset/test/subject_test.txt'
                          ,header=FALSE)
subject <- rbind(subject_test, subject_train)
        
x_train <- read.table('./UCI HAR Dataset/train/x_train.txt',header=FALSE)
x_test <- read.table('./UCI HAR Dataset/test/x_test.txt',header=FALSE)
x <- rbind(x_train, x_test)


y_train <- read.table('./UCI HAR Dataset/train/y_train.txt',header=FALSE)
y_test <- read.table('./UCI HAR Dataset/test/y_test.txt',header=FALSE)
y <- rbind(y_train, y_test)

dim(x)
dim(y)
dim(subject)

# Step2. Extracts only the measurements on the mean and standard 
#        deviation for each measurement. 

features <- read.table('./UCI HAR Dataset/features.txt')
x_mean_std <- x[, grep("-(mean|std)\\(\\)", features[, 2])]
names(x_mean_std) <- features[grep("-(mean|std)\\(\\)", features[, 2]), 2]
dim(x_mean_std)

# Step3. Uses descriptive activity names to name the activities in the data set.

y[, 1] <- read.table("./UCI HAR Dataset/activity_labels.txt")[y[, 1], 2]
colnames(y) <- "Activity"
colnames(subject) <- "Subjects"

# Step4. Appropriately labels the data set with descriptive variable names. 
final <- cbind(subject, x_mean_std, y)
str(final)

# Step5. From the data set in step 4, creates a second, independent tidy data 
#        set with the average of each variable for each activity and each 
#        subject.

average <- aggregate(x=final, by=list(activities=final$Activity, 
                                      subj=final$Subjects), FUN=mean)
average <- average[, !(colnames(average) %in% c("subj", "activity"))]

str(average)

write.table(average, 'tidy_data.txt', row.names = F)











