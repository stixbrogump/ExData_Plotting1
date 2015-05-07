library(sqldf)
myData <- read.csv.sql("household_power_consumption.txt", sql = "SELECT * from file WHERE Date in ('1/2/2007','2/2/2007') ", sep = ";", header = TRUE)
##View structure
str(myData)
##Remove empty data
myData<-myData[myData$Global_active_power !="?",]
##Create a combined datetime column
myData$DateTime <- strptime(paste(myData$Date, myData$Time), "%d/%m/%Y %H:%M:%S")


##Open Device
png(file = "plot2.png")
plot(myData$DateTime, myData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

##Close device
dev.off() 