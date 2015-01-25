library(dplyr)

# Set WD to the data set
setwd("./UCI HAR Dataset")

# Read the Train folder
X_train <- read.table("./train/X_train.txt")
Y_train <- read.table("./train/Y_train.txt")
subject_train <- read.table("./train/subject_train.txt")

# Read the Test folder
X_test <- read.table("./test/X_test.txt")
Y_test <- read.table("./test/Y_test.txt")
subject_test <- read.table("./test/subject_test.txt")

features <- read.table("./features.txt", stringsAsFactors=FALSE)
labels <- read.table("./activity_labels.txt", stringsAsFactors=FALSE)
colnames(labels) <-c("id","name")

X <- rbind(X_test, X_train)
Y <- rbind(Y_test, Y_train)
colnames(Y)<-"Activity"

subject <- rbind(subject_test, subject_train)
colnames(subject)<-"Subject"

# Set variable names using the features table
col <- c()
for (i in 1:561)
{
   col <- cbind(col, features$V2[i])
}

# Select the columns containins mean or std (ignoring case)
c1 <- grep("mean", col, ignore.case=TRUE)
c2 <- grep("std", col, ignore.case=TRUE)
C <- c(c1,c2)

# Extract only the relevant columns and set the names
focused <- dplyr::select(X, C)
focusednames <- col[C]
colnames(focused)<-focusednames

# Add the activity and subject
t1 <- cbind(Y, focused)
final <- cbind(subject, t1)

# And replace activity by name
final[["Activity"]] <- labels[match(final[['Activity']], labels[['id']]), 'name']

# Group by activity and subject
result <- final %>% group_by(Activity, Subject) %>% summarise_each(funs(mean))

# export the results for submission
write.table(result, "result.txt", row.name=FALSE)
