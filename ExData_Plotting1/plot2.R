## Creating Plot 2

library(data.table)
library(dplyr)
df = fread("household_power_consumption.txt")
df$Date = as.Date(df$Date, format = "%d/%m/%Y")

df = df %>% filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
df$datetime = as.POSIXct(paste(df$Date,df$Time))

plot(y = df$Global_active_power, x = df$datetime, type = "l", ylab = "Global Active Power (kilowatts")

dev.copy(png,file = "plot2.png")
dev.off()
