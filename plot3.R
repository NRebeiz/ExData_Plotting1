#####Plot 3 for Exploring Data####
#load libraries
library(data.table)
library(lubridate)

## to run this code, please download data file and set your
#working directory to where you store the file. 
#read full data, set na.strings to NA, 
#all columns are class "character".
fulldf <- data.table::fread("household_power_consumption.txt", header = TRUE, na.strings = "NA", stringsAsFactors = F)
###summary and string to get classess of data, descriptions
summary(fulldf)
str(fulldf)
#subset based on row numbers for the dates specified, 2 days, 
#feb 1 and 2nd, 2007
energy <- subset(fulldf[66638:69516,  ])
#asummary of energy subset
summary(energy)
#change the submetering variables to numeric, submetering_3 is already numeric.
energy$Sub_metering_1 <- as.numeric(energy$Sub_metering_1)
#check that it worked and is numeric
summary(energy$Sub_metering_1)
#change second submeter_2 variable
energy$Sub_metering_2 <- as.numeric(energy$Sub_metering_2)
#Create a date_time object
energy$Date_time <- as.POSIXct(paste(energy$Date, energy$Time), 
                               format = "%d/%m/%Y %H:%M:%S")
#open a png file to save plot
png(filename = "plot3.png", width = 480, height = 480, units = "px")
#plot base plot with variable with largest (max) value, then add other lines.
plot(energy$Date_time, energy$Sub_metering_1, type = "l", col = "black" , 
     ylim = c(0, max(energy$Sub_metering_1)), xlab = "", cex.axis = 0.75,
     ylab = "Energy sub metering")
#add a line for submetering 2
lines(energy$Date_time, energy$Sub_metering_2, type ="l", col= "red")
#add a line for submetering 3
lines(energy$Date_time, energy$Sub_metering_3, type ="l", col ="blue")
# Add a legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("Black", "red", "blue"), lty=1, cex=0.8)
dev.off()
