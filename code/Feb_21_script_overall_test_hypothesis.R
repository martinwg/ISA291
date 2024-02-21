## Market Value (Home) Prediction

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/MarketValueData.csv',
              stringsAsFactors = T)
head(df)


## To delete variables
## select variables
## delete
df = df[ , c(2,3,5)] ## selecting columns
## df = df[ , c("House_Age", "Sqr_Ft", "Mkt_Value_1000s")]
## df$Address = NULL


## Scatter plot matrix 
plot(df)
## you want the relationship of each predictor with the response to be high
## the relationships among predictors, the lowest the better.

## Fit a MLR model
reg1 = lm(Mkt_Value_1000s ~ ., data = df)
summary(reg1)
anova(reg1)

## y-intercept
## When the house sqr ft and age are zero, the estimated market value
## is ESTIMATED 197.332 thousand.

## slope for AGE
## As age increase by 1 year, we estimate the home market value to 
## decrease by $825, holding other variables constant.

## HOUSE AGE is NOT a good linear predictor of Market Value in the presence 
## of sqr footage
reg2 = lm(Mkt_Value_1000s ~ House_Age, data = df)
summary(reg2)

## What is the estimate of the variance around the reg. plane?
## MSE = 52.01

## Error degrees of freedom
## n - (k+1) 
## 42 - (2+1)= 39 

## F-statistic (SUMMARY)
## F-statistic:  24.4 on 2 and 39 DF
## AVG EXPLAINED was 24.4 times greater than the AVG UNEXPLAINED






