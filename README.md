GetDataAndClean
===============

Coursera's data science series II, Getting and cleaning data

To get the Project required tidy data sets, please following the procedures.

Step 1: download the source data and unpacked it 

Step 2: setting the workPath argument as the directory where your unpacked data set located      
        workPath <- "your file path/UCI HAR Dataset"

Step 3: source the run_analysis.R file
    3-1: download the run_analysis.R file to your R workPath
    3-2: under your R prompt, type source("your file path/UCI HAR Dataset/run_analysis.R") 

Step 4: under R Prompt, type run_analysis(workPath), after finished the running process, you will get two .txt files -- AllmeanAndStdData.txt and meanBysubjectActivity.txt under the workPath directory. The file AllmeanAndStdData.txt is the tidy format file for all mean and std columns and activity column with real activites name. The meanBysubjectActivity.txt is the tidy format file for average of each variable for each activity and each subject.
