gettingAndCleaningData
======================
## Introduction
This project is a submission for the peer reviewed project in the "Getting and Cleaning Data" Coursera course (getdata-002). The goal of the project was to obtain and clean up data pertaining to an experiment conducted using samsung data. 

## File descriptions
* README.md is this file
* get_data.R is the script to download the archive and extract the directory structure
* run_analysis.R is the script to load the data, clean it up and produce the tidy dataset
* CodeBook.md is the file describing each variable in the data set

## Usage
* as a first step, run and get_data.R script to download and extract the data, and to set the directory
* as a second step, run the run_analysis.R script which will load the files, process them and put out the tidy dataset

## Assumptions made
* the mean and std variables are only those whose names end with -mean() and -std() respectively
* variables with Mean in name that represent the angle between gravityMean and other things are excluded
* variable names were to be cleaned up in order to make them more descriptive
* the variable names in the final, tody dataset were not to include the word "average" but instead have the name identical to the averaged variable. The rationale behind this choice is that having "average" and "mean" in the same variable name would be confusing
* the variable names look better with words capitalized - even though they are harder to type, they are easier to read and understand as one can see where each word starts; in variables comprised of such a large number of words, all-lowercase would be unreadable
* the directory structure of the archive was to be preserved when extracting files
