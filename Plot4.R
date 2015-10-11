#ZIP File URL
zipUrl <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#ZIP file name
zipFile <- "./household_power_consumption.zip" 

#Data File name
dataFile <- "./household_power_consumption.txt"

#Download and Unzip the file
if (!file.exists(dataFile)) {
    download.file(zipUrl, zipFile)
    unzip(zipFile, overwrite = T, exdir = ".")
}

#get column names for the data
cnames <- names(read.table(dataFile, header = T, nrows=1,sep=";", na.strings="?"))

#Read Data
powerConsumption <- read.table(dataFile, header=T, sep=";", na.strings="?")

#Set Names
powerConsumption <- setNames(powerConsumption,cnames)

# Get Data Scope
scopedData <- powerConsumption[powerConsumption$Date %in% c("1/2/2007","2/2/2007"),]

scopedData$Time <- strptime(paste(scopedData$Date, scopedData$Time), "%d/%m/%Y %H:%M:%S")

# Check Data Structure
head(scopedData)
tail(scopedData)
str(scopedData)

#Plot 4
par(mfrow = c(2,2),cex=0.6)
# plot 2 first
plot(scopedData$Time,  scopedData$Global_active_power, type = "l", ylab="Global Active Power", xlab="", col="green" )
# Then the next new plot
plot(scopedData$Time,  scopedData$Voltage, type="l", ylab="Voltage",xlab="datetime", col="pink")
# then plot 3
plot(scopedData$Time,  scopedData$Sub_metering_1, type = "l", ylab="Energy sub metering", xlab="" )
lines(x =scopedData$Time, y= scopedData$Sub_metering_2, col="red")
lines(x =scopedData$Time, y= scopedData$Sub_metering_3, col="blue")
legend("topright", lty=c(1,1,1), col = c("black", "red", "blue"), text.width=100000 , bty="n", 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

# Then the last new plot
plot(scopedData$Time,  scopedData$Global_reactive_power, type="l", ylab="Global_reactive_power",xlab="datetime", col="brown")

#Copy Plot4 to PNG file
dev.copy(png, file = "Plot4.png")

#Close the PNG file device
dev.off()  