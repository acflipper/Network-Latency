library(readxl) # library that allows for easy import of data from excel workbooks
library(reshape2) # contains the important melt function that is used to manipulate aggregations and table layout
library(ggplot2) # powerhouse library for creating beautiful graphics, plots and tables
library(tidyverse) # contains many useful packages for graphical manipulation
library(gridExtra) # used for publishing multiple ggplot objects in a single output
library(ggpubr) # used for creating table views as ggplot objects

setwd(dirname(rstudioapi::getActiveDocumentContext()$path)) # sets working directory to R file location

load("KPI_Full_fourYear.RData")

check <- subset(KPI_Pull_Full_fourYear, DATE_TIME > "2016-01-01" & DATE_TIME < "2016-12-31")


fourYear <- KPI_Pull_Full_fourYear

#fourYear <- fourYear[!is.na(fourYear$MMWAVE_LATENCY),]
#fourYear <- fourYear[!is.na(fourYear$FDD_LATENCY),]
#fourYear <- fourYear[!is.na(fourYear$EVDO_LATENCY),]
#fourYear <- fourYear[!is.na(fourYear$XDATA_LATENCY),]

sixteen <- subset(fourYear, DATE_TIME > "2016-01-01" & DATE_TIME < "2016-12-31")
seventeen <- subset(fourYear, DATE_TIME > "2017-01-01" & DATE_TIME < "2017-12-31")
eighteen <- subset(fourYear, DATE_TIME > "2018-01-01" & DATE_TIME < "2018-12-31")
nineteen <- subset(fourYear, DATE_TIME > "2019-01-01" & DATE_TIME < "2019-12-31")


latency <- data.frame("Year" = c("2016","2017", "2018","2019"), "2G" = c(1,1,1,1), "3G" = c(1,1,1,1),"4G" = c(1,1,1,1),"5G" = c(1,1,1,1))
latency

names(latency)[2] <- "2G"
names(latency)[3] <- "3G"
names(latency)[4] <- "4G"
names(latency)[5] <- "5G"

#latency[2, 2] = new_value


latency[1, 2] = mean(sixteen$XDATA_LATENCY,na.rm=TRUE)
latency[2, 2] = mean(seventeen$XDATA_LATENCY,na.rm=TRUE)
latency[3, 2] = mean(eighteen$XDATA_LATENCY,na.rm=TRUE)
latency[4, 2] = mean(nineteen$XDATA_LATENCY,na.rm=TRUE)

latency[1, 3] = mean(sixteen$EVDO_LATENCY,na.rm=TRUE)
latency[2, 3] = mean(seventeen$EVDO_LATENCY,na.rm=TRUE)
latency[3, 3] = mean(eighteen$EVDO_LATENCY,na.rm=TRUE)
latency[4, 3] = mean(nineteen$EVDO_LATENCY,na.rm=TRUE)

latency[1, 4] = mean(sixteen$FDD_LATENCY,na.rm=TRUE)
latency[2, 4] = mean(seventeen$FDD_LATENCY,na.rm=TRUE)
latency[3, 4] = mean(eighteen$FDD_LATENCY,na.rm=TRUE)
latency[4, 4] = mean(nineteen$FDD_LATENCY,na.rm=TRUE)

latency[1, 5] = mean(sixteen$MMWAVE_LATENCY,na.rm=TRUE)
latency[2, 5] = mean(seventeen$MMWAVE_LATENCY,na.rm=TRUE)
latency[3, 5] = mean(eighteen$MMWAVE_LATENCY,na.rm=TRUE)
latency[4, 5] = mean(nineteen$MMWAVE_LATENCY,na.rm=TRUE)


latencyMelt <- melt(latency, id='Year')

latencyMelt$value[is.nan(latencyMelt$value)]<-0

names(latencyMelt)[2] <- "Technology"
names(latencyMelt)[3] <- "Latency"

write.csv(latencyMelt,file="network latency.csv",row.names=FALSE)
