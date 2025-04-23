## BUILDING A PREDICTIVE MODEL
#### Goal: if I am given a new phone (screensize, RAMGB, ...) predict price
#### Not interested on the relationships 

## Cellphone Prices 
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/cellphone_prices.csv',
              stringsAsFactors = T)

## Histogram Prices
hist(df$Price)

## Model DF
#### Complexity
#### Every numeric variable: 1 model df
#### Every categorical variable: # levels - 1 model df
#### total model df = k 

#### e.g
###### model 1: price ~ screen + ram + stor + batt + cam  (k = 5)
###### model 2: price ~ screen + ram + stor + batt + cam + ram^2 (k = 6)
###### model 3: price ~ screen + ram + stor + batt + cam + ram^2 + stor:batt(k = 7)
###### suppose you have manufact = {apple, samsung, nokia}
###### manufact (2 model df)
###### model 4: price ~ screen + ram + stor + batt + cam + ram^2 + stor:batt + manufact (k = 9)

###### manufact = {apple, samsung, nokia, .....}## 60 different 
###### manufact (59 model df)
###### THE HIGHER THE VALUE OF k, THE MORE LIKELY TO OVERFIT 


## STEP 1) SPLIT THE DATA INTO TRAINING AND TEST (VALIDATION)
set.seed(291)
trainIndex = sample(1:nrow(df), size = round(0.7*nrow(df)))
## create df.train and df.test
df.train = df[trainIndex, ]
df.test = df[-trainIndex, ]

## STEP 2) BUILD MODELS WITH THE TRAINING DATA SET

#### other steps) analyze the data, correlations, check relationship

#### multicollinearity?
#### correlation matrix can tell me more about vars that are too correlated
library(dplyr)
cor(df.train %>% select(where(is.numeric)))
#### there are high correlations but none above |0.9|

library(corrplot)
corrplot(cor(df.train %>% select(where(is.numeric))))

#### models (>art than science)
###### 1) first-order 
reg1 = lm(Price ~ ., data = df.train)
summary(reg1)

###### 2) higher-order? 
plot(df.train)

reg2 = lm(Price ~ . 
          + I(RAMGB^2) 
          + I(StorageGB^2)
          + StorageGB:ScreenSize, data = df.train)
summary(reg2)


### variable selection (too many predictors)
### model df = k = 5 (model 1)
### model df = k = 8 (model 2)


## SELECTING THE BEST MODEL
#### Based on performance metrics test (MSE, RMSE, R2, AIC, BIC)

#### caret (RMSE, R2, MAE)
library(caret)

### 1) predicted values
yhat1 = predict(reg1, df.test)
yhat2 = predict(reg2, df.test)

## true values
ytrue = df.test$Price

postResample(yhat1, ytrue) ## metrics for model1
postResample(yhat2, ytrue) ## metrics for model2

## which is better
## RMSE (model2) - lower the better
## R2 (model2)   - higher the better
## MAE (model1)  - lower the better 
## k (model1)    - lower the better
## AIC (model1)  - lower the better
## BIC (model1)  - lower the better

### AIC
### MODEL 1 (853.2882)
k = 5
e = ytrue - yhat1
MSE = mean(e^2)
AIC = nrow(df.test)*log(MSE) + 2*(k+1)
AIC

### MODEL 2 (859.1199)
k = 8
e = ytrue - yhat2
MSE = mean(e^2)
AIC = nrow(df.test)*log(MSE) + 2*(k+1)
AIC

### BIC
### MODEL 1 (868.1522)
k = 5
e = ytrue - yhat1
MSE = mean(e^2)
BIC = nrow(df.test)*log(MSE) + log(nrow(df.test))*(k+1)
BIC

### MODEL 2 (881.4159)
k = 8
e = ytrue - yhat2
MSE = mean(e^2)
BIC = nrow(df.test)*log(MSE) + log(nrow(df.test))*(k+1)
BIC















