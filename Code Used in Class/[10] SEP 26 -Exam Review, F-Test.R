## House Prices Example

## Read MarketValue
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/MarketValueData.csv',
              stringsAsFactors = T)

## df = read.csv('Cars.csv', stringsAsFactors = T)

## print obs (10)
head(df)

## select only the cols
## x1 = House_Age
## x2 = Sqr_Ft
## y = Mkt_Value_1000s

df = df[ , c("House_Age", "Sqr_Ft", "Mkt_Value_1000s") ]
## another way can be to delete variables
## df$Address = NULL

## Scatter plot (x1 with y)
plot(df$House_Age, df$Mkt_Value_1000s)

## Scatter plot matrix
plot(df)  ## as long all variables are num

## Run a regression using
## x1 
## x2 
## y
## get the summary and anova
reg1 = lm(Mkt_Value_1000s ~ House_Age + Sqr_Ft, data = df)
summary(reg1)
anova(reg1)


## RMSE is the square root of MSE (mean squared error)
sqrt( 52.01 ) ## the estimate of the variance around the reg line (plane)
## RMSE is the estimate of the std deviation around the reg line (plane)


library(car)
library(rgl)
scatter3d(Mkt_Value_1000s ~ House_Age + Sqr_Ft, data = df)

## EXPLAINED VARIATION
## SSR of House Age = 596.42
## SSR of Sqr_Ft given that House Age is in the model: 1941.23
## SSR : 596.42 + 1941.23 = 2537.65

## R2 can only increase (SSR can only be positive)
## Adj-R2 can increase OR decrease (better metric for MLR)

## SSE: 2028.42
## Unexplained variation: the errors the model CANNOT explain
## lower the better


## MSE: SSE / error df
## MSE: SSE / (n - (k+1)) = 2028.42 / (42 - 3) = 2028.42 / 39
## AVERAGE UNEXPLAINED VARIATION : lower the better

## Market values vary
## The total variation in mkt values for the 42 homes
## SST = SSR + SSE
## SST = 596.42 + 1941.23 + 2028.42
## SST = 4566.07 (variance of the mkt values)

## MSR (AVERAGE EXPLAINED VARIATION)
## SSR = 596.42 + 1941.23 =2537.65
## k = 2
## MSR = SSR / k = 2537.65 / 2 = 1268.825 higher the better

## The F-statistic
## shown on the summary
## F = MSR / MSE =   1268.825  / 52.01

## OVERALL TEST (HYPOTHESIS TEST)
## H0: BETA_HOUSE_AGE = 0 and BETA_SQR_FT = 0 (NONE OF THE PREDICTORS ARE GOOD PREDICTORS OF Y)
## HA: AT LEAST 1 PREDICTOR IS GOOD ()

## Test statistic: F-statistic: 24.4
## Degrees of freedom: num df = 2 
## Degrees of freedom: den df = 39

## P-VALUE
## Probability that you get a test-statistic (F-statistic) that high
## or higher given that the null hypothesis is true

plot(df$House_Age, df$Mkt_Value_1000s)
abline(reg2, col = "red")
reg2 = lm(Mkt_Value_1000s ~ House_Age, data = df)
summary(reg2)


## confidence intervals on the slopes
confint(reg1, level = 0.95)

## plot
## A1: mean(E) = 0
## A2: var(E) is constant
## A3: E ~ N() is normal
## A3: Independence of E

plot(reg1)
## plot 1: looking for non-constant variance (A2).
## plot 2: normality of residuals (A3)
## A1: mean(residuals) = 0 - no need to check
## A4: time / order variable to test




## Get a point estimate for a HOME 
## hOUSE Age: 34
## Sqr Footage: 2064
predict(reg1, data.frame(House_Age = 34, Sqr_Ft = 2064 ))

## Confidence Interval (Mean)
predict(reg1, data.frame(House_Age = 34, Sqr_Ft = 2064 ), interval = "confidence")

## prediction Interval (individual)
predict(reg1, data.frame(House_Age = 34, Sqr_Ft = 2064 ), interval = "prediction")
