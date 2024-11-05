## Predictive Performance Metrics
## These are metrics calculated on a TEST dataset (new data)

## Common predictive metrics
## MSE
## RMSE
## R2
## MAE
## AIC
## BIC
## Cp

## Mean Squared Error (MSE) - Test
## Reminder: also calculated in reg output MSE = SSE / [n - (k+1)]
## To calculate MSE Test = SSE (test) / n (test)

## True value of y (y_true, or y) - True value of y on test dataset
y = c(23.5, 45.1, 34.7, 29.8)

## Predicted values of y (y_pred, y_hat) - Predicted by model
yhat = c(25.7,43,35.5,30.1)

## MSE
e = y - yhat
SSE = sum(e^2)
MSE = SSE / 4 
MSE

## MSE
mean((y - yhat)^2)

## Package (Metrics)
mse(y, yhat)


## Root Mean Squared Error (RMSE)
## This is the estimated error of the model
sqrt(mean((y - yhat)^2))

## Package (Metrics)
rmse(y, yhat)

## Mean Absolute Error (MAE)
## Same units of the problem
mean(abs(y - yhat))

## Package (Metrics)
mae(y, yhat)

## R2 (Ratio of Explained to Total Variation)
## R2 = SSR / SST
## easier R2 = 1 - (SSE/SST)

SSE = sum((y - yhat)^2)
SST = sum((y - mean(y))^2)
R2 = 1 - (SSE/SST)

## Some packages calculate correlation of y and yhat
## correlation^2 = R2 (only if you have 1 predictor)

## AIC (low as possible) - blend between MSE and Complexity
modeldf = 100
estimated_params = modeldf + 1

AIC = 4*log(MSE) + 2*estimated_params


## Example
y1 = c(50, 55, 60, 65)
yhat1 = c(48,52, 62, 63)

est_params = 2
4*log(mean((y1 - yhat1)^2)) + 2*est_params

## BIC 
## favor smaller models b/c penalty is log(n)*(k+1)
## Supposing k = 100
BIC = 4*log(MSE) + log(4)*estimated_params

# HOW TO BUILD A PREDICTIVE MODEL
## 1) Read data 
## 2) PREPROCESSING:
#### Get rid of missing values, 
#### remove uninformative vars, 
#### remove vars with too many levels OR collapse
## 3) split into training and test
## 4) Build models on the training set
#### first-order models (Goodness of fit: R2, MSE, RMSE, p-vaues)
#### higher-order models (Goodness of fit: R2, MSE, RMSE, p-vaues)
#### The models that perform the best on the training might NOT perform well on new data
## 5) get the predicted values for each model fit on 4)
## 6) Performance metrics (MSE, RMSE, AIC, BIC)
## 7) Select the best model based on the METRIC that you choose (test)

