GetDataAndClean
===============

Coursera's data science series II, Getting and cleaning data

To get the Project required tidy data sets, please following the procedures.

Step 1: download the source data and unpacked it 

Step 2: source the run_analysis.R file
      -- under your R prompt, type source("https://github.com/chunhungChou/GetDataAndClean/blob/master/run_analysis.R") 
Step 3: setting the workPath argument as the directory where your unpacked data set located      
      for my own example: workPath <- "/Users/mac/Desktop/CH/course/Getting and Cleaning Data/project/data/UCI HAR Dataset"

Step 4: under R Prompt, type run_analysis(workPath), after finished the running process, you will get two .txt files -- AllmeanAndStdData.txt and meanBysubjectActivity.txt under the workPath directory. The file AllmeanAndStdData.txt is the tidy format file for all mean and std columns and activity column with real activites name. The meanBysubjectActivity.txt is the tidy format file for average of each variable for each activity and each subject.
