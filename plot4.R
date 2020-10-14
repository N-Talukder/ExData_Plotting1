# reading the whole data which is separated by ";"
whole_data <- read.table( unz( "exdata_data_household_power_consumption.zip", "household_power_consumption.txt"), sep = ";", header = TRUE)

# changing the character formated dates to Date type
whole_data[[1]] <- lubridate::dmy(whole_data[[1]])

# subsetting the data as per requirements
data_of_interest <- subset(whole_data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02") )

# changing the character formated times to Time type
data_of_interest[[2]] <- lubridate::hms(data_of_interest[[2]])

#creating an additional column with combined date and time in data_of_interest
data_of_interest <- dplyr::mutate( data_of_interest, date_and_time = data_of_interest$Date + data_of_interest$Time)


# preparing the graphic device for a 2 row 2 column subplot
par(mfcol = c(2,2))

# Plot 1

    # converting the Global Active Power data column from character type to numeric type for frequency calculation for creating histogram
    data_of_interest$Global_active_power <- as.numeric(data_of_interest$Global_active_power)
    
    # creating an empty plot with axis labels and proper asix limits
    plot(data_of_interest$date_and_time, data_of_interest$Global_active_power, xlab = "", ylab = "Global Active Power(kilowatts)", ylim = c(-1, 7.5), type = "n")
    
    # plotting the points with line aesthetics arguments
    points( data_of_interest$Global_active_power ~ data_of_interest$date_and_time, data_of_interest, type = "l", col= "black" , lwd=2)

# Plot 2
    
    
    # converting the Global Active Power data column from character type to numeric type for frequency calculation for creating histogram
    data_of_interest$Sub_metering_1 <- as.numeric(data_of_interest$Sub_metering_1)
    data_of_interest$Sub_metering_2 <- as.numeric(data_of_interest$Sub_metering_2)
    data_of_interest$Sub_metering_3 <- as.numeric(data_of_interest$Sub_metering_3)
    
    # creating an empty plot with axis labels and proper asix limits
    plot(data_of_interest$date_and_time, data_of_interest$Sub_metering_1, xlab = "", ylab = "Energy sub metering", ylim = c(-1, 38), cex.lab = 1.25, type = "n")
    
    # plotting the points with line aesthetics arguments
    lines( data_of_interest$Sub_metering_1 ~ data_of_interest$date_and_time, data_of_interest, col= "black" , lwd=1)
    lines( data_of_interest$Sub_metering_2 ~ data_of_interest$date_and_time, data_of_interest, col= "red" , lwd=1)
    lines( data_of_interest$Sub_metering_3 ~ data_of_interest$date_and_time, data_of_interest, col= "blue" , lwd=1)
    
    
    # adding the line names as legends
    legend( "topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, lwd = 1, text.width = 36000, cex = 0.5, y.intersp = 0.15, x.intersp = 0.25, bty = "n")
    
# Plot 3
    
    # converting the Voltage data column from character type to numeric
    data_of_interest$Voltage <- as.numeric(data_of_interest$Voltage)
    
    # creating an empty plot with axis labels and proper asix limits
    plot(data_of_interest$date_and_time, data_of_interest$Voltage, xlab = "datetime", ylab = "Voltage", type = "n")
    
    # plotting the points with line aesthetics arguments
    points( data_of_interest$Voltage ~ data_of_interest$date_and_time, data_of_interest, type = "l", col= "black" , lwd=2)

# Plot 4
    
    # converting the Global reactive power data column from character type to numeric
    data_of_interest$Global_reactive_power <- as.numeric(data_of_interest$Global_reactive_power)
    
    # creating an empty plot with axis labels and proper asix limits
    plot(data_of_interest$date_and_time, data_of_interest$Global_reactive_power, xlab = "datetime",ylab = "Global_reactive_power", type = "n")
    
    # plotting the points with line aesthetics arguments
    points( Global_reactive_power ~ date_and_time, data_of_interest,type = "l", col= "black" , lwd=2)
    
#copying the created plot to a png file
dev.copy(png, width = 480, height = 480,file = "plot4.png")

#closing the connection
dev.off()
