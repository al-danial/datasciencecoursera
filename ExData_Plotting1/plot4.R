## Creating Plot 4

library(data.table)
library(dplyr)
df = fread("household_power_consumption.txt")
df$Date = as.Date(df$Date, format = "%d/%m/%Y")

df = df %>% filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
df$datetime = as.POSIXct(paste(df$Date,df$Time))

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(df, {
  plot(Global_active_power~datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~datetime,col='red')
  lines(Sub_metering_3~datetime,col='blue')
  legend("topright",legend = c("sub metering 1","sub metering 2","sub metering 3"),
         col = c("black","red","blue"),lty=c(1,1,1))
  plot(Global_reactive_power~datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

dev.copy(png,file = "plot4.png")
dev.off()
