# This library will let us filter rows by whether they have the right dates!
# Want Feb 1 and 2, 2007.
library(sqldf)
data <- read.csv.sql("household_power_consumption.txt", 
                     header=TRUE,
                     sep=";",
                     sql="select * from file where Date = '1/2/2007' or Date='2/2/2007'",
                     colClasses=c("character", "character", rep("numeric", 7)))

# Turn Dates and Times into datetime objects
data$datetime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

png("plot4.png", width=480, height=480)

# Want to put 4 plots in a 2x2 grid
par(mfrow=c(2,2))

# The first plot is the same as plot2, with a slight change to the y axis label. 
plot(data$datetime, data$Global_active_power,
     main="",
     xlab="",
     ylab="Global Active Power",
     type='l')

# The second plot is very similar but using Voltage instead of 
# Global_active_power, and we have a label on the x-axis now
plot(data$datetime, data$Voltage,
     main="",
     xlab="datetime",
     ylab="Voltage",
     type='l')

# The third plot is the same as plot3, but without a line around the legend.
# make an empty plot so we add the three submetering results separately
plot(data$datetime, data$Sub_metering_1,
     main="",
     xlab="",
     ylab="Energy sub metering",
     type='n')
points(data$datetime, data$Sub_metering_1, type='l', col='black')
points(data$datetime, data$Sub_metering_2, type='l', col='red')
points(data$datetime, data$Sub_metering_3, type='l', col='blue')
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c('black', 'red', 'blue'), lwd=1,
       bty="n") # No box

# The fourth plot
plot(data$datetime, data$Global_reactive_power, 
     type='l',
     xlab="datetime", 
     ylab="Global_reactive_power")

dev.off()
