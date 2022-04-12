library(tidyverse)
library(caret)
library(party)
library(randomForest)
library(e1071)
library(caTools)


# importing dataset
df<-read_csv("winequalityNcopy.csv")
head(df)

# to view dataset -> view(df)
# to get structure of dataset -> str(df)

# splitting dataset in the ratio 8:2
# 8 parts as training data and 2 parts as testing data
splitting <- sample(2,nrow(df), replace = TRUE, prob=c(0.8,0.2))
train <- df[splitting==1,]
test <- df[splitting==2,]


dt_fit <- ctree(quality ~ ., data = train)
rf_fit <- randomForest(quality ~ ., data = train)
lg_fit <- glm(quality ~ ., data = train)
nb_fit <- naiveBayes(quality ~ ., data = train)



result1 <- predict(dt_fit,newdata=test,type = "response" )
#result2 <- predict(rf_fit,newdata=test,type = "response" )
result3 <- predict(lg_fit,newdata=test,type = "response" )
result4 <- predict(nb_fit,newdata=test )

r1 = ifelse(result1> 0.5 , 1, 0)
#r2 = ifelse(result2> 0.5 , 1, 0)
r3 = ifelse(result3> 0.5 , 1, 0)
#r4 = ifelse(result4> 0.5 , 1, 0)





saveRDS(rf_fit, "modellgr.rds")
#saveRDS(lg_fit, "modellgr.rds")
print(lg_fit)


# predicting the chance of admit on the data present in test dadaset


