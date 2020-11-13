library(readr)
library(dplyr)

library(ggplot2)
library(tidyverse)

## Predicting new user booking. 

imdb <- read.csv("/Users/shivani/Documents/Github/UberDataAnalysis/IMDM_ratings.csv")

str(imdb)

# 5043 rows abd 28 cols
dim(imdb)


ggplot(aes(x = num_critic_for_reviews), data = movie) + geom_histogram(bins = 20, color = 'red') + ggtitle('Number of reviews')
summary(imdb$num_critic_for_reviews)
