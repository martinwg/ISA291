## PREDICTIVE MODELS
## The goal is to predict well on new data
## Goodness of fit metrics - stats on the data you fit the model
#### R2, adj-R2, F-statistics, p-values
## validation metrics

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/airfares.csv',
              stringsAsFactors = T)

head(df)

## regression model
## y = FARE
## X1 = DISTANCE
## X2 = PAX
## x3 = VACATION  {No, Yes}
## x4 = S_CODE

reg1 = lm(FARE ~ DISTANCE +
          PAX +
            VACATION +
            S_CODE, data = df)
options(scipen = 999)
summary(reg1)
anova(reg1)
plot(reg1)


reg2 = lm(FARE ~ DISTANCE +
            PAX +
            VACATION +
            S_CODE + DISTANCE:PAX + I(DISTANCE^2), data = df)
options(scipen = 999)
summary(reg2)
anova(reg2)

## Drop insignificant variables (one at a time)
## until the model is significant

## ALL of these metrics are called
## Goodness of Fit metrics
## They show you how good the model fits the data

## EFFECT of PAX
-0.0007412926 + 0.0000007035 *DISTANCE
## Example on a 100mile route
## if the number of passengers increases by 1
## we estimate the FARE to decrease by 0.0006709426

## BUILD A PREDICTIVE MODEL
## We want to predict the FARE on NEW DATA
## We need new data
## split the df into two: training / test
## We want to split the randomly
set.seed(291)
trainIndex = sample(1:nrow(df), size = round(0.7*nrow(df)))
df_train = df[ trainIndex, ]
df_test = df[-trainIndex, ]

## We can build the model(s) ONLY on the training
## In predictive models we do not put emphasis on the goodness of fit
## Your models do not need to have statistical significance on ALL predictors
## We do not need the assumptions to completely hold
## Goal: select the model that performs the BEST on the NEW data

## model 1:
reg1 = lm(FARE ~ DISTANCE +
            PAX +
            VACATION +
            S_CODE, data = df_train)
options(scipen = 999)
summary(reg1)
anova(reg1)

## model 2: 
reg2 = lm(FARE ~ DISTANCE +
            PAX +
            VACATION +
            S_CODE + DISTANCE:PAX + I(DISTANCE^2), data = df_train)
options(scipen = 999)
summary(reg2)
anova(reg2)

## try different models because we do not know which one 
## will perform the best on the test data set

## MODEL 3
reg3 = lm(FARE ~ DISTANCE +
            PAX +
            VACATION +
            S_CODE + I(DISTANCE^2) +
            I(DISTANCE^3), data = df_train)
options(scipen = 999)
summary(reg3)
anova(reg3)

## How do you check the performance on the NEW data set
## IT DOES NOT FIT THE MODEL ON THE TEST AGAIN
## you need to predict the new dataset with your CURRENT model
yhat1 = predict(reg1, df_test)
yhat2 = predict(reg2, df_test)
yhat3 = predict(reg3, df_test)

## How do we check performance on ALL observations?
## MSE
## RMSE
## R2
## MAE

## true values of y
y = c(23.5,45.1,34.7,29.8)
## predicted values of y
yhat = c(25.7,43,35.5,30.1)

## MSE
sum((y - yhat)^2) / 4
mean((y-yhat)^2)




