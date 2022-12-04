# Load data
precip <- read.csv("data/precipitation_forecasts.csv")
temp <- read.csv("data/temperature_forecasts-2.csv")

# Choose columns
precip <- precip[, c("time", "lat", "lon","resnet")]
temp <- temp[, c("time", "lat", "lon", "resnet")]

# Convert units of precipitation to cm
precip$resnet <- precip$resnet * 100

# Get date and time columns
temp$hour <- format(as.POSIXct(temp$time), format = "%H")
temp$day <- format(as.POSIXct(temp$time), format="%Y-%m-%d")

precip$hour <- format(as.POSIXct(precip$time), format = "%H")
precip$day <- format(as.POSIXct(precip$time), format="%Y-%m-%d")

# precip$hour[precip$hour=="00"]<-"0"
# precip$hour[precip$hour=="01"]<-"1"
# precip$hour[precip$hour=="02"]<-"2"
# precip$hour[precip$hour=="03"]<-"3"
# precip$hour[precip$hour=="04"]<-"4"
# precip$hour[precip$hour=="05"]<-"5"
# precip$hour[precip$hour=="06"]<-"6"
# precip$hour[precip$hour=="07"]<-"7"
# precip$hour[precip$hour=="08"]<-"8"
# precip$hour[precip$hour=="09"]<-"9"
# 
# temp$hour[temp$hour=="00"]<-"0"
# temp$hour[temp$hour=="01"]<-"1"
# temp$hour[temp$hour=="02"]<-"2"
# temp$hour[temp$hour=="03"]<-"3"
# temp$hour[temp$hour=="04"]<-"4"
# temp$hour[temp$hour=="05"]<-"5"
# temp$hour[temp$hour=="06"]<-"6"
# temp$hour[temp$hour=="07"]<-"7"
# temp$hour[temp$hour=="08"]<-"8"
# temp$hour[temp$hour=="09"]<-"9"

precip$resnet[precip$resnet <0] <- 0



write.csv(precip, "/Users/nehabhatia/Documents/CSE_6242/App/Data/precipitation.csv", row.names = F)
write.csv(temp, "/Users/nehabhatia/Documents/CSE_6242/App/Data/temperature.csv", row.names = F)



