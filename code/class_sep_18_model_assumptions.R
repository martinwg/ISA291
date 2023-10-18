## Scorecard Data Set
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/scorecard_example.txt',
              stringsAsFactors = T, sep = " ")


## Plot the data 
## Relationship (linear)
plot(df$Cost4_A, df$md_earn_wne_p10, xlab = "Cost", ylab = "Earnings", 
     main = "Cost vs Earnings")


## Fit a Regression
## LS Estimates
reg1 = lm(md_earn_wne_p10 ~ Cost4_A, data = df)
options(scipen = 99)
summary(reg1)  
anova(reg1) ## SSE


## 1) Mean Error Term is Zero
## We do not to check
residuals = reg1$residuals
mean(residuals)
hist(residuals, breaks = 30)

## 2) Variance of Error Term is constant
## a) scatter plot
plot(df$Cost4_A, df$md_earn_wne_p10, xlab = "Cost", ylab = "Earnings", 
     main = "Cost vs Earnings")
abline(reg1, col = "red", lw = 4)

## remember that the variation is measured by MSE
anova(reg1)
## MSE estimates the variance and it is 87379371
## Can you interpret it?
## The variance is 87MM squared dollars

## RMSE (Root mean squared error) called Residual standard error
## is an estimate of the error in the model
## We estimate The model to be off by $9348 on average
## Assumption 2 might not hold exactly 

## b) plot(reg1) residuals in the y axis, predicted in the x axis
plot(reg1)
## The residuals vs predicted (fitted) plot shows non-constant variation

## Assumption 3) Error is normal
hist(residuals, breaks = 20)
## you can use the plot()  ## graph 2
plot(reg1)

## Assumption 4) Error Terms are independent
## no time variable

