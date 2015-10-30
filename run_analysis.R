#!/usr/bin/env Rscript

# This script:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation
#    for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy
#    data set with the average of each variable for each activity and each
#    subject.

# This function returns data set produced in steps 1-4
getTrainAndTestData <- function(dataRootDir) {
    read.txt <- function(filename, ...) {
        read.table(file.path(dataRootDir, filename),
                   header = FALSE,
                   quote = "",
                   ...)
    }

    features.total = 561
    # get only wanted features with descriptive variable names
    features <- {
        # load all the features
        f <- read.txt("features.txt",
                      nrows = features.total,
                      col.names = c("id", "name"),
                      colClasses = c("integer", "character"))

        # filter just the features we want (mean and standard deviation)
        wanted <- f[grep("-(mean|std)\\(\\)", f$name),]

        # rename features (remove dashes and parenthesis, translate to camel case and convert to factor)
        wanted$name <- factor(
            gsub("-([a-zA-Z])([a-z]*)(?:\\(\\))?",
                 "\\U\\1\\E\\2",
                 wanted$name,
                 perl = TRUE))
        wanted
    }

    activities <- {
        # load activities
        a <- read.txt("activity_labels.txt",
                      nrows = 6,
                      col.names = c("id", "name"),
                      colClasses = c("integer", "factor"))
        assertthat::are_equal(a$id, 1:6)
        a$name
    }

    # helper function that loads specific data set
    loadDataSet <- function(dataSetName, nrows = -1) {
        path <- function(pattern) file.path(dataSetName, sprintf(pattern, dataSetName))

        subjects <- read.txt(path("subject_%s.txt"), nrows = nrows, colClasses = "integer")[,1]
        assertthat::assert_that(all(subjects %in% 1:30))

        colClasses <- rep("NULL", features.total) # skip columns for features we don't need
        colClasses[features$id] = "numeric"
        signalValues <- read.txt(path("X_%s.txt"), colClasses = colClasses)
        colnames(signalValues) <- features$name

        act <- activities[read.txt(path("y_%s.txt"), colClasses = "integer")[,1]]

        cbind(subject=subjects, activity=act, signalValues)
    }

    rbind(loadDataSet("train", nrows = 7352), loadDataSet("test", nrows = 2947))
}

# This function returns data set (summary) described in step 5.
summarizeData <- function(data) {
    library(dplyr) # used to calculate summary
    # return average of each variable for each activity and each subject
    # QUESTION: does it mean that the order of group_by should be (activity, subject)?
    data %>% group_by(activity, subject) %>% summarize_each(funs(mean))
}

# step 4
testAndTrainData <- getTrainAndTestData(file.path(getwd(), "UCI HAR Dataset"))
write.table(testAndTrainData, file = "step4.txt", row.name = FALSE)

# step 5
testAndTrainDataSummary <- summarizeData(testAndTrainData)
write.table(testAndTrainDataSummary, file = "step5.txt", row.name = FALSE)