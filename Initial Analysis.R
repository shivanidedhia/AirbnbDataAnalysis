library(ggplot2)
library(ggthemes)
library(lubridate)
library(dplyr)
library(tidyr)
library(DT)
library(scales)

## Predicting new user booking. 

age_gender <- read.csv("/Users/shivani/Documents/Github/Airbnb/age_gender_bkts.csv")
countries <- read.csv("/Users/shivani/Documents/Github/Airbnb/countries.csv")
sessions <- read.csv("/Users/shivani/Documents/Github/Airbnb/sessions.csv")
testing_data <- read.csv("/Users/shivani/Documents/Github/Airbnb/test_users.csv")
training_data <- read.csv("/Users/shivani/Documents/Github/Airbnb/train_users_2.csv")

## Structure of datasets
str(age_gender)
str(countries)
str(sessions)
str(testing_data)
str(training_data)


