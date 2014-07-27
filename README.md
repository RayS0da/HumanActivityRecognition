### Introduction

This R script will turn raw data into processed data and get a tidy data set.

### Procedure

1. Reads data from files, then merge the training and the test sets to create one data set;
2. Extracts the measurements on the mean and standard deviation for each measurement;
3. Uses descriptive activity names to name the activities in the date set and put the data into one 'data.frame';
4. Labels the data set with descriptive variable names, which listed in the CodeBook.md;
5. Creates the tidy data set as requested;
6. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

### Tidy Data

In tidy data,
1. Each variable forms a column;
2. Each observation forms a row;
3. Each type of observational unit forms a table.
This is Codd's 3rd normal form.
