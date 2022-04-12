{
  library(tidyverse)
  library(randomForest)
  library(caret)
  
  # importing dataset
  df<-read_csv("Admission_Predict.csv")
  
  # to view dataset -> view(df)
  # to get structure of dataset -> str(df)
  
  # splitting dataset in the ratio 7:3
  # 7 parts as training data and 3 parts as testing data
  splitting <- sample(2,nrow(df), replace = TRUE, prob=c(0.7,0.3))
  train <- df[splitting==1,]
  test <- df[splitting==2,]
  
  
  rf_fit <- randomForest(Chance_of_Admit ~ ., data=train)
  
  # predicting the chance of admit on the data present in test dadaset
  y_pred = predict(rf_fit,test)
  # creating a new column in test dataset name as `prediction` and inserting y_pred into it.
  test$prediction = y_pred
  actual = test$Chance_of_Admit
  plot(Y_pred,type='o',col='red',xlab='values',ylabel='Chances of Admission',main='Line Chart')
  lines(actual,type='o',col='blue')
  
  
  # input form user
  
  GRE_Score = as.integer(readline(prompt = "Enter your GRE Score out of 340: "))
  TOEFL_Score = as.integer(readline(prompt = "Enter your TOFEL Score out of 120: "))
  University_Rating = as.integer(readline(prompt = "Rate your university out of 5: "))
  SOP = as.double(readline(prompt = "Statement of Purpose Strength range of 1-5: "))
  LOR = as.double(readline(prompt = "Letter of Recommendation Strength range of 1-5: "))
  CGPA = as.double(readline(prompt = "Undergraduate GPA out of 10: "))
  Research = as.integer(readline(prompt = "Do you have Research Experience? either 0(NO) or 1(YES): "))
  
  # creating a dataframe on custom input from user
  datas = data.frame(GRE_Score,TOEFL_Score,University_Rating,SOP,LOR,CGPA,Research)
  
  # prediction on custom input
  predict(rf_fit,datas)
  
  res = as.numeric(predict(rf_fit,datas)[1])
  print(paste('Your chance of addmission is',res*100,'%'))
  
}
