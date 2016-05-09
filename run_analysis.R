## Merges the training and the test sets to create one data set.
library(dplyr)
library(tidyr)

## Train
trainingset_subject = read.table("./datasciencecoursera/UCI HAR Dataset/train/subject_train.txt")
trainingset_X = read.table("./datasciencecoursera/UCI HAR Dataset/train/X_train.txt") 
trainingset_y = read.table("./datasciencecoursera/UCI HAR Dataset/train/y_train.txt")

## Combine all Train sets
trainingsets = mutate(subject = as.integer(trainingset_subject$V1), 
                      y = as.integer(trainingset_y$V1),
                      trainingset_X)

## Test
testset_subject = read.table("./datasciencecoursera/UCI HAR Dataset/test/subject_test.txt")
testset_X = read.table("./datasciencecoursera/UCI HAR Dataset/test/X_test.txt")
testset_y = read.table("./datasciencecoursera/UCI HAR Dataset/test/y_test.txt")

## Combine all Test sets
testsets = mutate(subject = as.integer(testset_subject$V1), 
                  y = as.integer(testset_y$V1),
                  testset_X)

## Merge into one data set
mergedData = merge(trainingsets, testsets, all = TRUE)


## Extracts only the measurements on the mean and standard deviation for each measurement.
## Shows, mean, median etc...
summary(mergedData)

## Extract means
extractMean <- sapply(mergedData, mean, na.rm = TRUE)

## Extract standard deviations
extractSd <- sapply(mergedData, sd)

## Mean and Standard Deviation for each measurement
mean_sd <- list(extractMean, extractSd)


## Uses descriptive activity names to name the activities in the data set.
mergedData$y[mergedData$y == 1] <- "WALKING"
mergedData$y[mergedData$y == 2] <- "WALKING_UPSTAIRS" 
mergedData$y[mergedData$y == 3] <- "WALKING_DOWNSTAIRS" 
mergedData$y[mergedData$y == 4] <- "SITTING" 
mergedData$y[mergedData$y == 5] <- "STANDING" 
mergedData$y[mergedData$y == 6] <- "LAYING"

## Print mergedData to see changes in the y column
head(mergedData)
tail(mergedData)        


## Appropriately labels the data set with descriptive variable names.
featureVars = read.table("./datasciencecoursera/UCI HAR Dataset/features.txt")

names(mergedData) <- featureVars$V2


## From the data set in step 4, creates a second, independent tidy data set with the 
## average of each variable for each activity and each subject.
Average_mergedData = sapply(mergedData, mean)

write.csv(Average_mergedData, file = "tidydataset.csv")
write.table(Average_mergedData, "./datasciencecoursera/UCI HAR Dataset/tidydataset.txt", row.name = FALSE)
