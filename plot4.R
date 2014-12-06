#Reading data from the downloaded file located in data subdirectory
electricData <- read.table("./data/household_power_consumption.txt",sep=";",header=TRUE,colClasses = c("character", "character", "numeric","numeric","numeric","numeric","numeric","numeric","numeric"),na.strings="?")

# Date format settings
electricData$Date <- as.Date(electricData$Date,"%d/%m/%Y")

# Subsetting data based on required dates
electricPlotData <- subset(electricData,Date <= as.Date("2007-02-02") & Date >= as.Date("2007-02-01"))

# Formatting time as per the required format for the plot
electricPlotData$Time <- paste(electricPlotData$Date,electricPlotData$Time,sep=" ")
electricPlotData$Time <- strptime(electricPlotData$Time,"%Y-%m-%d %H:%M:%S")

# Creating the png file
png(filename = "plot4.png",width = 480, height = 480, units = "px")

# Setting up for multiple plots
par(mfrow=c(2,2))

# first plot
with(electricPlotData,plot(Time,Global_active_power,type="l",xlab="",ylab="Global Active Power"))

# second plot
with(electricPlotData,plot(Time,Voltage,type="l",xlab="datetime",ylab="Voltage"))

# third plot
with(electricPlotData,plot(Time,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"))
lines(electricPlotData$Time,electricPlotData$Sub_metering_2,type="l",col="red")
lines(electricPlotData$Time,electricPlotData$Sub_metering_3,type="l",col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lwd=1)

# fourth plot
with(electricPlotData,plot(Time,Global_reactive_power,type="l",xlab="datetime"))

# Closing the connection
dev.off()
