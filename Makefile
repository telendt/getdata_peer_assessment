step4.txt step5.txt: UCI\ HAR\ Dataset run_analysis.R
	Rscript run_analysis.R

clean:
	rm -rf "UCI HAR Dataset" UCI_HAR_Dataset.zip step4.txt step5.txt

UCI\ HAR\ Dataset: UCI_HAR_Dataset.zip
	unzip $<
	touch "$@"

UCI_HAR_Dataset.zip:
	curl -s "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" -o $@

.PHONY: clean
