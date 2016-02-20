###########################  
# Lisa Nelson
# Exploratory Data Analysis
# February, 2016
# Week 1 project
# Plot 4
############################

###Assignment 
#This assignment uses data from the UC Irvine Machine Learning Repository, a popular repository for machine learning datasets. 
#In particular, we will be using the "Individual household electric power consumption Data Set" 
#Dataset: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# Housekeeping
setwd("C:/Users/Lisa/Documents/Coursera/ExploratoryDataAnalysis/Week1Git")
library(dplyr)

#Download and unpack
fileURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipname = "household_power_consumption.zip"
download.file(fileURL, zipname )
unzip(zipname)
filename = "household_power_consumption.txt"

#Get classes from first few rows
elec5 <- read.table(filename, 
               sep=";", 
               header = TRUE,
               na.strings = "?",
               fill=FALSE, 
               strip.white=TRUE,
               nrows=5)
classes <- sapply(elec5, class)

#Run full load with Colclasses to make it faster
elecfull = read.table(filename, 
               sep=";", 
               header = TRUE,
               colClasses = classes, 
               na.strings = "?",
               fill=FALSE, 
               strip.white=TRUE)

#Bring in just correct dates
startdate <- as.Date("20070102", "%Y%d%m")
enddate <- as.Date("20070202", "%Y%d%m")
elec <-  filter(elecfull, as.Date(elecfull$Date, "%d/%m/%Y") == as.Date(startdate) 
                       |  as.Date(elecfull$Date, "%d/%m/%Y") == as.Date(enddate) )

#Fix dates to be useful
elec$DateTime <- with(elec, as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))
elec$Date <- as.Date(elec$Date, "%d/%m/%Y")
elec$Time <- strptime(elec$Time, "%H:%M:%S")


#####  Make plots
## Plot 4 - 3 Graphs
plot.new()
png(file="./figure/plot4.png", width=480, height=480)  #direct to png because legend doesn't survive the copy well
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))


#1
with(elec, {
     plot (DateTime, Global_active_power,
           type="l", 
           col="black", 
           xlab="",
           ylab="Global Active Power (kilowatts)"
     )
  
#2   
     plot (DateTime, Voltage,
           type="l", 
           col="black", 
           xlab="",
           ylab="Voltage"
     )

#3  
     plot (DateTime, Sub_metering_1, 
           type="l", 
           xlab="",
           ylab="Energy sub metering",
           col="black"
     )
     lines (DateTime, Sub_metering_2, 
             type="l", 
             col="red" 
     )
     lines (DateTime, Sub_metering_3, 
             type="l", 
             col="blue"
     )
  
     legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), cex=0.5)
     
#4
     plot (DateTime, Global_reactive_power,
           type="l", 
           col="black", 
           xlab="datetime"
     )
})

dev.off()
