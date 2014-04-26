## Readme

The goal of this project is to prepare tidy data that can be used for later analysis. The source raw data is the data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The R script called run_analysis.R was created in order to implement the project. In general that script does the following:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set by appropriately labels the data set with descriptive activity names. 
* Creates and store to the file a second, independent tidy data set with the average of each variable for each activity and each subject. 

You can find detailed description of the resulted tidy.txt file content in the codebook.

Below you will find a more detailed description of the script. Also run_analysis.R itself contains some useful comments related to the low-level details of project implementation.

* First of all script loads and unzips the raw data set.
* Then script reads the activity_labels.txt and features.txt in the data frames for the future use and assigns meaningful column names to these data frames. 
* After that script reads and merges in one data frame data from the original train and test raw data sets: ” X_test.txt”, “ X_train.txt”.
* For the propose of this project script extract only variables with “-mean()” and “-std()” in their names. These variables should correspond to the mean and standard deviation for each original measurement.
* Then script makes column names tidier by removing unsuitable characters from them (“-“, “(“, “)”) and by make column names low case.
* Finally script merges all parts of target data set together:  subject + activity + prepared on previous steps mean and standard deviations of measured variables. Also it uses descriptive activity names to name the activities in this resulted data set.
And as last step script calculates average of each variable for each activity and each subject and store new tidy data set to the file tidy.txt.
