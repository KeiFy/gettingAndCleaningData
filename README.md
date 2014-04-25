gettingAndCleaningData
======================
## Introduction
This project is a submission for the peer reviewed project in the "Getting and Cleaning Data" Coursera course (getdata-002). The goal of the project was to obtain and clean up data pertaining to an experiment conducted using samsung data. 
## File descriptions
* README.md is this file
* get_data.R is the script to download the archive and extract the directory structure
* run_analysis.R is the script to load the data, clean it up and produce the tidy dataset
* CodeBook.md is the file describing each variable in the data set
## Assumptions made
* the mean and std variables are only those whose names end with -mean() and -std() respectively
* variables with Mean in name that represent the angle between gravityMean and other things are excluded
* variable names were to be cleaned up in order to make them more descriptive
* the variable names in the final, tody dataset were not to include the word "average" but instead have the name identical to the averaged variable. The rationale behind this choice is that having "average" and "mean" in the same variable name would be confusing
