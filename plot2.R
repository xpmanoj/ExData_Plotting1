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
png(filename='plot2.png')
# Make plot
plot(dt_sub$DateTime,dt_sub$Global_active_power,
ylab="Global Active Power (kilowatts)", xlab="", type='l')
#Turn off device
dev.off()
