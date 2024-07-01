## Multicollinearity
## Read NYC East River Bike Crossings
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/nyc-east-river-bicycle-counts.csv',
              stringsAsFactors = T)
head(df)

## let's drop the Date as it is redundant
df$Date = NULL ## setting to NULL deletes the variable
head(df)

## PERFECT COLLINEARITY

## Suppose we want to include the variable High.Temp.C
## Using the formula C = (°F - 32) ÷ 1.8
df$High.Temp.C = (df$High.Temp.F - 32) / 1.8
head(df)

## MLR Regression Fit
## The function allows singular X matrices (not independent) with no errors
## b/c the singular.ok = T is the default
## One of the Perfectly collinear variables gets NAs as estimate 
reg1 = lm(Total ~ High.Temp.F + Low_Temp_F + High.Temp.C, data = df)
summary(reg1)

## MLR Regression Fit
## We can set singular.ok = F
reg1 = lm(Total ~ High.Temp.F + Low_Temp_F + High.Temp.C, data = df,
          singular.ok = F)
summary(reg1)

## Let's retrieve the model matrix
## X is Singular (dependent)
X = model.matrix(reg1)

## Let's calculate X'X
XTX = t(X) %*% X           ## The size is (k+1) X (k+1) (4 x 4)

## Let's get the inverse
solve(XTX)


## NEAR-PERFECT COLLINEARITY

## Let's Round the High.Temp.C so that it is not perfectly collinear
## with High.Temp.F
df$High.Temp.C = round((df$High.Temp.F - 32) / 1.8)
head(df)

## Let's get the Correlation 
cor(df$High.Temp.C, df$High.Temp.F)

## MLR Fit
reg2 = lm(Total ~ High.Temp.F + Low_Temp_F + High.Temp.C, data = df)
summary(reg2)

## Let's create X'X and its inverse
X = model.matrix(reg2)
XTX = t(X) %*% X
invXTX = solve(XTX)
options(scipen = 999)

## The standard errors of the estimates are obtained by
RMSE = 3533
std_error_estimates = MSE * sqrt(diag(invXTX))

## Variance Inflation Factors
## can pick up collinearity in multiple variables
library(car)
vif(reg2)





