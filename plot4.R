#libraries
library(tidyverse)
library(lubridate)
library(stringr)
library(purrr)

#loading the dataset
data <- read_delim('household_power_consumption.txt',delim = ';',
                   col_types = 
                       cols(
                           Date = col_character(),
                           Time = col_time(format = ""),
                           Global_active_power = col_double(),
                           Global_reactive_power = col_double(),
                           Voltage = col_double(),
                           Global_intensity = col_double(),
                           Sub_metering_1 = col_double(),
                           Sub_metering_2 = col_double(),
                           Sub_metering_3 = col_double()
                       ))

#changing to date format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

#creating a subset of the dataset
data_subset <- data %>% subset(subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

#creating data_subset$Datetime  
data_subset <- data_subset %>% mutate(Datetime=as.POSIXct(paste(as.Date(Date),Time)))

#plot
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 
plot(data_subset$Datetime, data_subset$Global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)
plot(data_subset$Datetime, data_subset$Voltage, type="l", xlab="Datetime", ylab="Voltage")
plot(data_subset$Datetime, data_subset$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(data_subset$Datetime, data_subset$Sub_metering_2, type="l", col="red")
lines(data_subset$Datetime, data_subset$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
plot(data_subset$Datetime, data_subset$Global_reactive_power, type="l", xlab="Datetime", ylab="Global_reactive_power")
dev.off()
