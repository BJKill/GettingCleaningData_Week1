### Getting and Cleaning Data - Week 1 Lecture Notes


## Definition of data: "Data are values of qualitative or quantitative variables, belonging to a set of items."

## Raw vs. Processed Data
# Raw Data
#       - Original Source of the data
#       - Often hard to use for data analyses
#       - Data analysis *includes* processing
#       - Raw data may only need to be processed once.
# Processed Data
#       - Data that is ready for analysis
#       - Processing can include merging, subestting, transforming, etc
#       - There may be standards for processing
#       - All steps should be recorded

## Four components of tidy data:
#       1. The raw data
#       2. A tidy data set
#       3. A code book describing each variable and its values in the tidy data set ("metadata")
#       4. An explicit and exact recipe you used to for from 1 -> 2,3.

# You know the raw data is in the right format if you
#       1. Ran no software on the data
#       2. Did not manipulate any of the numbers in the data
#       3. You did not remove any data from the data set
#       4. You did not summarize the data in any way

## The tidy data
#       1. Each variable you measure should be in one column
#       2. Each different observation of that variable should be in a different row
#       3. There should be one table for each "kind" of variable
#       4. If you have multiple tables, they should include a column in the table that allows them to be linked
#
# Some other important tips:
#       - Include a row at the top of each file with variable names
#       - Make variable names human readable AgeAtDiagnosis instead of AgeDx
#       - In general, data should be saved in one file per table

## The code book
#       1. Information about the variables (including units!) in the data set not contained in the tidy data
#       2. Information about the summary choices you made
#       3. Information about the experimental study design you used
# 
# Some other important tips:
#       - A common format for this document is a Word/text file
#       - There should be a section called "Study design" that has a thorough description of how you collected the data
#       - There must be a section called "Code book" that describes each variable and its units

## The instruction list
#       - Ideally a computer script (in R), but Python is okay too...
#       - The input for the script is the raw data
#       - The output is the processed, tidy data
#       - There are no parameters to the script
#       
# In some cases, it will not be possible to script every step. In that case, you should provide instructions like:
#       1. Step 1 - take the raw file, run version 3.1.2 of summarize software with parameters a=1, b=2, c=3
#       2. Setp 2 - run the software separately for each sample
#       3. Step 3 - take column three of outputfile.out for each sample and that is the corresponding row in the output data

## Using R to download files
# - Get/set your working directory with getwd() and setwd()
# - Be aware of relative vs absolute paths
#       - Relative - setwd("./data), setwd("../")
#       - Absolute - setwd("/Users/jtleek/data/")
# - Important difference in Windows setwd("C:\\Users\\Andrew\\Downloads")

## Checking for and creating directories
# - file.exists("directorName") will check to see if directory exists
# - dir.create("directoryName") will create a directory if it doesn't exists
# example code:
if (!file.exists("data")) {
        dir.create("data")
}


 







