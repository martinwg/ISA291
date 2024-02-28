## Reading Files
## Make sure to set the working directory to the folder of your files

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/cardata.csv',
              stringsAsFactors = T)

## subset variables
df = df[, c("horsepower", "citympg", "highwaympg", "price")]

## print 10 observations
head(df, 10)

## scatter plot
plot(df$horsepower, df$price)  ##

## Regression (y = price, x = horsepower)
reg1 = lm(price ~ horsepower, data = df)
summary(reg1)


## Null and ALternative Hypothesis for the slope
## TRUE SLOPE OF HORSEPOWER 
## h0: beta_1 = 0
## ha: beta_1 not equal 0

## h0: True slope of horsepower is  equal to zero
## ha: True slope of horsepower is not equal zero

## What is the test statistic for the slope?
## 19.5

## What is the meaning to this test statistic?
## the sample slope 163.3 is 19.5 std dev (std. errors) away from zero


## The degrees for the t-statistic is
## the error df
## n - (k+1)
## 205 - (1+1) = 203

## R2
## the percentage of the variation explained by the model
## 65.31%

## What is SSE?
## 4516664489
## Unexplained variation 

## Estimated Error
## $4717 

## check assumptions
plot(reg1)
mean(reg1$residuals)

## scatter plot matrix
plot(df)

## get the correlation between citympg and highwaympg
cor(df$citympg, df$highwaympg)

## MLR 
reg2 = lm(price ~ ., data =df)
summary(reg2)

reg3 = lm(price ~ horsepower + citympg, data = df)
summary(reg3)

reg4 = lm(price ~ horsepower + highwaympg, data = df)
summary(reg4)


## F-statistic
## What are the df for the test
## num df = 2
## den df = 202

## WHat is definition of a p-value?
## the prob of obtaining a t statistic as extreme as -2.893 
## given the H0 is true.

## On REG3
## does the p-value of  0.124 on citympg mean that the variable
## does NOT explain or predict prices?

reg5 = lm(price ~ citympg, data = df)
summary(reg5)











