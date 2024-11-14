## Stock Prediction Competition

## 1) Set the working directory
## 2) Read the data "training.csv"
df = read.csv('training.csv', stringsAsFactors = T)

## A) check for missing (make sure NO MISSING VALUES)
#### If some missing use IMPUTATION



## B) 266 variables (variable selection)
#### forward, backward or stepwise variable screening technique (AIC, BIC)



## C) Split your data into df.train () and df.test  (seed number)



## D) Build AWESOME model (try many different models)
#### adjust it
#### check how it MIGHT perform on df.test
#### you can use:
library(caret)
postResample(df.test$close, predict(awesomemodel, df.test))



## E) Submit and check your predictions in Kaggle
#### 1) download the kaggle test.csv data set
#### 2) read this data set
newdata = read.csv('test.csv', stringsAsFactors = T)
#### 3) if you made a change in A) also make the change in newdata
#### 4) predict with your AWESOME model
predictions = predict(awesomemode, newdata)
my_predictions = data.frame(ID = newdata$ID, close = predictions)
write.csv(my_predictions, "group_1.csv", row.names = F)
#### 5) submit group_1.csv to the kaggle link





