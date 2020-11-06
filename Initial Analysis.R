library(ggplot2)
library(ggthemes)
library(lubridate)
library(dplyr)
library(tidyr)
library(DT)
library(scales)

apr_data <- read.csv("/Users/shivani/Documents/Github/UberDataAnalysis/Uber-dataset/uber-raw-data-apr14.csv")
may_data <- read.csv("/Users/shivani/Documents/Github/UberDataAnalysis/Uber-dataset/uber-raw-data-may14.csv")
jun_data <- read.csv("/Users/shivani/Documents/Github/UberDataAnalysis/Uber-dataset/uber-raw-data-jun14.csv")
jul_data <- read.csv("/Users/shivani/Documents/Github/UberDataAnalysis/Uber-dataset/uber-raw-data-jul14.csv")
aug_data <- read.csv("/Users/shivani/Documents/Github/UberDataAnalysis/Uber-dataset/uber-raw-data-aug14.csv")
sep_data <- read.csv("/Users/shivani/Documents/Github/UberDataAnalysis/Uber-dataset/uber-raw-data-sep14.csv")

# combining all months
uber_2014 <- rbind(apr_data,may_data, jun_data, jul_data, aug_data, sep_data)

# formatting date and time
uber_2014$Date.Time <- as.POSIXct(data_2014$Date.Time, format = "%m/%d/%Y %H:%M:%S")

uber_2014$Time <- format(as.POSIXct(data_2014$Date.Time, format = "%m/%d/%Y %H:%M:%S"), format="%H:%M:%S")

uber_2014$Date.Time <- ymd_hms(data_2014$Date.Time)

uber_2014$day <- factor(day(uber_2014$Date.Time))
uber_2014$month <- factor(month(uber_2014$Date.Time, label = TRUE))
uber_2014$year <- factor(year(uber_2014$Date.Time))
uber_2014$dayofweek <- factor(wday(uber_2014$Date.Time, label = TRUE))

uber_2014$hour <- factor(hour(hms(uber_2014$Time)))
uber_2014$minute <- factor(minute(hms(uber_2014$Time)))
uber_2014$second <- factor(second(hms(uber_2014$Time)))



