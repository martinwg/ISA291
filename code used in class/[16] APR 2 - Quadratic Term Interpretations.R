## Higher-Order Models

## Boston Housing Data Set

## y = median home value (zip code)
## x = INDUS (% of area business)
## x = CRIM (crime rate per capita)
## x = LSTAT (% pop earning below the min wage)

## Data is included in the mlbench
library(mlbench)

## Load the data
data(BostonHousing)


## % of pop earning below min wage: LSTAT
plot(BostonHousing$lstat, BostonHousing$medv)

## 1st-order model
reg1 = lm(medv ~ lstat, data = BostonHousing)
summary(reg1)

## nothing wrong on this model
## other than checking assumptions
plot(reg1)

## % of pop earning below min wage: LSTAT
plot(BostonHousing$lstat, BostonHousing$medv)
abline(reg1, col = "red", lwd = 2.5)


## Quadratic Model (2nd-order model)
## medv = B0 + B1 lstat + B2 lstat^2
## b1 = - 
## b2 = + 

reg2 = lm(medv ~ lstat + I(lstat^2), data = BostonHousing)
summary(reg2)

## Test
## H0: B2 = 0
## HA: B2 != 0

## There is enough statistical evidence of B2 != 0
## we reject and conclude that there is a quadratic term
## trend in the model


## plot the quadratic trend
## fake lstat values and the predict using model
fake_lstat = seq(0, 50, 0.1)
## predict with reg2
pred = predict(reg2, data.frame(lstat = fake_lstat))
## scatter plot
plot(BostonHousing$lstat, BostonHousing$medv)
lines(fake_lstat, pred, col = "red", lwd = 2.5)


## What is the effect of lstat on medv?
## If the % of the pop that earns below min wage
## increases by 1%, how does that change the median values?


## effect
## -2.332821 + 2*0.043547*lstat
## it means to know the exact effect, I need the value of lstat

## what if lstat is 10% 
## increases from 10% to 11%
-2.332821 + 2*0.043547*10

## As lstat increases by 1% (from 10% to 11%), the medv is estimated
## to change by -1.461881

## what if lstat is 30% 
## increases from 30% to 31%
-2.332821 + 2*0.043547*30
## As lstat increases by 1% (from 30% to 31%), the medv is estimated
## to change by 0.279999

## what if lstat is 27% 
## increases from 27% to 28%
-2.332821 + 2*0.043547*27
## As lstat increases by 1% (from 27% to 28%), the medv is estimated
## to change by 0.018717


## crime vs medv
reg3 = lm(medv ~ crim + I(crim^2), data = BostonHousing)
summary(reg3)

## effect
-0.876141+2*0.008868*crim


