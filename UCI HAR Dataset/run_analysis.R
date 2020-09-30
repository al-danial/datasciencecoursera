library(dplyr)

# 1. Merges the training and the test sets to create one data set.

features = read.table("features.txt")
labels = read.table("activity_labels.txt")

x_train = read.table("train/X_train.txt")
y_train = read.table("train/y_train.txt")

x_test = read.table("test/X_test.txt")
y_test = read.table("test/y_test.txt")

x_all = rbind(x_train,x_test)
y_all = rbind(y_train,y_test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

sel_feat = grep("mean\\(\\)|std\\(\\)",features$V2)
x_all = x_all[,sel_feat]

# 3. Uses descriptive activity names to name the activities in the data set

colnames(labels) = c("id","activity")
colnames(y_all) = "id"
y_all = left_join(y_all,labels, by = "id")

# 4. Appropriately labels the data set with descriptive variable names.

colnames(x_all) = features[sel_feat,]$V2


# 5. From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject.

sub_train = read.table("train/subject_train.txt")
sub_test = read.table("test/subject_test.txt")

subjects = rbind(sub_train,sub_test)
colnames(subjects) = "subject"


df = cbind(x_all,subjects,data.frame(activity = y_all$activity))

df = df %>% group_by(activity, subject) %>% summarize_each(funs(mean))
