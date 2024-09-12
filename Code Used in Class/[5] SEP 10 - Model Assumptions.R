## COLLEGE SCORECARD EXAMPLE
#### Goal: Assumptions of linear regression

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/college_scorecard.csv',
              stringsAsFactors = T)

## print obs
head(df)

## Create a new data set (overwrite df)
## selecting COSTT4_A and MD_EARN_WNE_P10
df = df[ ,c("COSTT4_A", "MD_EARN_WNE_P10")]
head(df)

## Note: NA means missing
## let's omit them
## imputation will be used later in the course
df = na.omit(df)
head(df)

## Plot (scatter) of the relationship
## expecting +
plot(df$COSTT4_A, df$MD_EARN_WNE_P10)

## REGRESSION
options(scipen = 999)
reg1 = lm(MD_EARN_WNE_P10 ~ COSTT4_A, data = df)
summary(reg1)    ## estimates
anova(reg1)      ## SSE


## Intercept: We ESTIMATE the earnings to be $30658.18
## for someone whose college was free of charge
## extrapolation: means predicting (explaining) data
## outside the range of values seen

plot(df$COSTT4_A, df$MD_EARN_WNE_P10)
abline(reg1, col = "red", lwd = 3)

## Slope: As the cost of college increases by $1,
## we ESTIMATE the earnings to increase by about 51 cents

## What is SSE?
## SSE = 439680330339 (minimized, the lower the better)

## ASSUMPTIONS
## ASSUMPTION # 1) MEAN(ERROR TERM) = 0
## check on the residuals
mean(reg1$residuals)
## new data set - calculate e = suppose mean(e) = + or -
## means estimates are BIASED (y-int or slope)

## ASSUMPTION # 2) VAR(ERROR TERM) = constant
## check on the residulas
var(reg1$residuals) ## check that number (this is BIASED)

## MSE is the estimate of the var(E)
## MSE = SSE / (n - (k+1))
## MSE =  142799718 (VARIANCE)

## square root of MSE (RMSE)
## RMSE is called also residual standard error
## RMSE 11950 (error is estimated at $11,950)

## The sd is 11950, that means that about 99% of the 
## predictions should be within 3*sd away 

## IF THIS DOES NOT HOLD
## Larger standard errors than what was estimated
## p-values might not be completely true
## with NOT TOO MANY obs, the issues are the worst

## to check assumption
## 1) look at scatter plot (image RMSE be constant)
## 2) plot the residuals (y) vs predicted (x) (better)
plot(reg1$fitted.values, reg1$residuals)

## We can do this automatically
plot(reg1) ## gives you some graphs include e vs yhat

## if violated: estimates are unbiased (y-int, slope)
## the model is NOT necessarily wrong (specially with large n)

## ASSUMPTION # 3. Distribution of ERROR TERM ~ N(0, SIGMA^2)
## check on residuals  e ~ N(0, 11950)
hist(reg1$residuals, col = "red", breaks = 20)
plot(reg1)





