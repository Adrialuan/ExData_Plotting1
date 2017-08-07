## Plot 1
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

## Open png file
png(filename='plot1.png', height=480, width=480, units = "px")
## plot 1: histogram of global Active Power
hist(as.numeric(data$Global_active_power), main="Global Active Power",xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Close file
dev.off()