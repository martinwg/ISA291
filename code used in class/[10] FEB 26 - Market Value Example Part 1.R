## F-Test, R2 vs Adj-R2

## Home Market Value Predictions
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/MarketValueData.csv',
              stringsAsFactors = T)

## Print Obs
head(df)

## Select the vars
## x1 = House_Age
## x2 = Sqr_Ft
## y = Mkt_Value_1000s
df = df[ ,c("House_Age", "Sqr_Ft", "Mkt_Value_1000s")]
head(df)

## Scatter plot of House Age and Market Value
plot(df$House_Age, df$Mkt_Value_1000s)

## SLR (simple linear regression)
## There is a significant statistical (linear) relationship
## alpha = 0.05
reg1 = lm(Mkt_Value_1000s ~ House_Age, data = df)
summary(reg1)

## plot model
plot(df$House_Age, df$Mkt_Value_1000s)
abline(reg1, col = "red", lwd = 3)



## Scatter plot of Sqr Footage and Market Value
plot(df$Sqr_Ft, df$Mkt_Value_1000s)

## SLR (simple linear regression)
## There is a significant statistical (linear) relationship
## alpha = 0.05 (significant at lower alpha levels)
options(scipen = 999)
reg2 = lm(Mkt_Value_1000s ~ Sqr_Ft, data = df)
summary(reg2)

## plot model
plot(df$Sqr_Ft, df$Mkt_Value_1000s)
abline(reg2, col = "red", lwd = 3)


## Multiple Linear Regression (Joint x1 and x2 with y)

## multicollinearity? are x1 and x2 related?
cor(df) 
## x1 and x2 are moderate linearly related (0.6456685)
## not enough to cause multicollinearity issues 

## scatter plot matrix
plot(df)

## MLR 
reg3 = lm(Mkt_Value_1000s ~ House_Age + Sqr_Ft, data = df)
summary(reg3)
anova(reg3)

## (F) House Age is NOT an important predictor of Market Value
## (T) House Age is NOT an important predictor of Market Value 
###    when Sq_Ft is in the model

## We call estimates PARTIAL ESTIMATES in MLR
## The contribution is partial contribution GIVEN that the other
## variables are in the model

## has the variance been inflated a lot?
## multicollinearity?
## VIF
library(car)
vif(reg3) ## it is a concern if VIF > 10

## 3D plot
library(car)
library(rgl)
scatter3d(Mkt_Value_1000s ~ House_Age + Sqr_Ft, data = df)


## Sums of Squares
## SST(Total)= SSR (explained) + SSE (unexplained)
## Explained Variation
SSR = 596.42 + 1941.23
SSR

## Unexplained
SSE = 2028.42 

## Total
SST = SSR + SSE


## MSE (estimate of the variance around the plane)
SSE / 42 ## not exactly the average

error_df = 42 - 3 
SSE / error_df








