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

# converting the Global Active Power data column from character type to numeric type for frequency calculation for creating histogram
data_of_interest$Global_active_power <- as.numeric(data_of_interest$Global_active_power)

# creating an empty plot with axis labels and proper asix limits
plot(data_of_interest$date_and_time, data_of_interest$Global_active_power, xlab = "", ylab = "Global Active Power(kilowatts)", ylim = c(-1, 7.5), type = "n")

# plotting the points with line aesthetics arguments
points( data_of_interest$Global_active_power ~ data_of_interest$date_and_time, data_of_interest, type = "l", col= "black" , lwd=2)

#copying the created plot to a png file
dev.copy(png, file = "plot2.png")

#closing the connection
dev.off()
