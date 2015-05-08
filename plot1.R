# This library will let us filter rows by whether they have the right dates!
# Want Feb 1 and 2, 2007.
library(sqldf)
data <- read.csv.sql("household_power_consumption.txt", 
                     header=TRUE,
                     sep=";",
                     sql="select * from file where Date = '1/2/2007' or Date='2/2/2007'",
                     colClasses=c("character", "character", rep("numeric", 7)))
# Close the connection to the file that was opened by read.csv.sql
closeAllConnections()

png("plot1.png", width=480, height=480)
hist(data$Global_active_power, 
     col='red',
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)"
     )
dev.off()
