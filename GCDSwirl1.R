### Getting and Cleaning Data - Swirl

library(swirl)
install_from_swirl("Getting and Cleaning Data")
swirl()
BJKill
1

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
data1 <- download.file(fileURL, destfile = "./data/IdahoHousing.csv", method = "curl")
data1 <- read.csv("./data/IdahoHousing.csv")
head(data1)
PropVal <- data1$VAL
MillVal <- PropVal[PropVal == 24]
head(PropVal)
length(PropVal[which(PropVal == 24)])


fileURL2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
data2 <- download.file(fileURL2, destfile = "./data/NaturalGas.xlsx")
dat <- read.xlsx("./data/NaturalGas.xlsx", sheet = 1, cols = 7:15, rows = 18:23)
str(data2)
head(data2)
data2
dat
sum(dat$Zip*dat$Ext, na.rm = T)



fileURL3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
xFile <- getURL(fileURL3)
doc <- xmlTreeParse(xFile, useInternalNodes = TRUE)
rootNode <- xmlRoot(doc)
rootNode
zipcode <- xpathSApply(rootNode, "//zipcode", xmlValue)
zipcode
zipcode[which(zipcode == 21231)]
length(zipcode[which(zipcode == 21231)])


fileURL4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileURL, destfile = "./data/IdahoInfo.csv")





