library(readr)
library(dplyr)

library(ggplot2)
library(tidyverse)
library(stringr)

## Predicting new user booking. 

IMDB <- read.csv("IMDM_ratings.csv")

sum(duplicated(IMDB))

imdb <- IMDB[!duplicated(IMDB), ]

str(imdb)

# 5043 rows abd 28 cols
dim(imdb)

# What are the missing values?
colSums(sapply(imdb, is.na))

# cleaning the movie title
imdb$movie_title <- gsub("Â", "", as.character(factor(imdb$movie_title)))
str_trim(imdb$movie_title, side = "right")

# Gross and Budget have many missing NA's as we would use these rows. 
# We will remove the rows with NA's to make it optimal.

imdb <- imdb[!is.na(imdb$gross), ]
imdb <- imdb[!is.na(imdb$budget), ]

# Aspect Ratio has some missing values, which will not be important for our analysis.
imdb <- subset(imdb, select = -c(aspect_ratio))
imdb <- subset(imdb, select = -c(color))

# Is language in this dataset?
table(imdb$language)

# Since most movies are in English, we can remove language.
imdb <- subset(imdb, select = -c(language))

# Adding Profit and ROI %
imdb <- imdb %>% mutate(net_profit = gross - budget,return_on_investment = (net_profit/budget)*100)
