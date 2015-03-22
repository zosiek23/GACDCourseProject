
# Import the dplyr library
library(dplyr)

# Read in the X test dataset
x.test <- read.csv("UCI HAR Dataset/test/X_test.txt", sep="",
                   header=FALSE)

# Read in the test labels
y.test <- read.csv("UCI HAR Dataset/test/y_test.txt", sep="",
                   header=FALSE)

# Rest in the test subject dataset
subject.test <- read.csv("UCI HAR Dataset/test/subject_test.txt",
                         sep="", header=FALSE)

# Read in the X training dataset
x.train <- read.csv("UCI HAR Dataset/train/X_train.txt", sep="",
                    header=FALSE)

# Read in the training labels
y.train <- read.csv("UCI HAR Dataset/train/y_train.txt", sep="",
                    header=FALSE)

# Read in the training subject dataset
subject.train <- read.csv("UCI HAR Dataset/train/subject_train.txt",
                          sep="", header=FALSE)


# Merge the test datasets into a single dataframe
test_data <- data.frame(subject.test, y.test, x.test)

# Merge training datasets into a single dataframe
train_data <- data.frame(subject.train, y.train, x.train)

# Merges the training and the test sets to create one data set.
run.all_data <- rbind(train_data, test_data)

# Clean work area - the environment.
remove(subject.test, x.test, y.test, subject.train,
       x.train, y.train, test_data, train_data)

# Read in the measurement labels dataset
features <- read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
# Convert the 2nd column into a vector
column.names <- as.vector(features[, 2])
# Apply the measurement labels as column names to the combined
# running dataset
colnames(run.all_data) <- c("subject_id", "activity_labels", column.names)

# Extracts only the measurements on the mean and 
# standard deviation for each measurement. 
# Want to display the subject and label columns.
# Exclude columns with freq and angle in the name.
run.all_data <- select(run.all_data, contains("subject_id"), contains("labels"),
                   contains("mean()"), contains("std()"))

# Read in the activity labels dataset
activity.labels <- read.csv("UCI HAR Dataset/activity_labels.txt", 
                            sep="", header=FALSE)

# Uses descriptive activity names to name the activities in the data set
run.all_data$activity_labels <- as.character(activity.labels[
  match(run.all_data$activity_labels, activity.labels$V1), 'V2'])

# Clean up the column names. Remove parantheses and hyphens
# from column names, both of which are invalid characters in
# column names. Also fix a set of columns that repeat the
# word "Body".
# Appropriately labels the data set with descriptive variable names. 
setnames(run.all_data, colnames(run.all_data), gsub("\\(\\)", "", colnames(run.all_data)))
setnames(run.all_data, colnames(run.all_data), gsub("-", "_", colnames(run.all_data)))
#setnames(run.all_data, colnames(run.all_data), gsub("BodyAcc", "Body", colnames(run.all_data)))

# Group the running data by subject and activity, then
# calculate the mean of every measurement.
run.all_data <- run.all_data %>%
  group_by(subject_id, activity_labels) %>%
  summarise_each(funs(mean))

# Write run.data to file
write.table(run.all_data, file="run_all_data.txt", row.name=FALSE)