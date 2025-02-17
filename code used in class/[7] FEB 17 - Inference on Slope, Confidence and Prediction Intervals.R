## Inference on the slope

## Estimating a population parameter
## B1 = 0 vs B1 != 0

## College Scorecard Data
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/college_scorecard.csv',
              stringsAsFactors = T)

## y = MD_EARN_WNE_P10
## x = COSTT4_A
df = df[ ,c("COSTT4_A", "MD_EARN_WNE_P10")]

## To drop obs with missing values
df = na.omit(df)

## B1???
## b1 is the estimate of B1
## As the cost of college increases by $1,
## by how much does the median earning change?

## Simple (1 predictor) Linear Regression
options(scipen = 999) ## get rid of exp notation
reg1 = lm(MD_EARN_WNE_P10 ~ COSTT4_A, data = df)
summary(reg1)
anova(reg1)

## Scatter plot
plot(df$COSTT4_A, df$MD_EARN_WNE_P10)
abline(reg1, col = "red", lwd = 3)
abline(h = mean(df$MD_EARN_WNE_P10), col = "black", lwd = 3) ## NULL


## Hypothesis Test on the Slope
## H0: B1 = 0 
## HA: B1 != 0 

## 1) b1 (0.50979): sample estimate
## 2) s_b1 (0.01196): standard error of b1
## 3) t = b1 / s_b1 : (standard errors away from zero)
## t = 42.62
## If H0 is true, b1 is 42.62 std errors away from zero

## DEFINITION OF THE P-VALUE
## p-value
## Probability of obtaining an estimate as extreme (or more)
## given that the NULL hypothesis is true

## CONCLUSION OF THE TEST
## We have enough evidence to reject the H0
## and conclude that there is a linear relationship between 
## cost of college and earnings

## Inference on a range of values for B1
## with __% of confidence, the range of values for B1
confint(reg1, level = 0.95)
## with 95% confidence, B1 is between 0.4863369 and 0.5332371

confint(reg1, level = 0.99)
## with 99% confidence, B1 is between 0.4789613 and 0.5406127 
## As cost of college increases by $1, we can estimate
## with 99% confidence that the median earnings will increase
## between 48c and 54c.

## correlation coefficient
## r measures the strength of the LINEAR relationship
cor(df$COSTT4_A, df$MD_EARN_WNE_P10)
## 0.6092 
## We can say that there is a moderately strong LINEAR relationship
## between cost of college and earnings


## Sums of squares total (SST)
## is a measure of variation of the response variable
SST = sum((df$MD_EARN_WNE_P10 - mean(df$MD_EARN_WNE_P10 ))^2)
SST  ## no meaning, the squared deviation from the mean


## Sums of squared error (SSE)
## unexplained error
## after using a model with x1 = Cost of College
SSE = sum((df$MD_EARN_WNE_P10 - reg1$fitted.values)^2)
SSE ## can't explain this error


## Sums of squares due to the regression (SSR)
## explained error
## how much of SST is explained by the model
SSR = SST - SSE
SSR

## R2 is the ratio of explained to total variation
R2 = SSR / SST
R2

## we do NOT need to calcuLate these values
summary(reg1)

## fOR R2 see Multiple R-squared:  0.3711,
anova(reg1)

## For SSR see Sum Sq COSTT4_A : 259449312939
## For SSE see SUm Sq Residuals: 439680330339
## SST go ahead and use and calculator 

## Point Estimates
## What is the predicted Earnings for someone with a cost of college of $50k?
predict(reg1, data.frame(COSTT4_A = 50000))


## Confidence Interval on the average
## For students whose cost of college was 50k, with 95% confidence
## the AVERAGE EARNINGS is between 55511 and 56784.06
predict(reg1, data.frame(COSTT4_A = 50000), interval = "confidence")


## Prediction Interval (Individual)
## For someone whose cost of college was 50k, with 95% confidence
## the predicted EARNINGS is between 32708.33 and 79586.73
predict(reg1, data.frame(COSTT4_A = 50000), interval = "prediction")






