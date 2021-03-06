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
#Open PNG file
png(filename='plot1.png')
# Make plot
#Plot on screen first and then save as a PNG
hist(dt_sub$Global_active_power, xlab = "Global Active Power (kilowatts)", main= "Global Active Power", col ="red")  
dev.off()  