Getting and Cleaning Data Course Project
========================================

This repository contains the course project for the course Getting and
Cleaning Data.

Purpose
-------

The purpose of this project is to demonstrate my ability to collect,
work with, and clean a data set. The goal is to prepare tidy data that
can be used for later analysis.

The R script
------------

The file `run_analysis.R` contains the R-code needed to produce two
tidy datasets. The first one (`step4.txt`) contains the means and
standard deviations for the different measures from Human Activity
Recognition Using Smartphones Dataset. The second dataset
(`step5.txt`) contains the averages (over subject and activity type)
of all the features in the first dataset.

The script assumes that the Samsung data is in the working directory.

Usage
-----

If you have GNU Make installed just run:

    make

Otherwise download and unzip `UCI HAR Dataset` and run:

    Rscript run_analysis.R

or (in interactive session):

    source('run_analysis.R')

Code Book
---------

See [`CodeBook.md`](CodeBook.md).