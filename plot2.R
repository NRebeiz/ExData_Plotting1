###Plot 2 for Exploring data###
#load libraries
library(data.table)
library(lubridate)
## to run this code, please download data file and set your
#working directory to where you store the file. 
#read full data, set na.strings to NA, 
#all columns are class "character".
fulldf <- data.table::fread("household_power_consumption.txt", header = TRUE, 
                            na.strings = "NA", stringsAsFactors = F)
###summary and string to get classess of data, descriptions
summary(fulldf)
str(fulldf)
###subset based on row numbers for the dates specified, 2 days, 
#feb 1 and 2nd, 2007
energy <- subset(fulldf[66638:69516, ])
#change value to numeric
energy$Global_active_power <- as.numeric(energy$Global_active_power)
#create a datetime object
energy$Date_time <- as.POSIXct(paste(energy$Date, energy$Time), 
                               format = "%d/%m/%Y %H:%M:%S")
#plot
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(energy$Date_time, energy$Global_active_power, type ="l", lty=1, 
     xlab = "", ylab = "Global Active Power (Kilowatts)", cex.axis=0.75)
dev.off()
