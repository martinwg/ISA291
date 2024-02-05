## Introduction to Linear Regression
## How to fit a model (get estimates)

## data set (read the data)
adv_exp = c(1,2,3,4,5) ## hundreds of dollars
sales = c(1,1,2,2,4)   ## thousands of dollars

## create a dataframe
## We want to have the data in dataframes always
df = data.frame(sales, adv_exp)

## print data
head(df)

## How to fit a LR model
model1 = lm(sales ~ adv_exp, data = df)
## the estimates are saved in the object model1
summary(model1)


## Predicted values
## these are estimates of y
## e.g., if adv expenses is 6.7
-0.1000 + 0.7000 * 6.7 ## estimated sales is 4.59 thousand

## How to get estimates (predicted) using R
## predict(object, dataframe)
predict(model1, data.frame(adv_exp = 6.7))

## if you want to predict every obs on data use predict(object)
predict(model1)

## Predicted values ARE ALSO CALLED fitted values
model1$fitted.values ## yhats, predicted


## Residuals (Errors)
## y - yhat
## every obs will have a residual
## we want residuals to be close to zero
round(model1$residuals,1)

## get a histogram of the residuals
hist(model1$residuals)

## SSE (sum of the squared errors)
## the statistic that gets minimized
summary(model1)

## get SSE using ANOVA (analysis of variance)
anova(model1) 














