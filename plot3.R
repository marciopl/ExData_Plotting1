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
# Sets plot device
png(filename = "plot3.png", width = 480, height = 480)
# starts a blank plot for Date vs Sub_metering with blank x-axis label and defined y-axis label
plot(hpc$Date, hpc$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
# plots lines with different colors for each submetering
lines(hpc$Date, hpc$Sub_metering_1, col = "black")
lines(hpc$Date, hpc$Sub_metering_2, col = "red")
lines(hpc$Date, hpc$Sub_metering_3, col = "blue")
# adds a legend to the plot
legend("topright", legend = names(hpc)[c(6,7,8)], lwd = 1, col = c("black", "red", "blue"))
# writes plot to device
dev.off()