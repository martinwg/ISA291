## Introduction to Linear Regression
## Goal: how to fit a model (get the estimates, slope(s) and y-intercept)

## Read the data
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/Analyst_SalaryData.csv',
              stringsAsFactors = T)

## print some obs
head(df)

## Fit a first-order linear model
## y = Salary
## x = YearsExperience

## 1) does a first-order model seem appropriate?
plot(df$YearsExperience, df$Salary)

## 2) fit the model in R
model1 = lm(Salary ~ YearsExperience, data = df)
summary(model1)

## TRUE MODEL: Salary = Beta0 + Beta1 Experience + epsilon
## ESTIMATED MODEL: Estimated Salary = b0 + b1 Experience
## ESTIMATED MODEL: Estimated Salary = 25792  + 9450 Experience


## plot of the estimated values
plot(df$YearsExperience, df$Salary)
abline(model1, col = "red", lwd = 3)

## b0: If years of experience is zero, we ESTIMATE the salary to be
## $25,792

## b1: As years of experience increases by 1 year, we ESTIMATE
## the salary to increase (+) by $9,450

## predicted values (are also called fitted values or yhat)
model1$fitted.values

## Residual Error (Error)
## the difference between the true value (y) and the estimated (yhat)
model1$residuals

## Sum of the residuals
sum(model1$residuals)

## Sum of squared errors (SSE)
sum(model1$residuals^2)

## How to get SSE
summary(model1) ## not here
anova(model1)   ## analysis of variance (find SSE here)
options(scipen = 999)  ## get rid of 9.3813e+08 notation
anova(model1)

## SSE is the statistic that gets MINIMIZED to obtain estimates
## The models JUST looks at SSE, minimizes SSE, and then gets estimates
