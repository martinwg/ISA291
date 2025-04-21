## Predictive Performance
#### based on metrics calculated on a new (unseen) data set
#### generally called test (validation)


## MSE (mean squared error)
#### MSE_TEST or MSE_VAL

#### reg1 is your model
#### summary() and anova() gets you goodness of fit metrics
#### R2, adj-R2, MSE, RMSE (THESE ARE NOT PREDICTIVE METRICS)

#### 1) yhat = predict(reg1, test)

yhat = c(25.7, 43, 35.5, 30.1)  

#### 2) errors or residuals comparing to the true values of y
ytrue = c(23.5, 45.1, 34.7, 29.8)
e = ytrue - yhat 

#### 3) formula for metric (MSE = sum(e^2) / n)
MSE = sum(e^2) / 4  ## formula 1
MSE = mean(e^2)     ## formula 2

#### using a package (caret) 
library(caret)
postResample(yhat, ytrue) 
#### MSE is RMSE^2



#### example 1)
ytrue = c(50,55,60,65)
yhat = c(48,52,62, 63)
e = ytrue - yhat
MSE = mean(e^2) 
MSE



#### RMSE (Root MSE)
#### RMSE_test or RMSE_val
ytrue = c(50,55,60,65)
yhat = c(48,52,62, 63)
e = ytrue - yhat
MSE = mean(e^2) 
RMSE = sqrt(MSE)

#### MAE (mean absolute error)
#### preferred when data has outliers 

yhat = c(25.7, 43, 35.5, 30.1)  
ytrue = c(23.5, 45.1, 34.7, 29.8)
e = ytrue - yhat
MAE = sum(abs(e)) / 4

#### option caret
postResample(yhat, ytrue)
MAE(ytrue, yhat)

#### R2 (ratio of explained to total variation)
#### R2 = SSR / SST 
#### R2 = 1 - SSE/SST
yhat = c(25.7, 43, 35.5, 30.1)  
ytrue = c(23.5, 45.1, 34.7, 29.8)
e = ytrue - yhat

SSE = sum(e^2)
SST = sum((ytrue - mean(ytrue))^2)
R2 = 1 - SSE/SST

#### option caret
postResample(yhat, ytrue)
##### this options is different 
##### computes r (correlation) and then r^2
##### this is NOT correct when you have more than 1 predictor


## AIC (combines both MSE and complexity)
#### we want to minimize MSE and complexity
### suppose k = 4

yhat = c(25.7, 43, 35.5, 30.1)  
ytrue = c(23.5, 45.1, 34.7, 29.8)

e = ytrue - yhat
MSE = mean(e^2)

### remember n (obs in test set) = 4
### as k (slopes) = 4
AIC = 4*log(MSE) + 2*(4+1)


## BIC (combines both MSE and complexity)
#### we want to minimize MSE and complexity
### suppose k = 4

yhat = c(25.7, 43, 35.5, 30.1)  
ytrue = c(23.5, 45.1, 34.7, 29.8)

e = ytrue - yhat
MSE = mean(e^2)

### remember n (obs in test set) = 4
### as k (slopes) = 4
BIC = 4*log(MSE) + log(4)*(4+1)



