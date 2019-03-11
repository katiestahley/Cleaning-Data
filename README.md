# Coursera Getting and Cleaning Data final assignment CODEBOOK

## Files used 
- https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
	- 
	- 'README.txt'

	- 'features_info.txt': Shows information about the variables used on the feature vector.

	- 'features.txt': List of all features.

	- 'activity_labels.txt': Links the class labels with their activity name.

	- 'train/X_train.txt': Training set.

	- 'train/y_train.txt': Training labels.

	- 'test/X_test.txt': Test set.

	- 'test/y_test.txt': Test labels.

	- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- run_analysis.R

## Files created 
- README.md
- Codebook.md 
- test_train_average.csv

## Analysis performed 

1. Download and open UCI HAR data and read into R. 
2. Subset the 8 files needed to create tidy dataset.
3. Clean up the *features* file and use it to name both the test and train dataframes with descriptive variable names. 
4. Add the appropriate *type* column to both the test and train dataframes. 
5. Add descriptive activity names to name the *activity* variable. 
6. Merge the test and train dataframes. 
7. Extract only the measurements on the mean and standard deviation for each measurement.
8. Calcuate the average of each variable for each activity and each subject for both the test and train types. 
9. Save resulting dataset. 
