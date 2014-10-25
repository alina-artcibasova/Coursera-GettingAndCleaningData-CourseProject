##reading data
features <- read.table("./UCI HAR Dataset/features.txt")
activityLables <- read.table("./UCI HAR Dataset/activity_labels.txt")

trainSet <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainLables <- read.table("./UCI HAR Dataset/train/y_train.txt")
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

testSet <- read.table("./UCI HAR Dataset/test/X_test.txt")
testLables <- read.table("./UCI HAR Dataset/test/y_test.txt")
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

## > sum(testSubject %in% trainSubject)
## [1] 0
## means that there's no need to rename test subjects in any set

#creating merged set (1)
mergedSet <- rbind(trainSet, testSet)
mergedSubject <- rbind(trainSubject, testSubject)
mergedLables <- rbind(trainLables, testLables)

## extracting meand and standard deviation (2)
colnames(mergedSet) <- as.character(features$V2)
meanAndStd <- mergedSet[, grep("mean|std", names(mergedSet))]

## creating descriptive lables using mergedLables and activityLables (4)
descriptiveLables <- character()
for(i in 1:nrow(mergedLables))
    descriptiveLables[i] <- as.character(activityLables$V2[mergedLables[i,]])

oldnames <- colnames(meanAndStd)
meanAndStd <- cbind(descriptiveLables, mergedSubject, meanAndStd)

## adding descriptive activity names to columns (3)
colnames(meanAndStd) <- c("Lables", "Subject", as.character(oldnames))

## tidy data set with the average of each variable for each activity and each subject (5)
clean <- meanAndStd[1,]
for(sub in unique(meanAndStd$Subject))
  for (label in unique(meanAndStd$Lables)){
    m <- colMeans(meanAndStd[(meanAndStd$Lables == label &
                    meanAndStd$Subject == sub),
                    3:ncol(meanAndStd)])
    
    clean <- rbind(clean, c(label, sub, m))
  }
clean <- clean[2:nrow(clean),]

## output
write.table(clean, file = "tidyDataSet.txt", row.name=FALSE)