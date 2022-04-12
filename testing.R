# install.packages("ggplot2")
library(ggplot2)

# Dataset
head(iris)

scatter = ggplot(data=iris, aes(x = Sepal.Length, y = Sepal.Width))
scatter + geom_point(aes(color=Species, shape=Species)) + xlab("Sepal Length") +  ylab("Sepal Width") + ggtitle("Sepal Length-Width")

box <- ggplot(data=iris, aes(x=Species, y=Sepal.Length))
box + geom_boxplot(aes(fill=Species)) +
  ylab("Sepal Length") + ggtitle("Iris Boxplot") +
  stat_summary(fun.y=mean, geom="point", shape=5, size=4)


histogram <- ggplot(data=iris, aes(x=Sepal.Width))
histogram + geom_histogram(binwidth=0.2, color="black", aes(fill=Species)) +
  xlab("Sepal Width") +  ylab("Frequency") + ggtitle("Histogram of Sepal Width")

library(reshape2)
iris2 <- melt(iris, id.vars="Species")
iris2[1:3,]

print(iris2)
bar1 <- ggplot(data=iris2, aes(x=Species, y=value, fill=variable))
bar1 + geom_bar(stat="identity", position="dodge") +
  scale_fill_manual(values=c("orange", "blue", "darkgreen", "purple"),
                    name="Iris\nMeasurements",
                    breaks=c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
                    labels=c("Sepal Length", "Sepal Width", "Petal Length", "Petal Width"))

print(iris)

set.seed(1234)
iris1 <- iris[sample(1:nrow(iris), 110), ]
hline <- data.frame(Species=c("setosa", "versicolor", "virginica"), hline=as.vector(table(iris$Species)))
hline

quan <- as.vector(table(iris1$Species))
pos <- cumsum(quan) - quan/2
quantity <- data.frame(Species=c("setosa", "versicolor", "virginica"), quantity=quan, position = pos)                      

pie <- ggplot(iris1, aes(x=factor(1), fill=Species)) + geom_bar(width=1) + geom_text(data=quantity, aes(x=factor(1), y=position, label=quantity) , size=5) + labs(x="", y="")
pie

pie + coord_polar()

pie + coord_polar(theta="y")

# Basic line plot with points
ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width, group=1)) +
  geom_line(color="blue")+
  geom_point()

ggplot(iris, aes(Petal.Length, colour = cut)) +
  geom_freqpoly(binwidth = 500)