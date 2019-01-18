###plot 1 for Exploring Data, Coursera###
#load library data.table 
library(data.table)

#to run this code, please download data file and set your
#working directory to where you store the file. 
#read full data, set na.strings to NA, 
#all columns are class "character".
fulldf <- data.table::fread("household_power_consumption.txt", header = TRUE, 
                            na.strings = "NA", stringsAsFactors = F)
#summary and string to get classess of data, descriptions
summary(fulldf)
str(fulldf)
#subset based on row numbers for the dates specified, 2 days, 
#feb 1 and 2nd, 2007
energy <- subset(fulldf[66638:69516, ])
#show if any numbers are NA/missing, answer is zero. 
sum(is.na(energy))
#create a data variable
energy$Date <- as.Date(energy$Date, format = "%d/%m/%Y")
#Check it's class, should be Date.
class(energy$Date)
#change global active power to numerical
energy$Global_active_power <- as.numeric(energy$Global_active_power)
#check that its numeric

class(energy$Global_active_power)
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(energy$Global_active_power, col= "red", xlab = "Global Active Power (kilowatts)",
     ylab =  "Frequency", cex.lab= 0.75, main = "Global Active Power", font.main = 2)
dev.off()

