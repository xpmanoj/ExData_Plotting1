# Download file
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileURL,temp, method ="curl")
dt <- data.table(read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";",na.strings = "?"))
unlink(temp)
str(dt)
summary(dt)
dt_sub = dt[dt$Date == "1/2/2007" | dt$Date == "2/2/2007",]
nrow(dt_sub)

#Plot on screen first and then save as a PNG
with(dt_sub, hist(as.numeric(as.character(dt_sub$Global_active_power)), xlab = "Global Active Power (kilowatts)", main= "Global Active Power", col ="red"))  ## Create plot on screen device

dev.copy(png, file = "plot1.png")  ## Copy  plot to a PNG file
dev.off()  