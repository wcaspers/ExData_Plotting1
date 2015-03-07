library(dplyr)

## read and prepare data

data_tbl <- read.table("./data/household_power_consumption.txt",
                       header=TRUE,sep=";",na.strings = "?",dec = ".")

data_tbl[,1] <- as.Date(data_tbl[,1], "%d/%m/%Y") 
data_tbl2 <- subset(data_tbl, Date == "2007-02-02" | Date == "2007-02-01")

data_tbl2 <- mutate(data_tbl2, newdate <- paste(Date,Time))

names(data_tbl2)[10] <- c("NewDate")

data_tbl2$NewDate <- strptime(data_tbl2$NewDate, format("%Y-%m-%d %H:%M:%S"))

## start plotting


png(filename = "plot1.png")

hist(data_tbl2$Global_active_power, main="Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col="red")

dev.off(4)