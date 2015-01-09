##download and unzip file
URL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(URL,destfile="power_consumption.zip",method="internal")
unzip("power_consumption.zip")

## Store data
filename<-"household_power_consumption.txt"
mydata<-read.table(filename,sep=";",header=TRUE,colClasses = "character")

## Set English as language in order to have weekdays in english
Sys.setlocale("LC_TIME", "English")

## Change format of the date
mydata$Date<-as.Date(mydata$Date,"%d/%m/%Y")

## Subset the dataset and modify the format of data to numeric
feb<-subset(mydata,Date=="2007-02-01"|Date=="2007-02-02")
for(n in 3:9) {feb[,n]<-as.numeric(feb[,n])}

## Change time format
for (n in 1:2880) {feb[n,2]<-paste(as.character(feb[n,1]),feb[n,2])}
feb$Time<-strptime(feb$Time,format="%Y-%m-%d %H:%M:%S")

png(file = "Plot3.png", width = 480, height = 480, units = "px")  ## Open PNG device; create 'Plot3.png' in my working directory
plot(feb$Time,feb$Sub_metering_1,xlab= "",ylab = "Energy sub metering",col="black",type="n")
points(feb$Time,feb$Sub_metering_1,col="black",type="l")
points(feb$Time,feb$Sub_metering_2,col="red",type="l")
points(feb$Time,feb$Sub_metering_3,col="blue",type="l")
legend("topright", pch = "-", col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
dev.off() 
