GettingAndCleaningDataCourseProject
===================================
run_analysis.R script takes as the input the contents of the unzipped dataset, which can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Input is unzipped into R working directory for the script.

Firstly, script reads the variety of files from the input and merges test and training data into one big dataset.

Second, it puts the names of the activities as column names and puts "mean" and "std" variables into separate data.frame called "meanAndStd".

Thirdly, script creates a vector of character lables for activities using numeric lables and character description file activity_labels.txt. Then it merges meanAndStd with subject and label variables, and names all the columns accordingly.

Finally, it subsets the dataset by label and subject, finds the average for each variable and puts it into new tidy data set "clean", which is outputed into "tidyDataSet.txt"
