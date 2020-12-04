library(readr)
library(dplyr)

library(ggplot2)
library(tidyverse)
library(stringr)

## Predicting new user booking. 

imdb <- read.csv("IMDM_ratings.csv")

str(imdb)

# 5043 rows abd 28 cols
dim(imdb)

# changing the below to factors to easily filter
imdb$language <- as.factor(imdb$language)
imdb$country <- as.factor(imdb$country)
imdb$content_rating <- as.factor(imdb$content_rating)
imdb$title_year <- as.factor(imdb$title_year)

# How many movies were produced every year?
table(imdb$title_year)

# Most rated movies were PG-13 rated between 1983 -  2016
ggplot(imdb, aes(x = content_rating , fill = title_year)) +
  geom_bar() +
  xlab("content_rating") +
  ylab("Total Count") +
  labs(fill = "Title Year")

# Out of 5043 movies - 813 is the maximum number of reviews and 1 is the least
# Critic Reviews is right skewed 
ggplot(aes(x = num_critic_for_reviews), data = imdb) + 
  geom_histogram(bins = 20, color = 'red') + ggtitle('Number of reviews')
summary(imdb$num_critic_for_reviews)

# 1.6 min score and 9.5 is the max score
# Scores are left skewed
ggplot(aes(x = imdb_score), data = imdb) + 
  geom_histogram(bins = 20, color = 'white') + ggtitle('Histogram of Scores')
summary(imdb$imdb_score)

# Most movies were produced around the 2000's with a imdb score
ggplot(data = imdb) + 
  geom_point(mapping = aes(x = title_year, y = imdb_score))

# Majority of the movies are in English
ggplot(data = imdb) + 
  geom_bar(mapping = aes(x = language, fill = language))

# Number of movies in order - English, French, Spanish
summary(imdb$language)

# Which countries produced the most movies?

# USA produced the most number of movies

imdb %>% group_by(movie_title,country) %>%
  summarise(mean_score = mean(imdb_score),n = n()) %>%
  ggplot(aes(x = country, y = n, fill = country)) + 
  geom_bar(stat = 'identity') + theme(legend.position = "none", axis.text=element_text(size=6)) +
  coord_flip() + ggtitle('Countries by Number of Movies')
  
# Which countries had highest avg scores?

avg_score_movie <- imdb %>% group_by(movie_title,country) %>% 
  mutate(avg_score = mean(imdb_score))%>% select(movie_title,country,avg_score) %>% filter(avg_score > 5)

head(avg_score_movie) 

ggplot(data = avg_score_movie) + 
  geom_point(mapping = aes(x = avg_score, y = country, color = avg_score))

ggplot(data = avg_score_movie) + 
  geom_bar(mapping = aes(x = country, fill = avg_score))

## U.K , France and Canada had highest IMDB Average Rating 
#Testing -Akhila


