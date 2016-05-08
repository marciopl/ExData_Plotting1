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
png(filename = "plot1.png", width = 480, height = 480)
# plots histogram for Global Active Power
hist(hpc$Global_active_power, xlab = "Global Active Power (killowatts)", main = "Global Active Power", col = "red")
# writes on device
dev.off()
