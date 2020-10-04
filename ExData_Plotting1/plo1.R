## Creating Plot 1

library(data.table)
library(dplyr)
df = fread("household_power_consumption.txt")
df$Date = as.Date(df$Date, format = "%d/%m/%Y")

df = df %>% filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
df$datetime = as.POSIXct(paste(df$Date,df$Time))

hist(as.numeric(df$Global_active_power), main = "Global active power", xlab = "Global Active Power (kilowatts)", col = "orange")

dev.copy(png,file = "plot1.png")
dev.off()
