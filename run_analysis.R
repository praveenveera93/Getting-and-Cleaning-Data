

run_analysis <- function(){
  # load test data
  subject_test <- read.table("C:/Users/prave/Desktop/UCI HAR Dataset/test/subject_test.txt")
  X_test <- read.table("C:/Users/prave/Desktop/UCI HAR Dataseet/X_test.txt")
  Y_test <- read.table("C:/Users/prave/Desktop/UCI HAR Dataset/y_test.txt")
  
  # load train data
  subject_train <- read.table("C:/Users/prave/Desktop/UCI HAR Dataset/train/subject_train.txt")
  X_train <- read.table("C:/Users/prave/Desktop/UCI HAR Dataset/train/X_train.txt")
  Y_train <- read.table("C:/Users/prave/Desktop/UCI HAR Dataset/train/y_train.txt")
  
  # Load lookup information
  features <- read.table("C:/Users/prave/Desktop/UCI HAR Dataset/features.txt", col.names = c("featureId", "featureLabel"))
  activities <- read.table("C:/Users/prave/Desktop/UCI HAR Dataset/activity_labels.txt", col.names = c("activityId", "activityLabel"))
  activities$activityLabel <- gsub("_", "", as.character(activities$activityLabel))
  includedFeatures <- grep("-mean\\(\\)|-std\\(\\)", features$featuresLabel)
  
  #merge test and train data
  merge <- rbind(subject_test, subject_train)
  names(subject) <- "subjectId"
  X <- rbind(X_test, X_train)
  X <- X[, includedFeatures]
  names(x) <- gsub("\\(|\\)","", features$featuresLabel[includedFeatures])
  Y <- rbind(Y_test, Y_train)
  names(Y) = "activityId"
  activity <- merge(Y, activities, by = "activityId")$activityLabel
  
  # Merge data frames of different columns to form one data table
  data <- cbind(subject, X, activity)
  write.table(data, "merged_tidy_data.txt")
  
  # create a dataset grouped by subject and activity after applying standard deviation and average calculations
  library(data.table)
  dataDT <- data.table(data)
  calculatedData <- dataDT[, lapply(.SD, mean), by = c("subjectId", "activity")]
  write.table(calculatedData, "calculated_tidy_data.txt")
}
