library(tidyverse)
library(caret)
library(party)
library(randomForest)
library(Metrics)

set.seed(6)
df<-read_csv("Admission_Predict.csv")
head(df)

splitting <- sample(2,nrow(df), replace = TRUE, prob=c(0.8,0.2))
train <- df[splitting==1,]
test <- df[splitting==2,]


dt_fit <- ctree(Chance_of_Admit ~ ., data = train)
rf_fit <- randomForest(Chance_of_Admit ~ ., data = train)
lg_fit <- glm(Chance_of_Admit ~ ., data = train)


result1 <- predict(dt_fit,newdata=test)
result2 <- predict(rf_fit,newdata=test )
result3 <- predict(lg_fit,newdata=test )


decision_tree <- rmse(test$Chance_of_Admit,result1)
print(decision_tree)
random_forest <- rmse(test$Chance_of_Admit,result2)
logistic_regression <- rmse(test$Chance_of_Admit,result3)


print(paste('Root mean squared error of Decision Tree is',decision_tree))
print(paste('Root mean squared error of Random Forest is',random_forest))
print(paste('Root mean squared error of Logistic Regression is',logistic_regression))


data <- data.frame(
  Models=c("Decision Tree","Random Forest","Logistic Regression") ,  
  RMSE=c(decision_tree,random_forest,logistic_regression)
)

ggplot(data, aes(x=Models, y=RMSE)) + 
  geom_bar(stat = "identity")


