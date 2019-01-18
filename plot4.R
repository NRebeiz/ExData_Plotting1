###Plot4 for Exploring Data####
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
#change variables to numeric for plots later
energy$Global_active_power <- as.numeric(energy$Global_active_power)
energy$Voltage <- as.numeric(energy$Voltage)
energy$Global_reactive_power <- as.numeric(energy$Global_reactive_power) 
energy$Sub_metering_1 <- as.numeric(energy$Sub_metering_1)
energy$Sub_metering_2 <- as.numeric(energy$Sub_metering_2)
#create date_time variable
energy$Date_time <- as.POSIXct(paste(energy$Date, energy$Time), format = "%d/%m/%Y %H:%M:%S")
##open png
png(filename = "plot4.png", width= 480, height = 480, units = "px")
#set mfrow and margins to plot 2 x 2 plots (4 plots in total)
par(mfrow=c(2,2))
par(mar= c(4, 4, 3, 2)+0.2)

#plot 1 global active power
energy$Global_active_power <- as.numeric(energy$Global_active_power)
plot(energy$Date_time, energy$Global_active_power, type ="l", lty=1, xlab = "", 
     ylab = "Global Active Power", cex.axis= 0.75, cex.lab=0.75)
##plot 2 voltage over datetime
plot(energy$Date_time, energy$Voltage, type = "l", col = "black", cex= 0.5,
     xlab = "datetime", ylab= "Voltage", cex.axis= 0.75, cex.lab= 0.75)


#plot 3 sub_metering
plot(energy$Date_time, energy$Sub_metering_1, type = "l", col = "black" , 
     ylim = c(0, max(energy$Sub_metering_1)), xlab = "", 
     ylab = "Energy sub metering", cex.axis= 0.75, cex.lab=0.75)

#add a line for submetering 2
lines(energy$Date_time, energy$Sub_metering_2, type ="l", col= "red")
#add a line for submetering 3
lines(energy$Date_time, energy$Sub_metering_3, type ="l", col ="blue")
# Add a legend
legend("topright", inset= .01, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("Black", "red", "blue"), lty=1, cex=0.6, box.lty = 0)

###plot next, global reactive power
#set labels for y-axis, calling it a. 
a <- c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5)
plot(energy$Date_time, energy$Global_reactive_power, type = "l", col = "black", 
     xlab = "datetime", ylab= "Global_reactive_power",cex.axis= 0.75, cex.lab = 0.75, yaxt="n")
axis(2, at=a, labels = a, cex.axis=0.5)
dev.off()


