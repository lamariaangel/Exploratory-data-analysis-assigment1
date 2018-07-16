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
  
#creating datetime  
data_subset <- data_subset %>% mutate(Datetime=as.POSIXct(paste(as.Date(Date),Time)))

#plot
png("plot1.png", width=480, height=480)
hist(data_subset$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()

                                      