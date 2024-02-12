## SCORECARD DATA EXAMPLE

df = read.table('https://raw.githubusercontent.com/martinwg/ISA291/main/data/scorecard_example.txt',
                sep = " ", header = T, stringsAsFactors = T)

## print some obs
head(df, 10)

## scatter plot of x = Cost_A, y = md_earn
plot(df$Cost4_A, df$md_earn_wne_p10)

## Get parameter estimates
## method of least squares
## minimizes SSE

## get rid of exponential notation
options(scipen = 999)
reg1 = lm(md_earn_wne_p10 ~ Cost4_A, data = df)
summary(reg1) ## estimates
anova(reg1)   ## SSE

## y-intercept
## If cost of college is zero, then we ESTIMATE the earnings
## post graduation to be $24138.03165

## slope
## As the cost of college increases by $1, then we ESTIMATE
## the earnings to increase by $0.48 

## IS THE RELATIONSHIP STATISTICALLY SIGNIFICANT?

## ASSUMPTION # 1
## mean(error term) = 0
## we can check the mean of the residuals (e) 
mean(reg1$residuals)

## better way
hist(reg1$residuals, breaks = 20, col = "red")

## ASSUMPTION #2
## VARIANCE is called MSE
## MSE = 87379371  (mean squared residuals)
anova(reg1)
## the variance is in squared units
## square root of MSE is called RMSE or residual std error
## Residual standard error: 9348
## We estimate the error of the model to be $9,348

## plotting the scatter plot of x vs y
plot(df$Cost4_A, df$md_earn_wne_p10)

## plot y = residuals vs x = predicted
plot(reg1$fitted.values, reg1$residuals)

## ASSUMPTION # 3 
## NORMALITY OF ERROR TERM
plot(reg1)
## plot 1: predicted vs residuals ( assumption 2)
## plot 2: Q-Q plot (assumption 3)



