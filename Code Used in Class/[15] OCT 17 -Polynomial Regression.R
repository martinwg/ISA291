## Polynomial Regression

## Boston Housing
## mlbench
library(mlbench)

## data sets
data()

## load the package
data('BostonHousing')

## y = medv (median home value neighborhood)
## x = lstat (percentage of lower status - earn lower min wage)

## hist
hist(BostonHousing$medv, breaks = 20, col = "red")

## relationship between x = lstat, and y = medv
plot(BostonHousing$lstat, BostonHousing$medv)

## scatterplot matrix
plot(BostonHousing)

## 1st-order model
reg1 = lm(medv ~ lstat, data = BostonHousing)
summary(reg1)

## plot the regression line
plot(BostonHousing$lstat, BostonHousing$medv)
abline(reg1, col = "red", lwd = 4)

## How to fit higher-order terms
## e.g., quadratic I(lstat^2) 
## e.g., cubic     I(lstat^3)
## e.g., square root   I(sqrt(lstat))
reg2 = lm(medv ~ lstat + I(lstat^2), data =BostonHousing)
summary(reg2)

## Test of Hypothesis
## H0: Beta2 = 0
## HA: Beta2 != 0
## if we reject H0, then the quadratic term is statistically
## significant -> keep both lstat^2 and also lstat even is not sig

## shift parameter: 
## Beta1 = -2.332821 (slope is negative)
## curvature parameter
## Beta2 = 0.043547 (concave up, decreasing at a decreasing rate)


## Plot the curve
## just for visualization in class
plot(BostonHousing$lstat, BostonHousing$medv)

## 1) create lstat values say from 0 to 50
fake_lstat = seq(0, 50, 0.1)

## 2) predict with my quadratic model those values in 1)
pred_lstat = predict(reg2, data.frame(lstat = fake_lstat))

## plot those values in the scatter plot
lines(fake_lstat, pred_lstat, col = "red", lwd = 4)

## Effect of lstat on the medv 
## -2.332821 + 2*0.043547*lstat
## If percentage of pop earning less than min wage increases by 1%
## then the estimated median value of the homes on the neighborhoods
## will change by -2.332821 + 2*0.043547*lstat

## example: 10% to 11%
## If percentage of pop earning less than min wage increases by 1%
## then the estimated median value of the homes on the neighborhoods
## will change by -1.461881 thousands (holding everything else constant)

## example: 25% to 26%
## If percentage of pop earning less than min wage increases by 1%
## then the estimated median value of the homes on the neighborhoods
## will change by -0.155471 thousands (holding everything else constant)

## example: 30% to 31%
## If percentage of pop earning less than min wage increases by 1%
## then the estimated median value of the homes on the neighborhoods
## will change by 0.279999 thousands (holding everything else constant)

## indus (effect proportion of acres of non-retail business)
reg1 = lm(medv ~ indus, data = BostonHousing)
summary(reg1)
plot(BostonHousing$indus, BostonHousing$medv)
abline(reg1, col = "red", lwd = 4)

reg2= lm(medv ~ indus + I(indus^2), data = BostonHousing)
summary(reg2)

## Plot the curve
## just for visualization in class
plot(BostonHousing$indus, BostonHousing$medv)

## 1) create lstat values say from 0 to 50
fake_indus = seq(0, 30, 0.1)

## 2) predict with my quadratic model those values in 1)
pred_indus = predict(reg2, data.frame(indus = fake_indus))

## plot those values in the scatter plot
lines(fake_indus, pred_indus, col = "red", lwd = 4)


## Effect of Indus
## -1.722086 + 2* 0.044200*indus

## If the percentage of the acreas that contain non-retail business
## increase by 1%
## then the estimated median value of the homes on the neighborhoods
## will change by -1.722086 + 2* 0.044200*indus


## 5% to 6%
## If the percentage of the acreas that contain non-retail business
## increase by 1%
## then the estimated median value of the homes on the neighborhoods
## will change by -1.280086 thousand

## 20% to 21%
## If the percentage of the acreas that contain non-retail business
## increase by 1%
## then the estimated median value of the homes on the neighborhoods
## will change by 0.045914 thousand

