# reading the whole data which is separated by ";"
whole_data <- read.table( unz( "exdata_data_household_power_consumption.zip", "household_power_consumption.txt"), sep = ";", header = TRUE)

# changing the character formated dates to Date type
whole_data[[1]] <- lubridate::dmy(whole_data[[1]])

# subsetting the data as per requirements
data_of_interest <- subset(whole_data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02") )

# converting the Global Active Power data column from character type to numeric type for frequency calculation for creating histogram
data_of_interest$Global_active_power <- as.numeric(data_of_interest$Global_active_power)

# creating the histogram 
hist(data_of_interest$Global_active_power, col = "red", xlab = "Global Active Power(kilowatts)", main = "Global Active Power")

#copying the created plot to a png file
dev.copy(png, file = "plot1.png")

#closing the connection
dev.off()
