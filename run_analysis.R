run_analysis <- function() {
        
        require(package="reshape2")
        
        ## load and unzip
        
        if(!file.exists("./data")){dir.create("./data")}
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl,destfile="./data/data.zip")
        unzip("./data/data.zip", exdir="./data")
        
        ## load and prepare datas
        activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
        colnames(activity_labels) <- c("id", "actname")
        
        features <- read.table("./data/UCI HAR Dataset/features.txt")
        colnames(features) <- c("column", "fname")
        
        ## Merge the training and the test sets to create one data set.
        X <- rbind(read.table("./data/UCI HAR Dataset/test/X_test.txt"), 
                   read.table("./data/UCI HAR Dataset/train/X_train.txt"))
        colnames(X) <- features$fname
        
        ## Extract only the measurements on the mean and standard deviation for each measurement. 
        extracted <- X[,grep("(-mean\\(\\)|-std\\(\\))", features$fname)]
        
        ## makes column names more tidy
        tidycolnames <- sub("-", "", colnames(extracted))
        tidycolnames <- sub("-", "", tidycolnames)
        tidycolnames <- sub("\\(", "", tidycolnames)
        tidycolnames <- tolower(sub("\\)", "", tidycolnames))
        colnames(extracted) <- tidycolnames
        
        ## further prepare datas
        y <- rbind(read.table("./data/UCI HAR Dataset/test/y_test.txt"), read.table("./data/UCI HAR Dataset/train/y_train.txt"))
        colnames(y) <- "activity"
        
        subject <- rbind(read.table("./data/UCI HAR Dataset/test/subject_test.txt"), read.table("./data/UCI HAR Dataset/train/subject_train.txt"))
        colnames(subject) <- "subject"
        
        merged <- cbind(subject, y, extracted)
        
        ## Use descriptive activity names to name the activities in the data set
        ## Appropriately label the data set with descriptive activity names. 
        merged$activity <- factor(merged$activity, labels=activity_labels$actname)
        
        ## Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
        molten <- melt(merged, id = c("subject", "activity"))
        tidy <- dcast(molten, formula = subject + activity ~ variable, mean)
        
        ## save it
        write.table(tidy, file = "tidy.txt")
        
        tidy
}