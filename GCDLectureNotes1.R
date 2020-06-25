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

## Getting data from the internet - download.file()
# - Downloads a file from the internet
# - Even if you do this by hand, helps with reproducibility
# - Important parameters are url, destfile, method
# - Useful for downloading tab-delimited, csv, and other files

## Example - Baltimore camera data
fileURL <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileURL, destfile = "./data/cameras.csv", method = "curl")
list.files("./data")
dateDownloaded <- date()
dateDownloaded

## Some notes about download.file()
# - If the url starts with 'http' you can use download.file()
# - If the url starts with 'https' on Windows you may be okay (method = "curl" if not)
# - If the file is BIG, it might take a while
# - Be sure to record when you downloaded!!


## Reading local flat files
## Loading flat files - read.table()
# - This is the main function for reading data into R
# - Flexible and robust but requires more parameters
# - Reads the data into RAM - big data can cause problems
# - Important parameters: file, header, sep, row.names, nrows
# - Related: read.csv(), read.csv2()

cameraData <- read.table("./data/cameras.csv") # gives error. defaults to tab-delineated, ours is comma delineated
head(cameraData)                               # doesn't exist bc R couldn't read data


cameraData <- read.table("./data/cameras.csv", sep = ",", header = TRUE)
head(cameraData)

cameraData2 <- read.csv("./data/cameras.csv") # defaults to comma-delineated bc thats what csv's are. USE THIS ON CSVs.
head(cameraData2)

## Other read.table() paramaters
# - quote - you can tell R whether there are any quoted values. quote="" means no quotes
# - na.strings - set the character that represents a missing value
# - nrows - how many rows to read of the file
# - skip - number of lines to skip before starting to read
# Biggest trouble with reading flat files are quotation marks ' or " placed in data values. quote="" often resolves issue.


## Excel Files - EXAMPLE FILE NO LONGER EXISTS. MOTHER FUCKER. Code fails because of it. USE AS TEMPLATE.
if(!file.exists("data")) {dir.create("data")}
fileURL <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileURL, destfile = "./data/cameras.xlsx", method = "curl")
dateDownloaded2 <- date()
library('xlsx')
cameraData3 <- read.xlsx("./data/cameras.xlsx", sheetIndex = 1, header = TRUE)
colIndex <- 2:3
rowIndex <- 1:4
cameraDataSubset <- read.xlsx("./data/cameras.xlsx", sheetIndex = 1, colIndex = colIndex, rowIndex = rowIndex)
cameraDataSubset


## Further Notes on Excel files
# - The write.xlsx function will write out an Excel file w/ similar arguments
# - read.xlsx2 is much faster than read.xlsx but for reading subsets of rows my be slightly unstable
# - The XLConnect package has more options for writing and manipulating excel files. vignette is where to start!
# - In general, it is advised to store your data in either a database or in comma separated files (.csv) or tab separated
#   files (.tab/.txt) as they are easier to distribute - not everybody has access to Excel!


## Reading XML - Extensible Markup Language
# - Frequently used to store structured data
# - Particularly widely used in internet applications
# - Extracting XML is the basis for most web scraping
# - Components:
#       - Markup - labels that give the text structure
#       - Content - the actual text of the document

## Tags, Elements, and Attributes
# - Tags correspond to general labels
#       - Start tags   <section>
#       - End tags     </section>
#       - Empty tags   <line-break />
#       
# - Elements are spectic examples of tags
#       - <Greeting> Hello, world </Greeting>
#       
# - Attributes are componenets of the label
#       - <img src="jeff.jpg" alt="instructor"/>
#       - <step number="3"> Connect A to B. </step>

## Read the file into R. Because website has 'https', need to use Rcurl -> getURL -> xmlTreeParse
library(XML)
library(Rcurl)
fileURL <- "https://www.w3schools.com/XML/simple.xml"
xData <- getURL(fileURL)
doc <- xmlTreeParse(xData, useInternalNodes = TRUE)
rootNode <- xmlRoot(doc)      # node that wraps whole document. Ours is <breakfast_menu>
xmlName(rootNode)             # tells us the name of the root node. returns: "breakfast_menu"
names(rootNode)               # lists names of sub-nodes one level down

## subset XML documents like a list. first component is whole <food> node for Belgian Waffles
rootNode[[1]]
#returns: <food>
#        <name>Belgian Waffles</name>
#        <price>$5.95</price>
#        <description>Two of our famous Belgian Waffles with plenty of real maple syrup</description>
#        <calories>650</calories>
#        </food> 

## first component of the first component is just the <name> node of the Belgian Waffles
rootNode[[1]][[1]]
# returns: <name>Belgian Waffles</name> 

## Programatically extract parts of the file
xmlSApply(rootNode, xmlValue)

## XPath - additional language http://www.stat.berkeley.edu/~statcur/Workshop2/Presentations/XML.pdf
# - /node - Top level node
# - //node - Node at any level
# - node[@attr-name] -  Node with an attribute name
# - node[@attr-name='bob'] - Node with attribute name attr-name='bob'

