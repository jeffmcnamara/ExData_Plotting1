# set working directory

setwd("C:/Users/jmcnamara/Desktop")

# Read household_power_consumption.txt file into r
library(readr)
household_power_consumption <- read_delim("C:/Users/jmcnamara/Desktop/household_power_consumption.txt", 
                                          ";", escape_double = FALSE, trim_ws = TRUE)

# change date column from character to date format
household_power_consumption$Date <- as.Date(household_power_consumption$Date, "%d/%m/%Y")
#load dplyr package
library(dplyr)
#create Power which contains data from 2007-02-01 and 2007-02-02 by filtering
power <- household_power_consumption %>% filter(Date == "2007-02-01" | Date == "2007-02-02" )
# edit power to add a column Date_Time which combines date and time into a POSIXlt column
power <- power%>% 
  mutate(Date_Time =(paste(Date,Time)))  
power$Date_Time<-  as.POSIXlt(power$Date_Time,format="%Y-%m-%d %H:%M:%OS")
#create plot # 4 
#set margins for graphs
par(mfrow=c(2,2),  mar = c(4,4,2,2) )
# add graphs (graph 1)
with(power, plot(Date_Time, Global_active_power,type="l", xlab = "", ylab = "Global Active Power"))
# add graphs (graph 2)
with(power, plot(Date_Time, Voltage,type="l", xlab = "datetime", ylab = "Voltage"))
# add graphs (graph 3)
with(power, plot(Date_Time, Sub_metering_1,type="l", xlab = "", ylab = "Energy sub metering"))
lines(power$Date_Time, power$Sub_metering_2, col ="red")
lines(power$Date_Time, power$Sub_metering_3, col ="blue")
legend("topright",lty=1, col=c("black","red","blue"),legend=c(names(power[7:9])),bty="n", inset=c(0.2,0))
# add graphs (graph 4)
with(power, plot(Date_Time, Global_reactive_power,type="l", xlab = "datetime", ylab = "Global_reactive_power"))

# save png copy to working directory
dev.copy( png,file="plot4.png")
# Turn off file device
dev.off()