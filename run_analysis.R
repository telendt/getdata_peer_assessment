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
    # load all the features (be explicit)
    features <- read.table(file.path(dataRootDir, "features.txt"),
                           header = FALSE,
                           nrows = 561,
                           sep = " ",
                           quote = "",
                           col.names = c("id", "name"),
                           colClasses = c("integer", "character"))

    # filter just the features we want (mean and standard deviation)
    featuresWanted <- features[grep("-(mean|std)\\(\\)", features$name),]

    # rename features (remove dashes and parenthesis, camel case and convert to factor)
    featuresWanted$name <- factor(
        gsub("-([a-zA-Z])([a-z]*)(?:\\(\\))?",
             "\\U\\1\\E\\2",
             featuresWanted$name,
             perl = TRUE))

    # load activities (be explicit)
    activities <- {
        a <- read.table(file.path(dataRootDir, "activity_labels.txt"),
                        header = FALSE,
                        nrows = 6,
                        sep = " ",
                        quote = "",
                        col.names = c("id", "name"),
                        colClasses = c("integer", "factor"))
        assertthat::are_equal(a$id, 1:6)
        a$name
    }

    # helper function that loads specific data set
    loadDataSet <- function(dataSetName) {
        path <- file.path(dataRootDir, dataSetName)
        subjects <- read.table(file.path(path, sprintf("subject_%s.txt", dataSetName)),
                               colClasses = "integer")[,1]
        assertthat::assert_that(all(subjects %in% 1:30))

        # skip columns for features we don't need
        colClasses <- rep("NULL", nrow(features))
        colClasses[featuresWanted$id] = "numeric"
        xData <- read.table(file.path(path, sprintf("X_%s.txt", dataSetName)),
                            colClasses = colClasses)
        colnames(xData) <- featuresWanted$name

        yData <- read.table(file.path(path, sprintf("y_%s.txt", dataSetName)),
                            colClasses = "integer")[,1]

        cbind(subject=subjects, activity=activities[yData], xData)
    }

    rbind(loadDataSet("train"), loadDataSet("test"))
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
write.table(testAndTrainData, file = "step4.txt", row.name=FALSE)

# step 5
testAndTrainDataSummary <- summarizeData(testAndTrainData)
write.table(testAndTrainDataSummary, file = "step5.txt", row.name=FALSE)