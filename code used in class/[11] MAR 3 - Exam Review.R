## Review for Exam

## Market Value Data Set
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/MarketValueData.csv',
              stringsAsFactors = T)

head(df)

## selected vars
df = df[, c("House_Age", "Sqr_Ft", "Mkt_Value_1000s")]
head(df)

## MLR 
reg1 = lm(Mkt_Value_1000s ~ House_Age + Sqr_Ft, data = df)
summary(reg1)
anova(reg1)

## Unexplained Variation
## SSE = 2028.42 (squared dollars)
SSE = 2028.42 

## Average Unexplained Variation
## MSE (mean squared error)
## n = 42 obs
## Error DF = 42 - 3 = 39 (As high as possible, the higher the better)
## MSE = SSE / error df = 2028.42 / 39 = 52.01
## MSE is the estimate of the variance around the regression plane
MSE = 52.01

## Explained Variation
## SSR = 596.42 (house Age) + 1941.23 (Sqft given House Age)
## SSR = 596.42+1941.23
SSR = 596.42+1941.23

## Average Explained Variation
## MSR = SSR / model df
## model df = # predictors. We call this k (the lower the better)
MSR = SSR / 2

## F-statistic
## H0: B_houseage = 0 and B_sqft = 0 (no linear relationship)
## HA: At least one of them is different than zero

F = MSR / MSE
F 

## For the F distribution we need df1 and df2
## df1 (numerator) =   model df (2)
## df2 (denominator) = error df (39)
## p-value: Probability of observing an F stat of 24.4 or more
## given that the null is true (pvalue of 1.344e-07)

## We reject H0. There is enough evidence that at least one predictor
## is important


## F-statistic is the ratio of avg explained to avg unexplained variation

## Proving that house age is actually an important predictor on its own
reg2 = lm(Mkt_Value_1000s ~ House_Age, data = df)
summary(reg2)
anova(reg2)

## confidence intervals on the slopes
confint(reg1, level = 0.99)

## Interpret the C.I on the slope of House Age
## We are 99% confident that the true slope of house age
## is between -2.46971167k and  0.81938923k

## Assumptions
plot(reg1)
## non-constant variance (residuals vs fitted values)
## normality (Q-Q plot)
## mean(reg1$residuals) (mean of error terms being zero)
## residuals vs time (independence)


## predictions
## the data the model was fit is still valid (not too old)
predict(reg1, data.frame(Sqr_Ft = 2064, House_Age = 34))
## this prediction might be extrapolating (Sqft is too large)

## confidence interval on the mean
## for all homes with 2064 sqf and 34 years, 
## with 95% confidence the AVERAGE mkt value is 
predict(reg1, data.frame(Sqr_Ft = 2064, House_Age = 34), interval = "confidence")


