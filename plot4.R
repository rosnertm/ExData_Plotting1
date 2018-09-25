### Week 1 Assignment for Exploratory Data Analysis ###
### Code to construct Plot 4 ### 

## Read in file
library(dplyr)
zipfile_url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(zipfile_url, destfile = ".\\zip_file.zip")
unzip('zip_file.zip')

fullfile_name <- 'household_power_consumption.txt'
fullfile <- read.table('household_power_consumption.txt', header=T, sep = ';', na.strings = '?')
head(fullfile)
## subset file for the 2 dates of interest
lines <- grepl('^1/2/2007|^2/2/2007', fullfile$Date) ## need carrots; otherwise, will also match 11/2/2007; 21/2/2007, etc
dataset <- fullfile[lines,]
## check dataset
head(dataset)
tail(dataset)
rm(fullfile) ## clear full file from memory

## Now have a dataset with just the wanted dates of Feb 1 and 2, 2007
## Convert Date and Time vars to date and time objects in R
dataset$Date <- as.Date(dataset$Date,c('%d/%m/%Y'))
dataset$datetime <- strptime(paste(dataset$Date, dataset$Time), '%Y-%m-%d %H:%M:%S') ## add new column with date and time combined
head(dataset)


### Construct Plot 4: 4 plots as described below (going from left to right; top to bottom)
## a) datetime by global active power
## b) datetime by voltage 
## c) datetime by energy sub metering (1 = black; 2 = red; 3 = blue)
## d) datetime by global reactive power 

## set up parameters to fit 4 plots  
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))

## construct top Plot a
plot(dataset$datetime,dataset$Global_active_power, xlab = "", ylab = "Global Active Power", type = "n") ## makes it so points are not on plot
lines(dataset$datetime,dataset$Global_active_power)

## construct top Plot b
plot(dataset$datetime,dataset$Voltage, xlab = "datetime", ylab = "Voltage", type = "n") ## makes it so points are not on plot
lines(dataset$datetime,dataset$Voltage)

## construct Plot c
plot(dataset$datetime, dataset$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n") ## makes it so points are not on plot; use sub metering 1 to ensure y axis is large enough
lines(dataset$datetime,dataset$Sub_metering_1, col = "black")
lines(dataset$datetime,dataset$Sub_metering_2, col = "red")
lines(dataset$datetime,dataset$Sub_metering_3, col = "blue")
legend('topright', bty = "n", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = .75) ## bty = "n" removes border from legend; cex = .75 makes legend smaller

## construct Plot d
plot(dataset$datetime,dataset$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "n") ## makes it so points are not on plot
lines(dataset$datetime,dataset$Global_reactive_power)

dev.copy(png, file = "plot4.png") ## default is 480pi x 480pi
dev.off()