## Get the items on the menu and prices
names <- xpathSApply(rootNode, "//name", xmlValue)
names
prices <- xpathSApply(rootNode, "//price", xmlValue)
prices

## Another example: http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens
## DOESN'T WORK EITHER. NOTHING IS CALLED 'score' OR 'team-name' ANYMORE.
fileURL <- "https://www.espn.com/nfl/team/_/name/bal/baltimore-ravens"
xData <- getURL(fileURL)
doc <- htmlTreeParse(xData, useInternalNodes = TRUE)
scores <- xpathSApply(doc, "//i[@class='score']", xmlValue)
teams <- xpathSApply(doc, "//li[@class='team-name']", xmlValue)
scores
teams


## JSON - Javascript Object Notation
# - Lightweight data storage
# - Common format for data from application programming interfaces (APIs)
# - Similar structure to XML but different syntax/format
# - Data stored as
#       - Numbers (doubles)
#       - Strings (double quoted)
#       - Boolean (true or false)
#       - Array (ordered, comma separated, enclosed in square brackets [])
#       - Object (unordered, comma separated collection of key:value pairs in curley brackets {})
# http://en.wikipedia.org/wiki/JSON

library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)
names(jsonData$owner$login)

myjson <- toJSON(iris, pretty = TRUE)  ## from data frame -> JSON
cat(myjson)
iris2 <- fromJSON(myjson)              ## from JSON -> data frame
head(iris2)

## Further resources for JSON
# - http://www.json.org/
# - tutorial for jsonlite - http://www.r-bloggers.com/new-package-jsonlite-a-smarter-json-encoderdecoder/
# - jsonlite vignette


## data.table
# - Inherets from data.frame
#       - All functions that accept data.frame work don data.table
# - Written in C, so it's much faster
# - Much, much faster at subsetting, grouping, and updating

library(data.table)
DF <- data.frame(x = rnorm(9), y = rep(c("a", "b", "c"), each = 3), z = rnorm(9))
head(DF, 3)

DT <- data.table(x = rnorm(9), y = rep(c("a", "b", "c"), each = 3), z = rnorm(9))
head(DT)

tables()

# Data tables subset like data frames do.
DT[2, ]
DT[DT$y == "a", ]
DT[c(2,3), ]
DT[, c(2,3)]
mean(DT$x)
sum(DT$z)
DT[, table(y)] # <- creates frequency table for values in y
DT[, w := z^2] # <- creates new column w which are the values of z^2
head(DT)

DT2 <- DT      # did not make a 'copy' of the first DT, so anything we do to DT is passed along to DT2. Weird.
DT[, y:=2]
head(DT, n=3)
head(DT2, n=3)

# Multiple operations on data table
DT[, m := {tmp <- (x+z); log2(tmp+5)}]
head(DT)

# plyr like operations
DT[, a:= x > 0]
DT
DT[, b:= mean(x+w), by = a]  # <- takes mean of x+w when a is true and takes mean of x+w when a is false.
DT

# Special variables
# .N An integer, length 1, containing the number of times that a particular group appear
set.seed(123)
DT <- data.table(x=sample(letters[1:3], 1E5, TRUE))
head(DT, 20)
DT[, .N, by = x]
# returns       x     N
#               1: c 33294
#               2: b 33305
#               3: a 33401

### Keys
DT <- data.table(x = rep(c("a", "b", "c"), each = 100), y = rnorm(300))
setkey(DT, x)
DT['a'] # subsets data where the key (x) is equal to 'a'.

## Joins
DT1 <- data.table(x = c('a', 'a', 'b', 'dt1'), y = 1:4)
DT2 <- data.table(x = c('a', 'b', 'dt2'), z = 5:7)
setkey(DT1, x) ; setkey(DT2, x)
merge(DT1, DT2)
# returns          x y z
#               1: a 1 5
#               2: a 2 5
#               3: b 3 6


## Fast reading
big_df <- data.frame(x = rnorm(1E6), y = rnorm(1E6))
file <- tempfile()
write.table(big_df, file = file, row.names = FALSE, col.names = TRUE, sep = "\t", quote = FALSE)
system.time(fread(file))  # fread() is basically read.table() for tab-separated files. took 0.33 sec to read
system.time(read.table(file, header = TRUE, sep = "\t")) # took 3.39 sec to read.

## Summary and further reading
# - the latest development version contains new functions like 'melt' and 'dcast' for data.tables
#       - https://r-forge.r-project.org/scm/viewvc.php/pkg/NEWS?view=markup&root=datatable
# - Here is a list of differences between data.table and data.frame
#       - http://stackoverflow.com/questions/13618488/what-you-can-do-with-data-frame-that-you-cant-in-data-table
# - Notes based on Raphael Gottardo's notes, who got them from Kevin Ushey
#       - https://github.com/raphg/Biostat578/blob/master/Advanced_data_manipulation.Rpres
