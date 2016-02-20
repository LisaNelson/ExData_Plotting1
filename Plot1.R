###########################  
# Lisa Nelson
# Exploratory Data Analysis
# February, 2016
# Week 1 project
# Plot 1
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
## Plot 1 - Histogram
par(mfrow = c(1, 1), mar = c(4, 4, 2, 1))
hist(elec$Global_active_power, 
     col="red", 
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylim=c(0,1200), 
     xlim=c(0,8),
     breaks =16,
     xaxt = 'n'
)
axis(side=1, at=seq(0,6, 2), labels=seq(0,6,2))

pngFile = "./figure/plot1.png"
dev.copy(png, file = pngFile, width=480, height=480)
dev.off()

