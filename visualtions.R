library(tidyverse)
library(ggplot2)
library("gridExtra")
df<-read_csv("winequalityNcpoy.csv")
head(df)
ggplot(data = df) + 
  geom_bar(aes(type, fill = type)) +
  labs(title = "Prevalence of red and white wines",
       caption = "Source: train_set dataset.") +
  theme(legend.position = 'none')

ggplot(data=df, aes(x=quality, y=density)) +
  geom_jitter( alpha = .3) +
  geom_boxplot(alpha = .5,color = 'blue') +
  stat_summary(fun.y = "mean", 
               geom = "point", 
               color = "red", 
               shape = 8, 
               size = 4)
ggplot(data=df, aes(x=quality)) +    geom_histogram( col="red",fill="green",alpha = .2, binwidth = 5)
ggplot(data = df, aes(x = pH)) +geom_bar(width = 1, color = 'black',fill = I('blue'))
grid.arrange(ggplot(df, aes( x = 1, y = quality ) ) + 
               geom_jitter(alpha = 0.1 ) +
               geom_boxplot(alpha = 0.2, color = 'red' ) +
               scale_y_continuous(lim = c(4,14)),
             ggplot(data = df, aes(x = quality)) +
               geom_histogram(binwidth = 1, color = 'black',fill = I('orange')) + 
               scale_x_continuous(lim = c(4,14)),ncol = 2)