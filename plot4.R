library(data.table)

# Download file
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileURL,temp, method ="curl")
dt <- data.table(read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";",
                            na.strings = "?",   colClasses = c(rep("character",2),rep("numeric",7))))
unlink(temp)

#Subset for the respective dates
dt_sub = dt[dt$Date == "1/2/2007" | dt$Date == "2/2/2007",]
nrow(dt_sub) # no of rows after subsetting
dt_sub[,DateTime:= as.POSIXct(paste(dt_sub$Date,dt_sub$Time), format = "%d/%m/%Y %H:%M:%S")]

#Open PNG file
png(filename="plot4.png")
# Make plot

par(mfrow = c(2,2))
#plot first
plot(dt_sub$DateTime,dt_sub$Global_active_power,
             ylab="Global Active Power (kilowatts)", xlab="", type='l')
#plot second
plot(dt_sub$DateTime,dt_sub$Voltage,
            ylab="Voltage", xlab="datetime", type='l')
#plot third
plot(dt_sub$DateTime,dt_sub$Sub_metering_1,type="l", xlab ="", ylab = "Energy sub metering")
lines(dt_sub$DateTime,dt_sub$Sub_metering_2,type="l", col = "red")
lines(dt_sub$DateTime,dt_sub$Sub_metering_3,type="l", col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), col = c("black", "red","blue"), lty ="solid")
#plot fourth
plot(dt_sub$DateTime,dt_sub$Global_reactive_power, xlab ="datetime", ylab = "Global_reactive_power",type="l")

#Turn off device
dev.off()
