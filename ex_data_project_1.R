#set working directory so that files get copied where I want them
setwd("~/Coursera/Exploratory_Data_Analysis")

#load any packages that will be needed
library(dplyr)

#download the relevant data
columnnames <- names(read.table("./exdata-data-household_power_consumption/household_power_consumption.txt",
                                nrow=1, header=TRUE, sep=";"))
alldata <- read.table("./exdata-data-household_power_consumption/household_power_consumption.txt",
                      sep = ";", na.strings = "?",
                      col.names = columnnames,
                      skip = grep("1/2/2007", 
                                  readLines("./exdata-data-household_power_consumption/household_power_consumption.txt"))-1,
                      nrows = 2880)
#create a new column for date + time and convert it to a date class
alldata <- mutate(alldata, DateAndTime = paste(Date, Time))
alldata$DateAndTime <- strptime(alldata$DateAndTime, format = "%d/%m/%Y  %H:%M:%S")

#Plot 1- histogram of showing frequency at different levels of Global active power
hist(alldata$Global_active_power, 
     col = "red", 
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")
#copy to a png file
dev.copy(png, file = "plot1.png")
dev.off()

#Plot 2- line graph showing global active power changing over the course of 2 days
plot(alldata$DateAndTime, alldata$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)")
#copy to a png file
dev.copy(png, file = "plot2.png")
dev.off()

#Plot 3- line graph showing the 3 change in sub-metering levels over the course of 2 days
plot(alldata$DateAndTime, alldata$Sub_metering_1, 
     type = "l", 
     xlab = "", 
     ylab = "Energy sub metering")
lines(alldata$DateAndTime, alldata$Sub_metering_2, col = "red")
lines(alldata$DateAndTime, alldata$Sub_metering_3, col = "blue")
legend(x = "topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty = 1)
#copy to a png file
dev.copy(png, file = "plot3.png")
dev.off()

#Plot 4- 4 line graphs showing different variables and their changes over 2 days
par(mfrow = c(2, 2), mar = c(3, 2, 1, 1))
plot(alldata$DateAndTime, alldata$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power")
plot(alldata$DateAndTime, alldata$Voltage, 
     type = "l", 
     xlab = "DateTime", 
     ylab = "Voltage")
plot(alldata$DateAndTime, alldata$Sub_metering_1, 
     type = "l", 
     xlab = "", 
     ylab = "Energy sub metering")
lines(alldata$DateAndTime, alldata$Sub_metering_2, col = "red")
lines(alldata$DateAndTime, alldata$Sub_metering_3, col = "blue")
legend(x = "topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty = 1, 
       cex = 0.5)
plot(alldata$DateAndTime, alldata$Global_reactive_power, 
     type = "l", 
     xlab = "DateTime", 
     ylab = "Global Reactive Power")
#copy to a png file
dev.copy(png, file = "plot4.png")
dev.off()