library(sqldf)
myData <- read.csv.sql("household_power_consumption.txt", sql = "SELECT * from file WHERE Date in ('1/2/2007','2/2/2007') ", sep = ";", header = TRUE)
##View structure
str(myData)
##Remove empty data
myData<-myData[myData$Sub_metering_1 !="?",]
myData<-myData[myData$Sub_metering_2 !="?",]
myData<-myData[myData$Sub_metering_3 !="?",]

##Create a combined datetime column
myData$DateTime <- strptime(paste(myData$Date, myData$Time), "%d/%m/%Y %H:%M:%S")


##Open Device
png(file = "plot3.png")
#we specify the  plot using first data series 
#but dont draw them as we use the lines function for that
plot(c(myData$DateTime), c(myData$Sub_metering_1), type = "n", ylab = "Energy sub metering", xlab="")
lines(myData$DateTime, myData$Sub_metering_1, col="black")
lines(myData$DateTime, myData$Sub_metering_2, col="red")
lines(myData$DateTime, myData$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), col=c("black", "red", "blue"))


##Close device
dev.off() 
