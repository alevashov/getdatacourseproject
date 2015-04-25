---
title: "CodeBook Get Data course project"
author: "Alex Levashov"
date: "Saturday, April 25, 2015"
output: html_document
---

This is a codebook for Get Data Coursera course project.  Resuting tidy data set is stored in d5 data frame that has the next structure

#Data structure

##Activity 
 Activity type, there are 6 types of activity
 
##Subject 
 Subject Id, a reference to person who took part in experiment, 1 to 30 


##Measured variables (mean values)
Other 88 fields are means of Mean and Standard deviation variables as referred as subset from features.txt variables from original data set, full liste is below
[3] "tBodyAcc.mean...X"                   
[4] "tBodyAcc.mean...Y"                    "tBodyAcc.mean...Z"                    "tGravityAcc.mean...X"                
[7] "tGravityAcc.mean...Y"                 "tGravityAcc.mean...Z"                 "tBodyAccJerk.mean...X"               
[10] "tBodyAccJerk.mean...Y"                "tBodyAccJerk.mean...Z"                "tBodyGyro.mean...X"                  
[13] "tBodyGyro.mean...Y"                   "tBodyGyro.mean...Z"                   "tBodyGyroJerk.mean...X"              
[16] "tBodyGyroJerk.mean...Y"               "tBodyGyroJerk.mean...Z"               "tBodyAccMag.mean.."                  
[19] "tGravityAccMag.mean.."                "tBodyAccJerkMag.mean.."               "tBodyGyroMag.mean.."                 
[22] "tBodyGyroJerkMag.mean.."              "fBodyAcc.mean...X"                    "fBodyAcc.mean...Y"                   
[25] "fBodyAcc.mean...Z"                    "fBodyAcc.meanFreq...X"                "fBodyAcc.meanFreq...Y"               
[28] "fBodyAcc.meanFreq...Z"                "fBodyAccJerk.mean...X"                "fBodyAccJerk.mean...Y"               
[31] "fBodyAccJerk.mean...Z"                "fBodyAccJerk.meanFreq...X"            "fBodyAccJerk.meanFreq...Y"           
[34] "fBodyAccJerk.meanFreq...Z"            "fBodyGyro.mean...X"                   "fBodyGyro.mean...Y"                  
[37] "fBodyGyro.mean...Z"                   "fBodyGyro.meanFreq...X"               "fBodyGyro.meanFreq...Y"              
[40] "fBodyGyro.meanFreq...Z"               "fBodyAccMag.mean.."                   "fBodyAccMag.meanFreq.."              
[43] "fBodyBodyAccJerkMag.mean.."           "fBodyBodyAccJerkMag.meanFreq.."       "fBodyBodyGyroMag.mean.."             
[46] "fBodyBodyGyroMag.meanFreq.."          "fBodyBodyGyroJerkMag.mean.."          "fBodyBodyGyroJerkMag.meanFreq.."     
[49] "angle.tBodyAccMean.gravity."          "angle.tBodyAccJerkMean..gravityMean." "angle.tBodyGyroMean.gravityMean."    
[52] "angle.tBodyGyroJerkMean.gravityMean." "angle.X.gravityMean."                 "angle.Y.gravityMean."                
[55] "angle.Z.gravityMean."                 "tBodyAcc.std...X"                     "tBodyAcc.std...Y"                    
[58] "tBodyAcc.std...Z"                     "tGravityAcc.std...X"                  "tGravityAcc.std...Y"                 
[61] "tGravityAcc.std...Z"                  "tBodyAccJerk.std...X"                 "tBodyAccJerk.std...Y"                
[64] "tBodyAccJerk.std...Z"                 "tBodyGyro.std...X"                    "tBodyGyro.std...Y"                   
[67] "tBodyGyro.std...Z"                    "tBodyGyroJerk.std...X"                "tBodyGyroJerk.std...Y"               
[70] "tBodyGyroJerk.std...Z"                "tBodyAccMag.std.."                    "tGravityAccMag.std.."                
[73] "tBodyAccJerkMag.std.."                "tBodyGyroMag.std.."                   "tBodyGyroJerkMag.std.."              
[76] "fBodyAcc.std...X"                     "fBodyAcc.std...Y"                     "fBodyAcc.std...Z"                    
[79] "fBodyAccJerk.std...X"                 "fBodyAccJerk.std...Y"                 "fBodyAccJerk.std...Z"                
[82] "fBodyGyro.std...X"                    "fBodyGyro.std...Y"                    "fBodyGyro.std...Z"                   
[85] "fBodyAccMag.std.."                    "fBodyBodyAccJerkMag.std.."            "fBodyBodyGyroMag.std.."              
[88] "fBodyBodyGyroJerkMag.std.."  
 
#Explanation of the operations under the data

##1. Import of original data
Both training and test data were imported from files each to separate R variables
Activities list and variable names were also imported to R variables for future use

##2. Naming

- columns from features were applied as column names to train and test datasets 
- activity names were merged with ids for future use
- activity names and subject ids were added to train and test datasets as new columns

##3. Merge of train and test datasets
Train and test datasets were merged using rbind comand
```{r}
m <- rbind(xTrain, xTest)
```

##4. Subsetting

Not required columns were filtered out , using dplyr package select comand. 
It was required to fix non-unique names problem, fix from StackOverflow - http://stackoverflow.com/questions/17878048/r-merging-two-data-frames-while-keeping-the-original-row-order was applied

```{r}
valid_column_names <- make.names(names=names(m), unique=TRUE, allow_ = TRUE)
names(m) <- valid_column_names
mt <- select(m, Activity, Subject, contains("Mean"), contains("std"))
```

##5. New tidy dataset

To build new tidy dataset filter and select commands from dplyr package were used inside multi-level loop 

As a final step proper descriptive names were applied to new tidy dataset

Dataset was saved under d5.txt name in data directory
---
