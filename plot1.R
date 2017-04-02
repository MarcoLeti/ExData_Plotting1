#-----------------------------------------------#
# Author: Marco Letico                          #
# Data Science specialization by Coursera       #
# Exploratory Data Analysis Week 1              #
#-----------------------------------------------#


# Create the directory, download the file and unzip it
if(!exists("myDir")){dir.create("myDir")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./myDir/myZip.zip")
setwd("./myDir")
unzip(zipfile = "myZip.zip")


# Check if the package sqldf is installed, in negative case, install it.
if (!"sqldf" %in% installed.packages()) {
        warning("Installing sqldf package.")
        install.packages("sqldf")
}

library(sqldf)
fileName <- "household_power_consumption.txt"

# Filter data with sql query before loading into R
myData <- read.csv.sql(fileName, 
                       sep = ";",
                       header = TRUE,
                       sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'")
closeAllConnections()


# Create the histogram
png(filename="plot1.png", width = 480, height = 480)
hist(myData$Global_active_power,
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power"
)
dev.off()