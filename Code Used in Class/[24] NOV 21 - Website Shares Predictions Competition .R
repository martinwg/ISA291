## Read the data
#### Set working directory
df = read.csv('train_news.csv', stringsAsFactors = T)

## make sure to DROP uninformative vars
#### url

## 1) MISSING VALUES
#### make sure to impute if needed


## 2) SPLIT df into df.train and df.test
#### 70/30 or 80/20 


## 3) Create awesome models
#### a) too many vars (variable selection)

#### b) modify your model (include higher-orders - interactions - quadratics)


## 4) Estimate the PERFORMANCE
#### library(caret)   - RMSE
#### library(Metrics) - RMSE
#### select the model(s) you want to try to predict the NEW DATA


## 5) Go to kaggle and submit your prediction
## prediction for the test (kaggle)
newdata = read.csv('data_to_predict.csv', stringsAsFactors = T)
predictions = predict(awesomemodel, newdata)
my_predictions = data.frame(ID = newdata$ID, shares = predictions)
write.csv(my_predictions, "my_predictions.csv", row.names = F)  ## transform to CSV file
## SUBMIT CSV FILE TO KAGGLE

