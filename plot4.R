library(sqldf)
myData <- read.csv.sql("household_power_consumption.txt", sql = "SELECT * from file WHERE Date in ('1/2/2007','2/2/2007') ", sep = ";", header = TRUE)
##View structure
str(myData)
##Remove empty data - not too sure if this is the best method - ok - for learning graphing I suppose
myData<-myData[myData$Sub_metering_1 !="?",]
myData<-myData[myData$Sub_metering_2 !="?",]
myData<-myData[myData$Sub_metering_3 !="?",]
myData<-myData[myData$Global_active_power !="?",]
myData<-myData[myData$Global_reactive_power !="?",]
myData<-myData[myData$Voltage !="?",]
##Create a combined datetime column
myData$DateTime <- strptime(paste(myData$Date, myData$Time), "%d/%m/%Y %H:%M:%S")


##Open Device
png(file = "plot4.png")

#Create the 2x2 grid
par(mfrow = c(2,2))
#top left - global active power by time
plot(myData$DateTime, myData$Global_active_power, type = "l", ylab = "Global Active Power", xlab="")

#top right - voltage by time
plot(myData$DateTime, myData$Voltage, type = "l", ylab = "Voltage", xlab="datetime")

#Bottom left - sub metering graph
#we specify the  plot using first data series 
#but dont draw them as we use the lines function for that
plot(myData$DateTime, myData$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab="")
lines(myData$DateTime, myData$Sub_metering_1, col="black")
lines(myData$DateTime, myData$Sub_metering_2, col="red")
lines(myData$DateTime, myData$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), col=c("black", "red", "blue"))

#bottom right - global reactive power by time
plot(myData$DateTime, myData$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab="datetime")

##Close device
dev.off() 
