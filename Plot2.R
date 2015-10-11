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

#Plot 2
par(mfrow=c(1,1))
plot(scopedData$Time,  scopedData$Global_active_power, type = "l", ylab="Global Active Power (Kilowatts)", xlab="" )

#Copy Plot2 to PNG file
dev.copy(png, file = "Plot2.png")

#Close the PNG file device
dev.off()  