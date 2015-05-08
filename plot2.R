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

#plot
png("plot2.png", width=480, height=480)
plot(data$datetime, data$Global_active_power,
     main="",
     xlab="",
     ylab="Global Active Power (kilowatts)",
     type='l')
dev.off()
