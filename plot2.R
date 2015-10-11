# The R script called plot2.R makes a plot (line) of 
# household global minute-averaged active power (in kilowatt)
# of 1st and 2nd February 2007.
# Note that used language is finnish, so to = Thu, pe = Fri and la = Sat is in the figure.

# The data for the project was here:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# read data to household
household <- read.table("household_power_consumption.txt", sep = ";",na.strings = "?", header = TRUE)

# Create new data set householdFeb1and2, where are only data from 
# the dates 2007-02-01 and 2007-02-02.
Feb1and2 <- household$Date == "2/2/2007" | household$Date == "1/2/2007"
householdFeb1and2 <- household[Feb1and2,]

# combine Date and Time to new column DateTime
householdFeb1and2 <- mutate(householdFeb1and2, DateTime = paste(Date, Time, sep = " "))

# DateTime to format "%d/%m/%Y %H:%M:%S"
householdFeb1and2$DateTime <- strptime(householdFeb1and2$DateTime, "%d/%m/%Y %H:%M:%S")

# to numeric
householdFeb1and2[, 3:9] <- lapply(householdFeb1and2[, 3:9], as.numeric)

# only DateTime, not separatly Date and Time
householdValues <- householdFeb1and2[, c(10, 3:9)]

# --- plot 2 to file plot2.png
# type = "l" => type is line
png('plot2.png')
plot(householdValues$DateTime, householdValues$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()
