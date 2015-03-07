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

png(filename = "plot4.png")

par(mfrow=c(2,2))

# Plot 1
plot(data_tbl2$NewDate, data_tbl2$Global_active_power, xlab ="",
     ylab = "Global Active Power (kilowatts)", type="l")

# Plot 2
plot(data_tbl2$NewDate, data_tbl2$Voltage, xlab ="datetime",
     ylab = "Voltage", type="l")

# Plot 3
plot(data_tbl2$NewDate, data_tbl2$Sub_metering_1, xlab ="",
     ylab = "Energy sub metering",col="black", type="l")
lines(data_tbl2$NewDate, data_tbl2$Sub_metering_2,type="l",col="red")
lines(data_tbl2$NewDate, data_tbl2$Sub_metering_3,type="l",col="blue")

legend("topright", col=c("black","red","blue"),  lty=c(1,1,1),lwd=c(2.5,2.5,2.5),
legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 

# Plot 4
plot(data_tbl2$NewDate, data_tbl2$Global_reactive_power, xlab ="datetime",
     ylab="Global_reactive_power", type="l")


dev.off(4)