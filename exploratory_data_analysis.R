library(tidyverse)

df<-read_csv("winequalityN.csv")
head(df)

# minimum alcohol value
min(df$alcohol)
# maximum alcohol value
max(df$alcohol)

# minimum pH value
min(df$pH)
# maximum pH value
max(df$pH)

# Range of pH value
range(df$pH)
# Range of alcoholo value
range(df$alcohol)
# Range of density value
range(df$density)

#mean score of alcohol
mean(df$alcohol)
#mean score of pH
mean(df$pH)
#mean of density
mean(df$density)

# median of alcohol
median(df$alcohol)
# median of median
median(df$pH)
# median of density
median(df$density)

# summary of the entire data 
summary(df)

# summary of the data as per alcohol
by(df,df$alcohol,summary)
# summary of the data as per pH
by(df,df$pH,summary)
# summary of the data as per density
by(df,df$density,summary)
