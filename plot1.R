library(sqldf)
myData <- read.csv.sql("household_power_consumption.txt", sql = "SELECT * from file WHERE Date in ('1/2/2007','2/2/2007') ", sep = ";", header = TRUE)
##View structure
str(myData)
##Remove empty data
myData<-myData[myData$Global_active_power !="?",]
##Open Device
png(file = "plot1.png")
hist(myData$Global_active_power,col=c("red"),xlab="Global Acive Power (kilowatts)",main="Global Active Power",yaxp=c(0,1200,6),ylim = c(0,1200))
##Close device
dev.off() 
