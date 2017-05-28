library(readr)
library(dplyr)

if(!file.exists("Data")){
        dir.create("Data")
        fileURL="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        file_name="./Data/Electric_Power_Consumption.zip"
        download.file(fileURL, destfile = file_name)
        unzip(file_name, overwrite = T, exdir = "Data")
}


fileName<-"./Data/household_power_consumption.txt"
hhpower<-read_delim(fileName, delim = ";", na=c("", "?", "NA"))
hhpower$Date<-as.Date(hhpower$Date, "%d/%m/%Y")
hhpower<-subset(hhpower, Date>=as.Date("2007-02-01") & Date<=as.Date("2007-02-02"))
hhpower<-mutate(hhpower, datetime=as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))


##plot3
png(filename="plot3.png", width = 480, height = 480, units = "px")
with(hhpower, plot(datetime, Sub_metering_1, type = "n", ann = F))
with(hhpower, lines(datetime, Sub_metering_1, col="black"))
with(hhpower, lines(datetime, Sub_metering_2, col="red"))
with(hhpower, lines(datetime, Sub_metering_3, col="blue"))
title(ylab = "Energy sub metering")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black","red","blue"), lty = 1) 

dev.off()




