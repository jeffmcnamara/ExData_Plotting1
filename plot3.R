#set working directory

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

#set parameters
par(mfrow = c(1,1), mar=c(4,4,2,2))

#create plot3
with(power, plot(Date_Time, Sub_metering_1,type="l", xlab = "", ylab = "Energy sub metering"))
lines(power$Date_Time, power$Sub_metering_2, col ="red")
lines(power$Date_Time, power$Sub_metering_3, col ="blue")
legend("topright",lty=1, col=c("black","red","blue"),legend=c(names(power[7:9])),inset=c(0.15,0),bty="n")

# save png copy to working directory
dev.copy( png,file="plot3.png")
# Turn off file device
dev.off()