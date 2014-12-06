#Reading data from the downloaded file located in data subdirectory
electricData <- read.table("./data/household_power_consumption.txt",sep=";",
header=TRUE,colClasses = c("character", "character","numeric","numeric","numeric",
"numeric","numeric","numeric","numeric"),na.strings="?")

# Date and time format settings
electricData$Time <- strptime(electricData$Time,"%H:%M:%S")
electricData$Date <- as.Date(electricData$Date,"%d/%m/%Y")

# Subsetting data based on required dates
electricPlotData <- subset(electricData,Date <= as.Date("2007-02-02") & 
                             Date >= as.Date("2007-02-01"))
# Creating the png file
png(filename = "plot1.png",width = 480, height = 480, units = "px")
# Plotting the histogram
hist(electricPlotData$Global_active_power,col="red",xlab="Global Active Power (kilowatts)", main="Global Active Power")
# Closing the connection
dev.off()
