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


## Partial Significance?
## Could House Age be an important variable to predict Mkt Value?
## In the presence of Sqr Ft, House Age is not significant

## F-statistic and t-statistic
## depend on the assumptions being true
plot(reg1)

## 1) residuals vs fitted
## non-constant variance: variation not being constant
## In this example, there is not enough obs to tell

## 2) Q-Q plot
## normality assumption: 
## In this example, the normality assumption is reasonable

## qqplot(reg1$residuals)
## mean(reg1$residuals)

## summary
summary(reg1)

## Confidence Intervals on the Parameter Estimates
confint(reg1)  ## default is 95%
## With 95% confidence, as Sqr Footage increases by 1,
## we estimate the market value to increase by $27 to $54

## With 95% confidence, as age increases by 1 year.
## the market value is estimated to decrease by $2053 or increase by $403


## How to get point estimates
## predictions
## need 1 prediction (home)
predict(reg1, data.frame(House_Age = 34, Sqr_Ft = 2064))
## you can predict  a data set
predict(reg1, df)
## plug-in values 
197.331382 -0.825161*34 + 0.040911*2064

## Confidence Interval on the Mean
## On avg, how much are these homes worth? age = 34, sqrft = 2064
predict(reg1, data.frame(House_Age = 34, Sqr_Ft = 2064), interval = "confidence")
## On avg, with 95% confidence, these homes are worth from $248 to 258 

## Prediction Interval for an individual home
predict(reg1, data.frame(House_Age = 34, Sqr_Ft = 2064), interval = "prediction")
## with 95% confidence, this home is predicted to be worth between 238 and 269












