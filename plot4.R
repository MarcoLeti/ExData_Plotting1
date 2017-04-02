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


# Concatenate column Date with Time and convert it
myX <- paste(myData$Date, myData$Time)
myX2 <- strptime(myX, format = "%d/%m/%Y %H:%M:%S")

# Plot initial settings
png(filename="plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

# Create plot topleft
plot(myX2, myData$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power"
)


# Create the plot topright
plot(myX2, myData$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage"
)


# Create the plot bottomleft
plot(myX2, myData$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering"
)
points(x = myX2,
       y = myData$Sub_metering_2,
       type = "l",
       col = "red"
)
points(x = myX2,
       y = myData$Sub_metering_3,
       type = "l",
       col = "blue"
)
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1,1),
       col = c("black", "red", "blue"),
       bty = "n"
)


# Create the plot bottomright
plot(myX2, myData$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power"
)
dev.off()