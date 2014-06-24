
#set workpath 
#workPath <- "/Users/mac/Desktop/CH/course/Getting and Cleaning Data/project/data/UCI HAR Dataset"


run_analysis <- function(workPath) {

  setwd(workPath)  
  
  #read data from files
  #read activitity label 
  actLabel <- read.table("activity_labels.txt", header = FALSE)
  names(actLabel) <- c("Act_label", "activity")
  
  #read column name
  columnNames <- read.table("features.txt", header = FALSE)
  
  #read training data 
  subject_train <- read.table(paste("train", .Platform$file.sep, "subject_train.txt", sep=""), header = FALSE)
  #subject_train <- read.table("train/subject_train.txt", header = FALSE)
  names(subject_train) <- "Subject"
  
  trainData <- read.table(paste("train", .Platform$file.sep,"X_train.txt", sep=""), header = FALSE)
  #trainData <- read.table("train/X_train.txt", header = FALSE)
  names(trainData) <- columnNames[, 2]
  
  trainLabel <- read.table(paste("train", .Platform$file.sep,"y_train.txt", sep=""), header = FALSE)
  #trainLabel <- read.table("train/y_train.txt", header = FALSE)
  names(trainLabel) <- "Act_label"
  trainLabel$ID <- 1:nrow(trainLabel)
  
  trainActivity <- merge(trainLabel, actLabel, by = "Act_label", all.x = TRUE)
  o <- order(trainActivity$ID)
  trainActivity <- trainActivity[o, -2]
  
  #read test data
  subject_test <- read.table(paste("test", .Platform$file.sep, "subject_test.txt", sep=""), header = FALSE)
  #subject_test <- read.table("test/subject_test.txt", header = FALSE)
  names(subject_test) <- "Subject"
  
  testData <- read.table(paste("test", .Platform$file.sep, "X_test.txt", sep=""), header = FALSE)
  #testData <- read.table("test/X_test.txt", header = FALSE)
  names(testData) <- columnNames[, 2]
  
  testLabel <- read.table(paste("test", .Platform$file.sep, "y_test.txt", sep=""), header = FALSE)
  #testLabel <- read.table("test/y_test.txt", header = FALSE)
  names(testLabel) <- "Act_label"
  testLabel$ID <- 1:nrow(testLabel)
  
  testActivity <- merge(testLabel, actLabel, by = "Act_label", all.x = TRUE)
  o <- order(testActivity$ID)
  testActivity <- testActivity[o, -2]
  
  
  #get the colums of mean and std
  meanColumn <- grep("mean()", columnNames[, 2])
  meanFreqColumn <- grep("meanFreq()", columnNames[, 2])
  meanFreqInd <- which(meanColumn %in% meanFreqColumn, arr.ind = TRUE)
  justmeanColumn <- meanColumn[-meanFreqInd]
  
  stdColumn <- grep("std()", columnNames[, 2])
  selectedColumn <- c(justmeanColumn, stdColumn)
  o <- order(selectedColumn)
  selectedColumn <- selectedColumn[o]
 
  selectedTestData <- testData[, selectedColumn]
  selectedTrainData <- trainData[, selectedColumn]
  
  #names(selectedTestData) <- names(selectedTrainData) <- columnNames[selectedColumn, 2]
  
  #add activity column
  selectedTestData$activity <- testActivity$activity
  selectedTrainData$activity <- trainActivity$activity
  
  #merge test and train data into one data set
  allData <- rbind(selectedTrainData, selectedTestData)
  
  #write the data as txt file
  outfile <- "AllmeanAndStdData.txt"
  write.table(allData, outfile, quote = FALSE, row.names = FALSE, sep = " ")
  
  #get all data
  names(testData) <- names(trainData) <- columnNames[, 2]
  
  #add activity column
  testData$activity <- testActivity$activity
  trainData$activity <- trainActivity$activity
  
  #add subject column
  TestData1 <- cbind(testData, subject_test)
  TrainData1 <- cbind(trainData, subject_train)
  
  #merge test and train data into one data set
  allData1 <- rbind(TestData1, TrainData1)
  
  #calculate mean by subject and activity
  nColAll <- ncol(allData1)
  meanData <- apply(allData1[, 1:(nColAll-2)], MARGIN = 2, function(x, y){by(x, y, mean)}, y = paste(allData1[, nColAll-1], "_", allData1[, nColAll], sep = "") )
  
  #output data as txt file
  outfile <- "meanBysubjectActivity.txt"
  write.table(meanData, outfile, quote = FALSE)
}
