## Cleaning Data Programming Assignment 

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

###############################################################################

# Files used: UCI HAR Dataset.zip
# Files created: test_train.csv

# Set working directory and load libraries

library(dplyr)
library(data.table)

# Download data and unzip the folder  
fileULR <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfolder <- download.file(fileULR, destfile = "\\UCI HAR Dataset.zip")
unzip("UCI HAR Dataset.zip", exdir = "UCI HAR data")
#Reset working directory to new UCI HAR data folder

# Read the files into R
files <- list.files(path = ".", recursive = TRUE, pattern = "\\.txt", full.names = TRUE)
files # Print to see the positioning of files in the list

# Make dataframes for the relevent files 
features <- tbl_df(read.table(files[2]))
activities <- tbl_df(read.table(files[1]))

testx <- tbl_df(read.table(files[15]))
testy <- tbl_df(read.table(files[16]))
testsub <- tbl_df(read.table(files[14]))

trainx <- tbl_df(read.table(files[27]))
trainy <- tbl_df(read.table(files[28]))
trainsub <- tbl_df(read.table(files[26]))

# For both train and test: count the number of columns in the 'X' dataframes and the 
# number of rows in the 'features' dataframe to ensure that they have the same count 
# prior to merging 
    # (Better would be to make this a logical function)
ncol(testx)
ncol(trainx)
nrow(features)

# Turn the 'features' dataframe into a list of lowercase names 
xnames <- features$V2
xnames <- tolower(as.character(xnames))

# For both test and train: Name the columns of the 'x' dataframes
names(testx) <- xnames
names(trainx) <-xnames

# For both test and train: Name the 'subject' dataframes 
testsub <- rename(testsub, subject = V1)
trainsub <- rename(trainsub, subject = V1)

# For both test and train: Create a variable that denotes the type of observation
testx$type <- "test"
trainx$type <- "train"

# For both test and train: Recode the observations in the 'y' dataframes 
testy$V1 <-  ifelse(testy$V1 == 1, "walking", ifelse(testy$V1 == 2, "walkingup",
ifelse(testy$V1 == 3, "walkingdown", ifelse(testy$V1 == 4, "sitting", 
ifelse(testy$V1 == 5, "standing", ifelse(testy$V1 == 6, "laying", "na"))))))

testy <- rename(testy, activity = V1)

trainy$V1 <-  ifelse(trainy$V1 == 1, "walking", ifelse(trainy$V1 == 2, "walkingup",
ifelse(trainy$V1 == 3, "walkingdown", ifelse(trainy$V1 == 4, "sitting", 
ifelse(trainy$V1 == 5, "standing", ifelse(trainy$V1 == 6, "laying", "na"))))))

trainy <- rename(trainy, activity = V1)

# For both test and train: Count the number of values in the 'x', 'y' and 
# 'subject' dataframes to ensure they are the same count before merging 
    # (Better would be to make this a logical function)
nrow(testx)
nrow(testy)
nrow(testsub)

nrow(trainx)
nrow(trainy)
nrow(trainsub)

# For both train and test: Merge the 'subject', 'x', and 'y' dataframes and 
# reorder the columns
testx <- testx %>%
    bind_cols(testy, testsub) %>% 
    select(type, subject, activity, everything())

trainx <- trainx %>%
    bind_cols(trainy, trainsub) %>% 
    select(type, subject, activity, everything())

# Merge the test and train datasets
DF <- tbl_df(merge(testx, trainx, all = TRUE))
head(DF)

# Extract only the relevant variables (type, subject, activity, mean, and std)
DF<- select(DF, matches("type|subject|activity|mean|std"))


# Create a tidy variable names vector and rename columns
colnames(DF) <- c("type", "subject", "activity", "tbodyacc-mean-x", "tbodyacc-mean-y", 
                  "tbodyacc-mean-z", "tbodyacc-std-x", "tbodyacc-std-y", 
                  "tbodyacc-std-z", "tgravityacc-mean-x", "tgravityacc-mean-y", 
                  "tgravityacc-mean-z", "tgravityacc-std-x", "tgravityacc-std-y", 
                  "tgravityacc-std-z", "tbodyaccjerk-mean-x", "tbodyaccjerk-mean-y", 
                  "tbodyaccjerk-mean-z", "tbodyaccjerk-std-x", "tbodyaccjerk-std-y", 
                  "tbodyaccjerk-std-z", "tbodygyro-mean-x", "tbodygyro-mean-y", 
                  "tbodygyro-mean-z", "tbodygyro-std-x", "tbodygyro-std-y", 
                  "tbodygyro-std-z", "tbodygyrojerk-mean-x", "tbodygyrojerk-mean-y", 
                  "tbodygyrojerk-mean-z", "tbodygyrojerk-std-x", "tbodygyrojerk-std-y", 
                  "tbodygyrojerk-std-z", "tbodyaccmag-mean", "tbodyaccmag-std", 
                  "tgravityaccmag-mean", "tgravityaccmag-std", "tbodyaccjerkmag-mean", 
                  "tbodyaccjerkmag-std()", "tbodygyromag-mean", "tbodygyromag-std", 
                  "tbodygyrojerkmag-mean", "tbodygyrojerkmag-std", "fbodyacc-mean-x", 
                  "fbodyacc-mean-y", "fbodyacc-mean-z", "fbodyacc-std-x", 
                  "fbodyacc-std-y", "fbodyacc-std-z", "fbodyacc-meanfreq-x", 
                  "fbodyacc-meanfreq-y", "fbodyacc-meanfreq-z", "fbodyaccjerk-mean-x", 
                  "fbodyaccjerk-mean-y", "fbodyaccjerk-mean-z", "fbodyaccjerk-std-x", 
                  "fbodyaccjerk-std-y", "fbodyaccjerk-std-z", "fbodyaccjerk-meanfreq-x", 
                  "fbodyaccjerk-meanfreq-y", "fbodyaccjerk-meanfreq-z", "fbodygyro-mean-x", 
                  "fbodygyro-mean-y", "fbodygyro-mean-z", "fbodygyro-std-x", 
                  "fbodygyro-std-y", "fbodygyro-std-z", "fbodygyro-meanfreq-x", 
                  "fbodygyro-meanfreq-y", "fbodygyro-meanfreq-z", "fbodyaccmag-mean", 
                  "fbodyaccmag-std", "fbodyaccmag-meanfreq", "fbodybodyaccjerkmag-mean", 
                  "fbodybodyaccjerkmag-std", "fbodybodyaccjerkmag-meanfreq", 
                  "fbodybodygyromag-mean", "fbodybodygyromag-std", "fbodybodygyromag-meanfreq", 
                  "fbodybodygyrojerkmag-mean", "fbodybodygyrojerkmag-std", 
                  "fbodybodygyrojerkmag-meanfreq", "angle-tbodyaccmean", 
                  "angle-tbodyaccjerkmean", "angle-tbodygyromean", 
                  "angle-tbodygyrojerkmean", "angle-gravmean-x", 
                  "angle-gravmean-y", "angle-gravmean-z)")

# Save resulting dataset 
write.csv(DF, "test_train.csv", row.names = FALSE)

################################################################################

# For each activity for each subject (for both train and test types), 
# calculate the mean for each of the motion measurements  
DF3 <- DF %>%
    group_by(type, subject, activity) %>% 
    summarise_each(funs(mean))

# Save resulting dataset 
write.csv(DF3, "test_train_average.csv", row.names = FALSE)

# save dataset for submission 
write.table(DF3, "test_train_average.txt", row.names = FALSE)
