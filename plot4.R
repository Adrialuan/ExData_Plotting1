## Plot 4
## Check if the file exists and download it if not.

dfile <- "household_power_consumption.zip"
if (!file.exists(dfile)) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dfile, method="curl")
}
## Unzip the file.
file <- unz(dfile, unzip(dfile, list=TRUE)[1, "Name"])

## Read de data (Assuming that it's in the same directory)
hpc <- read.table(file, header=TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)

## Formatting Date column to date
hpc$Date <- as.Date(hpc$Date,format="%d/%m/%Y")

## Subsetting between two dates
data <-subset(hpc ,Date == "2007-02-02" | Date == "2007-02-01")

## Append DataTime column to data frame
data$DateTime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

## Plot and save to file (png)
png("plot4.png", height = 480, width = 480, units = "px")

## Define de grid (tow rows and two columns) to draw plots
par(mfrow=c(2, 2))

## Top left Plot
plot(data$DateTime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power")

## Top right Plot
plot(data$DateTime, data$Voltage, type="l", xlab="datetime", ylab="Voltage")

## Bottom left Plot
plot(data$DateTime, data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(data$DateTime, data$Sub_metering_2, type="l", col="red")
lines(data$DateTime, data$Sub_metering_3, type="l", col="blue")
legend("topright", lwd=1, col=c("black", "red", "blue"), legend=names(data[, 7:9]), bty="n")

## Bottom left Plot
plot(data$DateTime, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

## Close File
dev.off()