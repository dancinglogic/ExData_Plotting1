# This library will let us filter rows by whether they have the right dates!
# Want Feb 1 and 2, 2007.
library(sqldf)
data <- read.csv.sql("household_power_consumption.txt", 
                     header=TRUE,
                     sep=";",
                     sql="select * from file where Date = '1/2/2007' or Date='2/2/2007'",
                     colClasses=c("character", "character", rep("numeric", 7)))


# Turn Dates and Times into datetime objects
data$NewDate <- as.Date(data$Date, format="%d/%m/%Y")
data$datetime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

# want x axis to go from min date to max date
xlimits <- c(min(data$datetime), max(data$datetime))
# want y axis to go from 0 to max submetering value
ylimits <- c(0, max(data$Sub_metering_1, data$Sub_metering_2, data$Sub_metering_3))

#plot
png("plot3.png", width=480, height=480)
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
       col=c('black', 'red', 'blue'), lwd=1)
dev.off()
