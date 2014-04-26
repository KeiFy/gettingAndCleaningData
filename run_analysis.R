# the assumption is that the data is already downloaded and unpacked
# if it is not, please source the get_data.R file here
# it is also assumed that the working directory is set to where the files reside
#
# this script depends on sqldf package - please make sure it is installed before attempting to run this

library(sqldf)

activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("activity.number", "activity.name"))
features <- read.table("UCI HAR Dataset/features.txt", col.names=c("feature.no", "feature.name"))

# prepare a column with cleaned-up feature names 
#    note that only those features that we will finally select need cleaning up
#    so the code does not attempt to explicitly clean up the other feature names
features$column.name <- features$feature.name
features$column.name <- sub("^t", "time", features$column.name)
features$column.name <- sub("^f", "frequency", features$column.name)
features$column.name <- gsub("Acc", "Acceleration", features$column.name)
features$column.name <- gsub("Gyro", "Gyroscopic", features$column.name)
features$column.name <- gsub("Mag", "Magnitude", features$column.name)
features$column.name <- gsub("-mean", "Mean", features$column.name)
features$column.name <- gsub("-std", "Std", features$column.name)
features$column.name <- gsub("\\(\\)", "", features$column.name)
features$column.name <- gsub("-", "", features$column.name)

subjects.train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subjects.test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# immediately set names when we load the data
x.train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names=features[,"column.name"])
x.test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names=features[,"column.name"])
y.train <- read.table("UCI HAR Dataset/train/y_train.txt")
y.test <- read.table("UCI HAR Dataset/test/y_test.txt")

# join the train and test set together and at the same time subset the columns to the ones we need (mean and std)
data <- rbind(x.train, x.test)[,features$column.name[grep("mean\\(\\)|std\\(\\)", features$feature.name)]]

# since we loaded y and subjects as data frames, convert them to vectors while we're merging them
y <- rbind(y.train, y.test)[,]
subjects <- rbind(subjects.train, subjects.test)[,]

data$subject <- subjects
data$activity <- activities$activity.name[y]

# since I am a database specialist, summarizing the data is easiest for me using SQL
#   the problem at hand is a simple group by query

# programmatically construct the query
#   newline character chosen as separator in order to visually inspect the query using cat(query) command
query <- paste("select",  "  subject", ", activity", sep="\n")

for (row in paste(", avg(", names(data)[-c(67, 68)], ") ", names(data)[-c(67, 68)], sep="")) {
  query <- paste(query, row, sep = "\n")
}

query <- paste(query, "from data", "group by", "  subject", ", activity", ";", sep="\n")

# run the query and store the results
summarizedData <- sqldf(query)

# reapply the original names

write.table(summarizedData, "tidy_dataset.txt")
