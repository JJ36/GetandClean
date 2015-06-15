url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile="data.zip")
unzip("data.zip",exdir="./dataAssessment")

## Mergind testing and trainng set

# Merge of X values
X_test <- read.table("./dataAssessment/UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("./dataAssessment/UCI HAR Dataset/train/X_train.txt")
X <- rbind(X_test,X_train)

# Merge of Y values
Y_test <- read.table("./dataAssessment/UCI HAR Dataset/test/Y_test.txt")
Y_train <- read.table("./dataAssessment/UCI HAR Dataset/train/Y_train.txt")
Y <- rbind(Y_test,Y_train)

# Getting the Features values
Features <- read.table("./dataAssessment/UCI HAR Dataset/features.txt")

# Extract from the Features values, mean and std
Feat_mean <- Features[grep("mean",Features$V2),]
Feat_std <- Features[grep("std",Features$V2),]
Feat <- rbind(Feat_mean,Feat_std)
Feat <- arrange(Feat,V1)

# Extract from the X values, mean and std values
X_mean_std <- X[,Feat$V1]

# Uses descriptive activity names to name the activities in X
names(X_mean_std) <- Feat$V2

# Get the activities table
Activities <- read.table("./dataAssessment/UCI HAR Dataset/activity_labels.txt")

# Assigning Activities names in Y
YActivities <- Activities[Y$V1,2]

# Get the Subjects
Subject_test <- read.table("./dataAssessment/UCI HAR Dataset/test/subject_test.txt")
Subject_train <- read.table("./dataAssessment/UCI HAR Dataset/train/subject_train.txt")
Subject <- rbind(Subject_test,Subject_train)

# Gathering X, Y and Activities together
data2 <- cbind(Subject=Subject,Activities=YActivities,X_mean_std)

# Writing dataset1
write.table(data2, './dataset1.txt')

# Average of each variable for each activity and each subject
data3 <- aggregate(x=data2[3:dim(data2)[2]],by=list(Subject=Subject$V1,Activities=YActivities),FUN=mean)
        
# writing dataset2
write.table(data3, './dataset2.txt')
