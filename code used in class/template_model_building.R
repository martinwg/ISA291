## Stock Price Prediction Competition

df = read.csv('training.csv', stringsAsFactors = T)
df$close

## 1) DATA PREPROCESSING

#### check if there are missing values 

#### if there are, choose what to do: a) remove obs with missing b) impute with mean/median

#### delete unnecessary variables: ID

#### remove any variables that are perfect correlated (research)


## 2) FEATURE ENGINEERING

#### 265 predictors. Select most important one (a -  backward, b - forward, c - step, d - RF variable importance) 
#### you can take a sample of data just to select variables - 2079 if it takes too long
#### the example below shows how to create a sample data set
#### remember dfsample is only to be used in selecting the variables
dfsample = df[sample(1:nrow(df), 500), ]

## example using RF Variable importance
library(randomForest)
rf_model = randomForest(close ~ ., data = dfsample, importance = TRUE, ntree = 500)
var_imp <- importance(rf_model)
importance_scores <- var_imp[, "%IncMSE"]
top_vars <- sort(importance_scores, decreasing = TRUE)
top_20 <- names(top_vars)[1:20]
## your new dataset now would contain only the top20 variables
dfnew = df[, top_20]


## 3) MODEL BUILDING

#### split the data (df) into df.train / df.test

#### try some models on df.train (maybe there are interactions, quadratics, cubic ----)


## 4) MODEL EVALUATION

## RMSE (df.test)
## R2 (df.test)
## AIC (df.test)
## BIC (df.test)

#### what is your best model(s)?


## BONUS POINTS EXAM

#### download the test.csv data set
#### read it (df.new = read.csv('test.csv', stringsAsFactor = T))
## prediction for the test (kaggle)
newdata = read.csv('test-1.csv', stringsAsFactors = T)
predictions = predict(yourfinalmodel, newdata)
my_predictions = data.frame(ID = newdata$ID, close = predictions)
write.csv(my_predictions, "my_predictions.csv", row.names = F)  ## transform to CSV file
## SUBMIT CSV FILE TO KAGGLE



