## Introduction to MLR

## Read Data
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/nyc-east-river-bicycle-counts.csv',
              stringsAsFactors = T)

## head() to print obs
head(df)

## select 2 predictors and response
df = df[, c("High.Temp.F", "Low_Temp_F", "Total")]

## head() 
head(df)

## plot of high and Total
plot(df$High.Temp.F, df$Total)

## plot of low and Total
plot(df$Low_Temp_F, df$Total)

## scatter plot matrix
plot(df)

## Create a model using
## y = Total
## x = High Temp
reg1 = lm(Total ~ High.Temp.F, data = df)
summary(reg1)
anova(reg1)

## Test on the Slope
## H0: B_high = 0
## HA: B_high ~= 0
##  b1 = 370
## b1 / s_b1 = 370 / 23 = 16.027
##  We reject H0.
## We find enough evidence to conclude that high temp
## is LINEARLY related to the total bike crossings/

## SSE (unexplained variation) = 2900432256
## SSR (explained variation)   = 3581847670
## SST (Total)                 = 6482279926
## R2 = SSR / SST = 3581847670/6482279926 = 0.5526

## Estimated Error of the Model
## RMSE (The square root of MSE) = 3734 
## The estimated error of the model is about 3,734 bikes

## We can be 95% confident that for every 1F increase in High Temp
## The number of bikes would increase by an about 324.6458 and 415.715

## Regression of Low Temp and Total
reg2 = lm(Total ~ Low_Temp_F, data = df)
summary(reg2)
anova(reg2)

## scatter plots with estimated lines on each predictor
plot(df$High.Temp.F, df$Total)
abline(reg1, col = "red", lwd = 3)


plot(df$Low_Temp_F, df$Total)
abline(reg2, col = "red", lwd = 3)


## MULTIPLE LINEAR REG
## y = Total
## x1 = High Temp
## x2 = Low Temp
reg3 = lm(Total ~ High.Temp.F + Low_Temp_F, data = df)
summary(reg3)
anova(reg3)


## Visualize the 3D plot
## install.packages('car')
## install.packages('rgl') ## (For Macs) Google xQuartz for mac, go ahead and install 
library(car)
library(rgl)
scatter3d(Total ~ High.Temp.F + Low_Temp_F, data = df)

## Interpretations

## y-intercept
## if high temp and low temp are both 0F, we are estimating the
## total bike crossings in NYC to be -7033.91

## b_high_temp = 523.79
## As high temp increases by 1F, we estimate the number of bike crossings
## to increase by 523.79 HOLDING LOW TEMP CONSTANT (controlling for low temp)

## b_low_temp = -218.96
## As low temp increases by 1F, we estimate the number of bike crossings
## to decrease by 218.96 HOLDING HIGH TEMP CONSTANT (controlling for low temp)

## SSE (unexplained)                              = 2608511275   
## SSR for high temp (explained)                  = 3581847670
## SSR for low temp given that HT is in the model = 291920982
## SST (Total)                                    = 6482279927

## R2 is no longer a metric we can trust
## When predictors > 1, we want to use Adj-R2 = 0.5937

## Assumptions
## 1) mean(epsilon) = 0
## 2) var(epsilon) = constant  (holds)
## 3) epsilon ~ n(0, constant) (does not hold) - formal test
## 4) epsilon are independent  (plot date vs residuals)
plot(reg3)


## is there multicollinearity?
## if there is, generally not a big problem
## affects the variance of the estimates
## affects the signs of the partial estimates (+ high temp, - low temp)
cor(df$High.Temp.F, df$Low_Temp_F) ## moderately high

## The variances are a bit inflated
## variance inflation factor (vif) shows how much the variance has inflated
vif(reg3)
## concerns if vif > 10






