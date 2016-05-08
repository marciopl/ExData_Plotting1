# reads csv
# subsets data to use only dates 2007-02-01 and 2007-02-02
# parses Date and Time column to use date time format on Date column, drops Time column 
# return filtered data
loadFilteredData <- function() {
  hpc <- read.csv("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = c("?"))
  filtered_data <- subset(hpc, Date %in% c("1/2/2007", "2/2/2007"))
  date_time <- paste(as.character(filtered_data$Date), " ", as.character(filtered_data$Time))
  filtered_data$Date <- strptime(date_time, format = "%d/%m/%Y %H:%M:%S")
  filtered_data$Time <- NULL
  filtered_data
}

# Reads data
hpc <- loadFilteredData()
# sets plot device
png(filename = "plot4.png", width = 480, height = 480)
# sets graphics parameters telling we'll use 2 columns and 2 row of plots
par(mfrow=c(2,2))
# plots 1st graph
plot(hpc$Date, hpc$Global_active_power, type="l", xlab = "", ylab = "Global Active Power")
# plots 2nd graph
with(hpc, plot(Date, Voltage, xlab="datetime", type="l"))
# plots 3rd graph
plot(hpc$Date, hpc$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(hpc$Date, hpc$Sub_metering_1, col = "black")
lines(hpc$Date, hpc$Sub_metering_2, col = "red")
lines(hpc$Date, hpc$Sub_metering_3, col = "blue")
# sets legend for 3rd graph without the box line
legend("topright", legend = names(hpc)[c(6,7,8)], lwd = 1, col = c("black", "red", "blue"), bty = "n")
# plots 4th graph
with(hpc, plot(Date, Global_reactive_power, xlab="datetime", type="l"))
# writes to device
dev.off()
