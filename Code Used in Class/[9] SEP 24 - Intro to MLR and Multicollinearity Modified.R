## Introduction to MLR

## Read Data
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/nyc-east-river-bicycle-counts.csv',
              stringsAsFactors = T)

## print obs
head(df)

## Delete Day
df$Day = NULL

## scatter plot matrix
## instead of 2-pair scatter plots
plot(df$High.Temp.F, df$Total)

## you can get all variables at the same time
plot(df) ## plots all pairs

## subset
plot(df[ ,c("High.Temp.F", "Low_Temp_F", "Total") ])


## fit first-order model (no higher-order)
## 1) fit y = Total, x = High.Temp.F
reg1 = lm(Total ~ High.Temp.F, data = df)
summary(reg1)
anova(reg1)

## SST = 3581847670 + 2900432256 = 6482279926
## plot the relationship
plot(df$High.Temp.F, df$Total)
abline(reg1, col = "red", lwd = 3)

## 2) fit y = Total, x = Low_Temp_F
reg2 = lm(Total ~ Low_Temp_F, data = df)
summary(reg2)
anova(reg2)

## plot the relationship
plot(df$Low_Temp_F, df$Total)
abline(reg2, col = "blue", lwd = 3)


## R2 - HighTemp: 0.5526
## R2 - LowTemp: 0.2422
## R2 using both variables will NOT be the sum of the 2 models

## MLR
## y = Total, x1 = HighTemp, x2 = LowTemp
final_reg = lm(Total ~ High.Temp.F + Low_Temp_F, data = df)
summary(final_reg)
anova(final_reg)

## INTERPRETATION OF ESTIMATES

## y-intercept
## if HighTemp and LowTemp are zero, we estimate
## the number of bike crossings to be -7033.91 

## slope for HighTemp
## if the high temp increases by 1F, we estimate
## the total crossings to increase by 523.79 bikes
## holding the LOW temp CONSTANT

## slope for LowTemp
## if the low temp increases by 1F, we estimate
## the total crossings to decrease by 218.96 bikes
## holding the high temp CONSTANT

## install.packages('rgl') - in Mac Quartz (google)
## install.packages('car')
library(car)
library(rgl)
scatter3d(Total ~ High.Temp.F + Low_Temp_F, data = df)

## What is the estimate of the error of the model?
## RMSE: 3550

## What is R2?
## Adj-R2: 0.5937
## We can explain 59.37% of the variability in crossings
## using this model

## Estimates are called PARTIAL ESTIMATES
## because we need to "hold the other var(s) constant"

## HighTemp
## H0: B_high_temp = 0
## HA: B_high_temp != 0
## std_error of B_high_temp 38.74
## partial estimate: 523.79
## test statistic: 523.79 / 38.74: 13.521
## the estimate is 13.521 std errors away from zero
## prob of observing this test statistic if H0 is true
## df for test: n - (k+1): 210 -(2+1) =207

## SSE = 2608511275 
## SSR
## SSR for HighTemp: explained of HighTemp: 3581847670
## SSR for lowtemp: the extra explained variation 291920982 
## Total SSR = 3581847670 + 291920982 

## (multi) collinearity means high correlation among predictors
cor(df$High.Temp.F, df$Low_Temp_F)

## Create a High.Temp.C
## this is going to cause perfect collinearity with High.Temp.F
df$High.Temp.C = (df$High.Temp.F - 32) / 1.8

## Get a regression with y = Total
## x1 = HighTempF
## x2 = LowTempF
## x3 = HighTempC

cor(df$High.Temp.F, df$High.Temp.C) ## perfect correlation

## Causes issues
reg3 = lm(Total ~ High.Temp.F + Low_Temp_F + High.Temp.C, data = df)
summary(reg3)
anova(reg3)

## summary of final reg
summary(final_reg)

## does the high corr between high temp and low temp cause issues?
cor(df$High.Temp.F, df$Low_Temp_F) ## not a perfect correlation

## let's get the X'X matrix
X = model.matrix(reg3)  
dim(X)  ## 210 x 3 matrix
dim(t(X))  ## 3 x 210
## X'X
t(X)  %*%  X

## if two predictors are very correlated
## the standard errors get inflated (larger than usual)
## the t-statistic and the p-values might get to be insignificant
## if cor(x1, x2) is too high
## do not trust the p-values as much
## how do know if the variances of the estimates are too inflated?
library(car)

## variance inflation factor (vif)
## it is a metric that tells you by how much each predictor's
## variance has been inflated.
## vif(regression_object)
vif(final_reg)

## if vif > 10 the std errors are too high, don't trust p-values 


## VIF calculations
## VIFs are calculated using the predictor (vif) as if it were y
reg_ht = lm(High.Temp.F ~ Low_Temp_F, data = df)
summary(reg_ht)

vif_ht = 1 / (1 - 0.6787)
vif_ht
## this tells how much of the variation of high temp
## is explained by the other predictor(s) 0.6787


reg_lt = lm(Low_Temp_F ~ High.Temp.F , data = df)
summary(reg_lt)

vif_lt = 1 / (1 - 0.6787)
vif_lt
## this tells how much of the variation of high temp
## is explained by the other predictor(s) 0.6787

## match with vif(final_reg)
vif(final_reg)


## there is evidence of multicollinearity if any vif > 10
