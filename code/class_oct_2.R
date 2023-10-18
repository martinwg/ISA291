## Market Value Example

## Read the data
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/MarketValueData.csv',
              stringsAsFactors = T)

## Print some obs
head(df)

## Scatter Plot Matrix
## All the pairwise relationships
plot(df)  ## this works if all variables are numeric

## select only Sqft and House Age
plot(df[,c(2,3,5)])

## Regression
reg1 = lm(Mkt_Value_1000s ~ House_Age+Sqr_Ft, data = df)
summary(reg1)

## Regression with only house age
reg_check = lm(Mkt_Value_1000s ~ House_Age, data = df)
summary(reg_check)


## House Age and Market Value
plot(df$House_Age, df$Mkt_Value_1000s)
abline(lm(Mkt_Value_1000s ~ House_Age, data = df), col = "red")

## House Age might be significant alone, but the contribution
## when square footage is in the model is not significant
## partial significance
summary(lm(Mkt_Value_1000s ~ House_Age, data = df))

## ANOVA for SSE, MSE, SSR, MSR
anova(reg1)

## F-Test
## NULL: House Age and Square Footage are NOT good linear predictors
## ALT: Either Age or Square Footage (or both) are good linear pred
F = 24.4 ## means avg explained / avg unexplained = 24.4
## p-value
## The probability that we obtain a 24.4 or more, given that NULL
## is true
## chances 1.344e-07

## Total Explained
SSR = 596.42 + 1941.23 
## Mean Explained (MSR)
MSR =  SSR / 2

## Total Unexplained
SSE = 2028.42
## Mean Unexplained (MSE)
MSE = 52.01


## F-statistic
F = MSR / MSE


## Confidence Intervals on the Slopes + Intercept (estimates)
confint(reg1) ## 95% CI
## As square footage increases by 1 foot, then the estimate of change in home 
## value is $40.9 holding house age constant. With 95% confidence, the change in
## home value is estimated to be between $27.36 and $54.45


## Assumptions
plot(reg1)
## Constant Variance: fitted vs residuals
## Normality Assumption: Q-Q plot

## Point Estimate
predict(reg1, data.frame(House_Age = 34, Sqr_Ft =2064))




