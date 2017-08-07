## Plot 2
## Check if the file exists and download it if not.

dfile <- "household_power_consumption.zip"
if (!file.exists(dfile)) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dfile, method="curl")
}
## Unzip the file.
file <- unz(dfile, unzip(dfile, list=TRUE)[1, "Name"])

## Read de data (Assuming that it's in the same directory)
hpc <- read.table(file, header=TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)

#Formatting Date column to date
hpc$Date <- as.Date(hpc$Date,format="%d/%m/%Y")

#Subsetting between two dates
data <-subset(hpc ,Date == "2007-02-02" | Date == "2007-02-01")

## Append DataTime column to data frame
data$DateTime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

## Plot and save to png file
png("plot2.png", height = 480, width = 480, units = "px")
plot(data$DateTime, data$Global_active_power, type= "l", xlab = "", ylab="Global Active Power (kilowatts)")

## Close file
dev.off()