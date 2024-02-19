## Introduction to MLR
## Read GrandFather Clocks

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/GFCLOCKS.csv',
              stringsAsFactors = T)

## PLOTTING 
## scatter plot matrix (all pairs)
plot(df)

## Fit a MLR model
reg1 = lm(PRICE ~ AGE + NUMBIDS, data = df)
summary(reg1)
anova(reg1)

## Model Matrix
model.matrix(reg1)


## Estimates
summary(reg1)

## y-intercept
## If Age of the clock is zero and the number of bidders is zero
## we ESTIMATE the price at auction to be -$1338.95

## slope for AGE
## As AGE of the clock increases by 1 year, we ESTIMATE the price
## of the clock to increase by $12.74, holding number of bidders constant.

## slope of NUMBER OF BIDDERS
## As the number increases by 1, we estimate the price
## to increase by $85.95 considering clocks of the same age

## AGE
## t-statistic is 12.7406 / 0.9047
## the estimated slope is 14.082 standard errors away from zero
## the t-statistic has 1 parameter called degrees of freedom
## k = number of predictors
## df = n - (k+1)
## df = 32 - (2+1) = 29 ERROR DEGREES OF FREEDOM

## p-value for age
## probability that we get a t-statistic of 14.082 IF H0: Beta_1 = 0 is TRUE
## We have enough evidence to reject and conclude that there is a linear
## relationship between AGE and PRICE (in the presence of NUMBIDS)

## RMSE = 133.5 in dollars
## The estimated error in the model

## R2 = SSR / SST (explained variation / total variation)
## can be deceiving in MLR
## We will use adjusted R2 for the explained variation
## when we have more than 1 predictor
## R2 can only go up, but adjusted can decrease
## We can explain 88.49% of the variation in prices using this model

anova(reg1)

## 3D PLOT
install.packages('rgl')
install.packages('car')
library(rgl)
library(car)

## 3D SCATTER PLOT
scatter3d(PRICE ~ AGE + NUMBIDS, data = df)

