data=read.table("household_power_consumption.txt",sep=";",header=TRUE)
data1=subset(data,subset=(data$Date=="1/2/2007"|data$Date=="2/2/2007"))

data1$GAP=as.numeric(levels(data1$Global_active_power)[data1$Global_active_power])
data1$NewVoltage=as.numeric(levels(data1$Voltage)[data1$Voltage])
data1$GRP=as.numeric(levels(data1$Global_reactive_power)[data1$Global_reactive_power])
data1$Sequence=paste(data1$Date,data1$Time)
data1$TimeSequence=strptime(data1$Sequence,"%d/%m/%Y %H:%M:%S")
data1$meter_1=as.numeric(levels(data1$Sub_metering_1)[data1$Sub_metering_1])
data1$meter_2=as.numeric(levels(data1$Sub_metering_2)[data1$Sub_metering_2])


#############
#  Plot1    # 
#############
png(filename="plot1.png",width=480,height=480,units="px",pointsize=12)
hist(data1$GAP,
     col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")
dev.off()
