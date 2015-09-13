# https://github.com/rwoh/ExData_Plotting1

# Exploratory Data Analysis - Course Project 1
# Generating plot1.png

# STEP 1: Load data. 

# We will only be looking at 0.1% of the data in the dataset. I've tried different way of doing this quickly, and on my Mac
# using the grep command to filter out unwanted data before it is parsed by read.table takes 4 seconds. Loading all the data 
# with read.csv first and then filtering it takes 40 second.

# So this code uses the 4 second approach. To swith to 40 second version (e.g. because your system doesn't support grep) 
# change the following varialbe to FALSE.

Do.it.the.fast.way <- TRUE

if(Do.it.the.fast.way) {
        data <- read.table(
                pipe('head  -1 "household_power_consumption.txt" ; grep  -e "^[12]/2/2007" "household_power_consumption.txt"'), 
                sep = ";", 
                na.strings = '?', 
                stringsAsFactors = FALSE, 
                header=TRUE,
                colClasses = 
                        c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
                
        )
        
} else {
        library("dplyr")
        library("lubridate")
        data <- read.csv(
                "household_power_consumption.txt", 
                sep = ";", 
                na.strings = '?', 
                stringsAsFactors = FALSE, 
                quote = "", 
                header=TRUE,
                nrows = 2075260,
                colClasses = 
                        c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
                )
        
        # Parse the dates
        data$Date.time <- dmy_hms(paste(data$Date ,data$Time, sep = " "))
        
        # Filter based on dates
        data <- data %>% 
                filter(Date.time >= dmy("01/02/2007") 
                       & Date.time < dmy("03/02/2007")
                )

}

# STEP 2: Draw the plot:

png("plot1.png", width = 480, height = 480, bg = "transparent")
with(data, hist(Global_active_power, main = "Global Active Power", xlab="Global Active Power (kilowatts)" , col="red"))
dev.off()
