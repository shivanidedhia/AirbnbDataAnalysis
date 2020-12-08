library(readr)
library(dplyr)

library(ggplot2)
library(tidyverse)
library(stringr)
library(ggrepel)

# What variable affects the higher IMDB score?


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


## U.K , France and Canada had highest IMDB Average Rating 
# Is language in this dataset?
table(imdb$language)

# Since most movies are in English, we can remove language.
imdb <- subset(imdb, select = -c(language))

# Adding Profit and ROI %
imdb <- imdb %>% mutate(net_profit = gross - budget,return_on_investment = (net_profit/budget)*100)

# replacing all NA's with col average
imdb$facenumber_in_poster[is.na(imdb$facenumber_in_poster)] <- round(mean(imdb$facenumber_in_poster, na.rm = TRUE))

# replacing all 0's with NA's
imdb[,c(5,6,8,13,24,26)][imdb[,c(5,6,8,13,24,26)] == 0] <- NA

# replacing all NA's with col average
imdb$num_critic_for_reviews[is.na(imdb$num_critic_for_reviews)] <- round(mean(imdb$num_critic_for_reviews, na.rm = TRUE))
imdb$duration[is.na(imdb$duration)] <- round(mean(imdb$duration, na.rm = TRUE))
imdb$director_facebook_likes[is.na(imdb$director_facebook_likes)] <- round(mean(imdb$director_facebook_likes, na.rm = TRUE))
imdb$actor_3_facebook_likes[is.na(imdb$actor_3_facebook_likes)] <- round(mean(imdb$actor_3_facebook_likes, na.rm = TRUE))
imdb$actor_1_facebook_likes[is.na(imdb$actor_1_facebook_likes)] <- round(mean(imdb$actor_1_facebook_likes, na.rm = TRUE))
imdb$cast_total_facebook_likes[is.na(imdb$cast_total_facebook_likes)] <- round(mean(imdb$cast_total_facebook_likes, na.rm = TRUE))
imdb$actor_2_facebook_likes[is.na(imdb$actor_2_facebook_likes)] <- round(mean(imdb$actor_2_facebook_likes, na.rm = TRUE))
imdb$movie_facebook_likes[is.na(imdb$movie_facebook_likes)] <- round(mean(imdb$movie_facebook_likes, na.rm = TRUE))

# delete the blank cols in content rating as they cannot be replaced with anything reasonable
imdb <- imdb[!(imdb$content_rating %in% ""),]

view(imdb)

# replacing all content_rating with mordern rating system
imdb$content_rating[imdb$content_rating == 'M']   <- 'PG' 
imdb$content_rating[imdb$content_rating == 'GP']  <- 'PG' 
imdb$content_rating[imdb$content_rating == 'X']   <- 'NC-17'
imdb$content_rating[imdb$content_rating == 'Approved']  <- 'R' 
imdb$content_rating[imdb$content_rating == 'Not Rated'] <- 'R' 
imdb$content_rating[imdb$content_rating == 'Passed']    <- 'R' 
imdb$content_rating[imdb$content_rating == 'Unrated']   <- 'R' 
imdb$content_rating <- factor(imdb$content_rating)

levels(imdb$country) <- c(levels(imdb$country), "Others")
imdb$country[(imdb$country != 'USA')&(imdb$country != 'UK')] <- 'Others' 
imdb$country <- factor(imdb$country)
table(imdb$country)

# Data Visualizing

## Add legend if needed

imdb %>%
  filter(title_year %in% c(2000:2016)) %>%
  arrange(desc(net_profit)) %>%
  top_n(10, net_profit) %>%
  ggplot(aes(x=budget/1000000, y=net_profit/1000000)) +
  geom_point() +
  geom_smooth() + 
  geom_text_repel(aes(label=movie_title)) +
  labs(x = "Budget in million", y = "Profit in million", title = "Budget of the top 10 profitable movies between 2000 - 2016") +
  theme(plot.title = element_text(hjust = 0.2))

# facet wrap
# change the budget x=budget/1000000
library(reshape2)
library(corrgram)

ggplot(data = melt(imdb), mapping = aes(x = value)) + 
  geom_histogram(bins = 10) + facet_wrap(~variable, scales = 'free_x')

# imdb score count
ggplot(imdb, aes(x= imdb_score)) + geom_bar()

