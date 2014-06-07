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
###############
#  Plot 2     #
###############
png(filename="plot2.png",width=480,height=480,units="px",pointsize=12)
plot(GAP~as.POSIXct(TimeSequence),data=data1
     ,type="l",ylab="Global Activity Power(kilowatts)",xlab="",axes=FALSE)
box()
axislabel=c("2007-02-01 00:00:00 KST","2007-02-02 00:00:00", "2007-02-03 00:00:00 KST")
axis(side=1, at=as.POSIXct(axislabel),labels=c("Thu","Fri","Sat"))
axis(side=2)
dev.off()
################
#  Plot 3      #
#################
png(filename="plot3.png",width=480,height=480,units="px",pointsize=12)
plot(meter_1~as.POSIXct(TimeSequence),data=data1
     ,type="l",ylab="Energy sub metering",ylim=c(0,40),xlab="",axes=FALSE)
par(new=TRUE)
plot(meter_2~as.POSIXct(TimeSequence),data=data1
     ,type="l",ylab="",xlab="",ylim=c(0,40),axes=FALSE,col="red")
par(new=TRUE)
plot(Sub_metering_3~as.POSIXct(TimeSequence),data=data1
     ,type="l",ylab="",xlab="",ylim=c(0,40),axes=FALSE,col="blue")
box()
axislabel=c("2007-02-01 00:00:00 KST","2007-02-02 00:00:00", "2007-02-03 00:00:00 KST")
axis(side=1, at=as.POSIXct(axislabel),labels=c("Thu","Fri","Sat"))
axis(side=2,at=c(0,10,20,30),labels=c("0","10","20","30"))
legends=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
legend("topright",legend=legends,lty=c(1,1,1),col=c("black","red","blue"))
dev.off()

#################
#   Plot 4      #
#################
png(filename="plot4.png",width=480,height=480,units="px",pointsize=12)
drawAxes=function() {
    box()
    axislabel=c("2007-02-01 00:00:00 KST","2007-02-02 00:00:00", "2007-02-03 00:00:00 KST")
    axis(side=1, at=as.POSIXct(axislabel),labels=c("Thu","Fri","Sat"))
    axis(side=2)
}
opar <- par(no.readonly = TRUE)
par(mfrow=c(2,2))
plot(GAP~as.POSIXct(TimeSequence),data=data1
     ,type="l",ylab="Global Activity Power(kilowatts)",xlab="",axes=FALSE)
drawAxes()
plot(NewVoltage~as.POSIXct(TimeSequence),data=data1,
     type="l",ylab="Voltage",xlab="datetime",axes=FALSE)
drawAxes()
plot(meter_1~as.POSIXct(TimeSequence),data=data1
     ,type="l",ylab="Energy sub metering",ylim=c(0,40),xlab="",axes=FALSE)
par(new=TRUE)
plot(meter_2~as.POSIXct(TimeSequence),data=data1
     ,type="l",ylab="",xlab="",ylim=c(0,40),axes=FALSE,col="red")
par(new=TRUE)
plot(Sub_metering_3~as.POSIXct(TimeSequence),data=data1
     ,type="l",ylab="",xlab="",ylim=c(0,40),axes=FALSE,col="blue")
legends=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
legend("topright",legend=legends,lty=c(1,1,1),col=c("black","red","blue"),bty="n")
drawAxes()

plot(GRP~as.POSIXct(TimeSequence),data=data1,
     type="l",ylab="Global_reactive_power",xlab="datetime",axes=FALSE)
drawAxes()
par(opar)
dev.off()