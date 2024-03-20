## Polynomial Regression

## Boston Housing Data Set
## included in package called mlbench
library(mlbench)

## Read the data
data("BostonHousing")

## medv
hist(BostonHousing$medv, breaks = 20, col = "red")

## scatter plot matrix
## relationships
plot(BostonHousing)

## scatter plot of x = lstat, y = medv
plot(BostonHousing$lstat, BostonHousing$medv)

## regrssion using x = lstat and y = medv
reg1 = lm(medv ~ lstat, data = BostonHousing)
summary(reg1)
anova(reg1)

## abline function to plot the reg line
abline(reg1, col = "red", lwd = 3)

## Let's add a quadratic term on lstat
## new variable lstat^2
## use I(lstat^2) for the quadratic
reg2 = lm(medv ~ lstat + I(lstat^2), data = BostonHousing)
summary(reg2)
anova(reg2)

## Higher-order plot
## only for 1 variable
fake_lstat = seq(0, 50, 0.1)
pred_fake = predict(reg2, data.frame(lstat = fake_lstat))
## scatter plot needs to be here
lines(fake_lstat, pred_fake, col = "blue", lwd = 4)

## How to interpret the effect of lstat on medv
## If lstat changes (increase by 1), how does y change?
## As lstat increases by 1, medv changes by: -2.332821 + 2*0.043547*lstat

## E.g., If lstat = 10, as it increases by 1 (from 10 to 11)
## then the estimated medv decreases by 1.461881

## E.g., If lstat = 26, as it increases by 1 (from 26 to 27)
## then the estimated medv decreases by 0.068377

## E.g., If lstat = 40, as it increases by 1 (from 40 to 41)
## then the estimated medv INCREASES by 1.150939


## A cubic term on lstat
## reg
## x = lstat
## x^2 = I(lstat^2)
## x^3 = I(lstat^3)
reg3 = lm(medv ~ lstat + I(lstat^2) + I(lstat^3), data = BostonHousing)
summary(reg3)
anova(reg3)


## Higher-order plot
## only for 1 variable
fake_lstat = seq(0, 50, 0.1)
pred_fake = predict(reg3, data.frame(lstat = fake_lstat))
## scatter plot needs to be here
lines(fake_lstat, pred_fake, col = "green", lwd = 4)

## The effect of lstat on medv
## As lstat increases by 1, then medv is estimated to change by:
## -3.8655928 + 2*0.1487385*lstat + 3*-0.0020039*lstat^2 


## Reg 4
## x1 = crim
## x2 = lstat
## x1:x2 = crim:lstat
reg4 = lm(medv ~ crim + lstat + crim:lstat, data = BostonHousing)
summary(reg4)
anova(reg4)

## effect of crim on medv
## as crim increases by 1, then we estimate the medv to change by:
## -0.36221 + 0.01447*lstat (it depends on lstat)

## e.g. if lstat = 10
##  As crime increases by 1, then we estimate the medv to
## decrease by 0.21751



