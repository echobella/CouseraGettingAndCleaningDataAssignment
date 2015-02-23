library(dplyr)
library(data.table)
files<-list.files("UCI HAR Dataset", recursive=TRUE)
files

ActivityTestData <- read.table("UCI HAR Dataset/test/Y_test.txt", header = FALSE )
ActivityTrainData <- read.table("UCI HAR Dataset/train/Y_train.txt", header = FALSE)

SubjectTestData <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
SubjectTrainData <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)

FeaturesTestData <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
FeaturesTrainData <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

str(ActivityTestData)
str(ActivityTrainData)
str(SubjectTestData)
str(SubjectTrainData)
str(FeaturesTestData)
str(FeaturesTrainData)

SubjectData <- rbind(SubjectTestData, SubjectTrainData)
head(SubjectData)
str(SubjectData)
ActivityData <- rbind(ActivityTestData, ActivityTrainData)
head(ActivityData)
str(ActivityData)
FeaturesData <- rbind(FeaturesTestData, FeaturesTrainData)
head(FeaturesData)
str(FeaturesData)

names(SubjectData) <- c("subject")
str(SubjectData) 
head(SubjectData)

names(ActivityData) <- c("activity")
str(ActivityData)
head(ActivityData)

FeaturesDataNames <- read.table("UCI HAR Dataset/features.txt", head = FALSE)
head(FeaturesDataNames)
names(FeaturesData) <- FeaturesDataNames$V2
head(FeaturesData)
str(FeaturesData)

data1 <- cbind(SubjectData, ActivityData)
head(data1)
data <- cbind(FeaturesData, data1)
head(data)

SubFeaturesDataNames <- FeaturesDataNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesDataNames$V2)]
head(SubFeaturesDataNames)
selectedNames <- c(as.character(SubFeaturesDataNames), "subject", "activity")
head(selectedNames)
data <- subset(data, select = selectedNames)
head(data)
str(data)

ActivityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
head(ActivityLabels)

data$activity[data$activity == 1] <- "WALKING"
data$activity[data$activity == 2] <- "WALKING UPSTAIRS"
data$activity[data$activity == 3] <- "WALKING_DOWNSTAIRS"
data$activity[data$activity == 4] <- "SITTING"
data$activity[data$activity == 5] <- "STANDING"
data$activity[data$activity == 6] <- "LAYING"

head(data, 30)
head(data$activity, 30)

names(data) <- gsub("^t", "time", names(data))
names(data) <- gsub("^f", "frequency", names(data))
names(data) <- gsub("Acc", "Accelerometer", names(data))
names(data) <- gsub("Gyro", "Gyroscope", names(data))
names(data) <- gsub("Mag", "Magnitude", names(data))
names(data) <- gsub("BodyBody", "Body", names(data))

names(data) <- gsub("^t", "time", names(data))
names(data) <- gsub("^f", "frequency", names(data))
names(data) <- gsub("Acc", "Accelerometer", names(data))
names(data) <- gsub("Gyro", "Gyroscope", names(data))
names(data) <- gsub("Mag", "Magnitude", names(data))
names(data) <- gsub("BodyBody", "Body", names(data))
names(data)

TidyData <- aggregate(. ~subject + activity, data, mean)
head(TidyData)
TidyData <- TidyData[order(TidyData$subject, TidyData$activity),]
head(TidyData)
str(TidyData)

write.table(TidyData, file = "TidyData.txt", row.name = FALSE)
head(TidyData)
