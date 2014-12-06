#Reading data from the downloaded file located in data subdirectory
electricData <- read.table("./data/household_power_consumption.txt",sep=";",
header=TRUE,colClasses = c("character", "character", "numeric","numeric",
"numeric","numeric","numeric","numeric","numeric"),na.strings="?")

# Date format settings
electricData$Date <- as.Date(electricData$Date,"%d/%m/%Y")

# Subsetting data based on required dates
electricPlotData <- subset(electricData,Date <= as.Date("2007-02-02") & 
Date >= as.Date("2007-02-01"))

# Formatting time as per the required format for the plot
electricPlotData$Time <- paste(electricPlotData$Date,electricPlotData$Time,sep=" ")
electricPlotData$Time <- strptime(electricPlotData$Time,"%Y-%m-%d %H:%M:%S")

# Creating the png file
png(filename = "plot2.png",width = 480, height = 480, units = "px")

# Creating the plot
with(electricPlotData,plot(Time,Global_active_power,type="l",xlab="",
                           ylab="Global Active Power(kilowatts)"))
# Closing the connection
dev.off()
