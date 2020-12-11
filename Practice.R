

########################## Nafis #################################


# Chart-1

install.packages("plotly")

library(plotly)


imdb %>%
  plot_ly(x = ~movie_facebook_likes, y = ~imdb_score, color = ~content_rating , mode = "markers", text = ~content_rating, alpha = 0.7, type = "scatter")


# As expected, from the chart we can see that the higher the imdb rating
# is, the higher the number of facebook like will be. However, there are some
# outliers as well.



# Chart-2

ggplot(imdb, aes(x=imdb_score)) + geom_histogram(bins = 50)

# Well, this simple bar chart shows that most of the movie ratings are between
# 5 and 7.5. It means most of the movies had a good acceptance rate which is more
# than 50%. 



imdb

# QUES: SHOULD WE CONVERT TO LOG BEFORE WE DO THE LINEAR REG?
# QUES: CAN WE INCLUDE NET PROFIT AND ROI IN OUR ANALYSIS?


# Random Forest

library(randomForest)

imdb


imdb_rf <-  randomForest(imdb_score~ num_voted_users + duration + content_rating + genres + 
                           num_critic_for_reviews, data=imdb_train,
                         ntree = 100, importance = TRUE, do.trace = 10)

summary(imdb_rf)


rmse(imdb_rf, imdb_test)


