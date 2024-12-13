## Inference (estimation) of TRUE slope

## Example 
x = 1:100

## y = beta_0 + beta_1*x + error term
y = 10 + 0.01*x + rnorm(100, 0, .5)

## Population
## N = 100 obs
## True y-intercept (beta_0) = 10
## True slope (beta_1) = 0.01
## sigma^2 (variance around the reg line) = 0.5
## DataFrame
df = data.frame(x, y)

## Plot the TRUE POPULATION MODEL
plot(df$x, df$y, xlim = c(0,100), ylim = c(9,12.5))
abline(10, 0.01, col = "blue", lwd = 3)

## INFERENCE
## means: estimate the b0 (beta_0), b1 (beta_1)
## MSE (sigma^2)

## n = 10
## set.seed(1)
x = sample(1:100, 10)
y = 10 + 0.01*x + rnorm(10, 0, .5)
df = data.frame(x, y)

## Regression (inference)
reg1 = lm(y ~ x, data = df)
summary(reg1)

## plot estimated model
plot(df$x, df$y, xlim = c(0,100), ylim = c(9,12.5))
abline(10, 0.01, col = "blue", lwd = 3)  ## TRUE MODEL
abline(reg1, col = "red") ## ESTIMATE
abline(h = mean(y), lty = 2, lwd = 3, col = "black" )  ## HYP TEST

## example (random)
## t = -0.00009338 / 0.00723189 = -0.013 std errors away from zero
## p-value: prob that we get a t-statistic equal to -0.013
## and the H0 is true


## College Scorecard Example
df= read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/college_scorecard.csv',
             stringsAsFactors = T)

## selected 
df = df[ , c("COSTT4_A", "MD_EARN_WNE_P10") ]

## remove NAs
df = na.omit(df)

## We do not know beta_0 or beta_1 or sigma^2
## we only have a sample
## n = 3081

## inference 
options(scipen = 999)
reg1 = lm(MD_EARN_WNE_P10 ~ COSTT4_A, data = df)
summary(reg1)
anova(reg1)

## b0 = 30658.18159
## b1 = 0.50979
## MSE = 142799718 

## HYP TEST ON SLOPE
## H0: beta_1 = 0
## HA: beta_1 != 0

## t = b1/s_b1 =  0.50979/0.01196 = 42.62
## estimate  is 42.62 std errors away from zero
## t ~ t-dist(n - (k+1))
## t ~ t-dist(3081 - (1+1))
## t - t-dist(3079)

## p-value
## prob of getting a 42.62 t-statistic
## IF H0 is true (beta_1 = 0)

plot(df$COSTT4_A, df$MD_EARN_WNE_P10)
abline(reg1, col = "red", lwd = 3) ## ESTIMATE
abline(h = mean(df$MD_EARN_WNE_P10), lty = 2, lwd = 3, col = "black" )  ## HYP TEST


## we know estimate of b1 = 0.50979
## can you give me an interval for beta_1? I want a 95% confidence
confint(reg1, level = 0.95)
## We estimate beta_1 to be between 0.4863369 and 0.5332371
## with 95% confidence

## R2 for the problem
## Multiple R-squared:  0.3711

## correlation between cost of college and earnings
cor(df$COSTT4_A, df$MD_EARN_WNE_P10)
## moderate 0.60918 

## anova
## SSE = 439680330339  (unexplained variation)
## SSR = 259449312939  (explained by this variables)
## SST = 699129643278 (total variation)

## R2 = SSR / SST (ration of explained / total)
SST = 439680330339 + 259449312939

## Assumptions
## 1) mean(E) = 0
## 2) Var(E) = sigma^2 (estimated by MSE)
## 3) E ~ N(0, sigma^2)
## 4) E are independent

plot(reg1)

## plot 1 (residuals vs predicted) assumption 2
## plot 2 (QQ-plot) assumption 3

## supplement these plots with other plots or tests
hist(reg1$residuals) ## assumption 3
shapiro.test(reg1$residuals)
## formal test on assumption 3 (normality)
## H0: residuals are NORMAL
## HA: residuals are NOT NORMAL
## P-VALUE: probability that you get these residuals
## if H0 is true
## < 0.0000000000000002
## evidence against normality


## Point estimates
## estimated values, predictions
## to estimate given the reg function

## Cost of college = $10,000
## What is the estimated earnings?
## mean of earnings for ALL students with cost $10,000

30658.18159 + 0.50979 * 10000
predict(reg1, df)  ## prediction for ALL OBS
predict(reg1, data.frame(COSTT4_A = 10000))  ## 1 obs


## Confidence interval on the mean
## For ALL students whose cost of college is $10,000
## We are 95% confident the mean earnings will be between 35130.56  and 36381.54
predict(reg1, data.frame(COSTT4_A = 10000), interval = "confidence")

## prediction interval on an individual
## For an individual student whose cost of college is $10,000
## We are 95% confident earnings will be between 12317.15 and 59194.95
predict(reg1, data.frame(COSTT4_A = 10000), interval = "prediction")


