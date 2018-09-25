### Week 1 Assignment for Exploratory Data Analysis ###
### Code to construct Plot 2 ### 

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

### Construct Plot 2: Date on x axis; Global active power on y axis; line graph
plot(dataset$datetime,dataset$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "n") ## makes it so points are not on plot
lines(dataset$datetime,dataset$Global_active_power)
dev.copy(png, file = "plot2.png") ## default is 480pi x 480pi
dev.off()
