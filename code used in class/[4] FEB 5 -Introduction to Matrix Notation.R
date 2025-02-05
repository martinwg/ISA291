## Fit a LR Model
## Matrix Notation and Matrix Formulation of Regression

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/Analyst_SalaryData.csv',
              stringsAsFactors = T)

## plot (scatter plot) of x = YearsExperience, y = Salary
## relationship: positive, negative, weak, strong, outliers?
plot(df$YearsExperience, df$Salary)

## fit
reg1 = lm(Salary ~ YearsExperience, data = df)
summary(reg1)

## Estimated Model = Est. Salary = 25792.2 + 9450.0*YearsExperience

## Interpretation:
#### y-int: If years of Exp is zero, we estimate the salary to be  25792.2
#### slope: As years of exp increases by 1, we estimate the salary to increase
#### by $9450


## Plot the estimated values
## works only with 1 predictor
plot(df$YearsExperience, df$Salary, main = "Scatter Plot of Exp vs Salary")
abline(reg1, col = "red")

## Predictions
#### Analyst = 4 years of experiencde
25792.2 + 9450.0*4 ## estimated salary

## you need the data in a dataframe to predict, e.g.,
## data.frame(YearsExperience = 4)
predict(reg1, data.frame(YearsExperience = 4) )

## Predicted Values (Fitted Values)
reg1$fitted.values

## residual (error) is the difference between actual and predicted
## e = y - yhat
## every obs has a residual
reg1$residuals
round(reg1$residuals)

## sum of residuals = 0 (average is also 0)
sum(reg1$residuals)

## How do I know how good the regression?
## There are different metrics: R2, p-values, F-statistic
#### most basic: SSE (Sum of Squared Errors)
SSE = sum(reg1$residuals^2)
SSE ## not shown on the summary

## To get SSE, use the anova (Analysis of variance)
options(scipen = 999) ### gets rid of exponentials
anova(reg1)

## To run the regression
#### 1) reg1 = lm(y ~ x, data = df)
#### 2) summary(reg1)
#### 3) anova(reg1)


## Matrix Notation


## matrices 
#### X - dimension is important 

A = matrix(c(3.5, 1, 80, 4.0, 2, 84, 3.2, 3, 100), ncol = 3, nrow = 3, byrow = T)
A

## dimension 
dim(A)  ## 3 x 3 matrix

## How R saved the predictor (Years of Experience)
X = model.matrix(reg1) ## col of 1s, YearsofExperience
dim(X)


## y vector
#### the vector of salary (y)
y = c(35, 20, 100) 

## y-vector
y = df$Salary
dim(y) ## does not return 30x1 or 1x30 (do not use for vectors in R)

## Transpose (interchanging rows by cols)
A      ## this is matrix A
t(A)   ## this is matrix A'

## transpose of X
t(X)


