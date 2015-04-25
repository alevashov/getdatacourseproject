setwd("~/study/GettingData/work_scripts/course project")
if(!file.exists("./data")){dir.create("./data")}
#setting pathes to read files
#folders
rootPath <- "./data/"
testPath <- "./data/test/"
trainPath <- "./data/train/"
#test files
subjectTestPath <- paste(testPath, "subject_test.txt", sep="")
xTestPath <- paste(testPath, "X_test.txt", sep="")
yTestPath <- paste(testPath, "y_test.txt", sep="")
#training files
subjectTrainPath <- paste(trainPath, "subject_train.txt", sep="")
xTrainPath <- paste(trainPath, "X_train.txt", sep="")
yTrainPath <- paste(trainPath, "y_train.txt", sep="")
#additional files
featuresPath <- paste(rootPath, "features.txt", sep="")
activitiesPath <- paste(rootPath, "activity_labels.txt", sep="")

# reading text files to varialbles
subjectTest <- read.table(subjectTestPath)
xTest <- read.table(xTestPath)
yTest <- read.table(yTestPath)

subjectTrain <- read.table(subjectTrainPath)
xTrain <- read.table(xTrainPath)
yTrain <- read.table(yTrainPath)

features <-read.table(featuresPath)
activities <- read.table(activitiesPath)

#naming columns in datasets
colnames(xTest) <- features[,2]
colnames(xTrain) <- features[,2]

#working with activities, merging names with ids
#test set
yTest$id  <- 1:nrow(yTest)
yTest1 <- merge (yTest, activities, by.x="V1", by.y="V1", sort=FALSE)
yTest1 <- yTest1[order(yt1$id), ]
#training set
yTrain$id  <- 1:nrow(yTrain)
yTrain1 <- merge (yTrain, activities, by.x="V1", by.y="V1", sort=FALSE)
yTrain1 <- yTrain1[order(yTrain1$id), ]
#Adding activity reference to xTrain and xTest
xTrain$Activity <- yTrain1$V2
xTest$Activity <-yTest1$V2
#Adding subject references
xTrain$Subject <- subjectTrain$V1
xTest$Subject <- subjectTest$V1
#merging to one dataframe
m <- rbind(xTrain, xTest)

#filtering out not required columns, we will keep mean, standard deviation, activity and subject 
# as I assume that activity and subject are required for future operations
library(dplyr)

# fixing column names to avoid duplication error
valid_column_names <- make.names(names=names(m), unique=TRUE, allow_ = TRUE)
names(m) <- valid_column_names

mt <- select(m, Activity, Subject, contains("Mean"), contains("std"))
#making new dataset with average of each variable for each activity and each subject

# setting new tidy dataframe structure

d5names <- names(mt)
 
d5 <- data.frame()
n <-30 #number of subjects
s <-nrow(activities)
l<- length(d5names) - 2
# calculating average for each combination of Activity and Subject and saving data in d5 dataframe
for (i in 1:s)
        {
        for (j in 1:n)
                {
                tdata <- filter(mt, Activity==activities[i,2] & Subject==j)
                tdata1 <- select(tdata, -(Activity:Subject))
                
                trow <-data.frame()
                trow[1,1] <- activities[i,2]
                trow[1,2] <- j
                tm <- colMeans(tdata1, na.rm = FALSE)
                for (k in 1:l)
                     {
                             trow[1,2+k] <- tm[k]
                     }
                d5<-rbind(d5, trow[1,])
                }       
        }
#setting meaningful descriptive names to columns
names(d5) <- d5names
write.csv(d5, file=paste(rootPath, "d5.csv", sep=""))

