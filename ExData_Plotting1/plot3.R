## Creating Plot 3

library(data.table)
library(dplyr)
df = fread("household_power_consumption.txt")
df$Date = as.Date(df$Date, format = "%d/%m/%Y")

df = df %>% filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
df$datetime = as.POSIXct(paste(df$Date,df$Time))

with(df, {plot(Sub_metering_1~datetime, ylab = "Energy sub metering", type = "l")
  lines(Sub_metering_2~datetime, type = "l",col = "red")
  lines(Sub_metering_3~datetime, type = "l", col = "blue")})
legend("topright",legend = c("sub metering 1","sub metering 2","sub metering 3"),col = c("black","red","blue"),lty=c(1,1,1))

dev.copy(png,file = "plot3.png")
dev.off()
