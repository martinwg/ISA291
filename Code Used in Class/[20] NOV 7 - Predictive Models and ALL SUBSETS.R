## BUILDING A PREDICTIVE MODEL

## read the data
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/cellphone_prices.csv',
              stringsAsFactors = T)
head(df)

## histogram
hist(df$Price, breaks = 8)

## model df and complexity
## numeric variables: 1 model df
## categorical variables: # levels - 1
## if we use ALL predictors, we have 5 model df

## 1) SPLIT THE DATA INTO TRAINING AND TEST
## 80% training /  20% test
set.seed(291)
trainIndex = sample(1:nrow(df), size = round(0.8*nrow(df)) )
df.train = df[trainIndex,] ## fit models
df.test = df[-trainIndex,] ## check performance

## 2) CHECK FOR MULTICOLLINEARITY 
## Best possible predictive model
## a model that predicts well NEW DATA (test)
## overfitting (many higher-order terms), extrapolation (predicting outside the range)
## too high complexity (model df + 1) -> overfitting
## high correlations (redundant)
library(dplyr)
cor(df %>% select(where(is.numeric)) ) 
## is there multicollinearity?
## >|0.9|? No
install.packages('corrplot')
library(corrplot)
corrplot(cor(df %>% select(where(is.numeric)) ) )

## 3) MODELING
## build several competing models ()

### A) first-order model
reg1 = lm(Price ~ ., data = df.train)
summary(reg1)
anova(reg1)
## Goodness of fit metrics (adj-R2, p-values, F-statistic)
## they show how good the model fits the training data set

### B) adding RAMGB^2 and Screensize:RAMGB
reg2 = lm(Price ~ . + I(RAMGB^2) - StorageGB, data = df.train)
summary(reg2)
anova(reg2)
## Effect of RAMGB
## -238.64317 + 2*23.18122*RAMGB 

### C) VARIABLE SELECTION (which variables, interactions, higher-order)
### select the best combinations (ALL SUBSETS)
library(leaps)

reg_subsets = regsubsets(Price ~ ., data = df, nbest = 1)
summary(reg_subsets)

## which model has the best R2?
reg_subsets_summary = summary(reg_subsets)
names(reg_subsets_summary)
best_r2 = which.max(reg_subsets_summary$rsq)
reg_subsets_summary$outmat[best_r2,] 

## which model has the best BIC?
reg_subsets_summary = summary(reg_subsets)
names(reg_subsets_summary)
best_bic = which.min(reg_subsets_summary$bic)
reg_subsets_summary$outmat[best_bic,] 

### select the best interactions and quadratic terms
## (.)^2 checks all interactions
reg_subsets = regsubsets(Price ~ (.)^2 + 
                           I(RAMGB^2) + I(StorageGB^2) + I(Camera^2)
                         +I(ScreenSize^2) + I(Battery^2), force.in = 1:5, 
                         data = df, nbest = 1)
summary(reg_subsets)

## which model has the best BIC?
## can help you determine which interactions and quadratic terms to keep
reg_subsets_summary = summary(reg_subsets)
names(reg_subsets_summary)
best_bic = which.min(reg_subsets_summary$bic)
reg_subsets_summary$outmat[best_bic,]

reg3 = lm(Price ~ . + I(RAMGB^2) + I(Battery^2) + Battery:Camera, data = df.train)
summary(reg3)
anova(reg3)


## 4) CHECK PERFORMANCE
## Which model is the best if we predict NEW PHONES? 
## MSE, RMSE, MAE, R2, AIC, BIC

## Get the predicted values for EACH model
yhat1 = predict(reg1, df.test)
yhat2 = predict(reg2, df.test)
yhat3 = predict(reg3, df.test)

## Get the true values of y
y = df.test$Price

## MSE
library(Metrics)
mse(y, yhat1) ## MSE for model 1
mse(y, yhat2) ## MSE for model 2

rmse(y, yhat1) ## MSE for model 1
rmse(y, yhat2) ## MSE for model 2

## Another for metrics
library(caret)
postResample(yhat1, y)
postResample(yhat2, y)
postResample(yhat3, y)










