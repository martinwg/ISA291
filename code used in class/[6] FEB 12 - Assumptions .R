## Model Assumptions
## Inference

## What is Inference?
## Estimating parameters
## We use statistics to estimate model parameters
## Parameter is a population metric

## Example: salary of FSB graduates
## x = years of experience
## Salary = B0 + B1 Salary + Epsilon

## Estimation: E(Salary) = B0 + B1 Salary 
## Parameters: B0 and B1
## Estimates (statistics): b0 and b1

## 
n = 100  ## FSB students
B0 = 55
B1 = 12
Experience = runif(n, 0, 10)
## Error (we can't estimate. It is random)
Epsilon = rnorm(n, 0, 5)

## 
Salary = B0 + B1*Experience + Epsilon

## Plot
plot(Experience, Salary)

## What would regression estimate?
## b0 and b1
reg1 = lm(Salary ~ Experience)
summary(reg1)

## Inference was accurate
## b0 = 55.4259 
## b1 = 11.9367


## Assumptions (conditions that we need for inference to be accurate)
## 1) mean(Epsilon) = 0
## 2) var(Epsilon) = constant - (We can name the constant Sigma^2)
## 3) Epsilon ~ Normal(mean = 0, variance = Sigma^2)
## 4) Epsilons are independent of each other

## College Scorecard Data
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/college_scorecard.csv',
              stringsAsFactors = T)

## let's select 
## x = COSTT4_A
## y = MD_EARN_WNE_P10

df = df[ ,c("COSTT4_A", "MD_EARN_WNE_P10") ]

## Remove missing values
df = na.omit(df)

## We need to have a linear relationship 
## scatter plot
## Earnings = B0 + B1*Cost + Epsilon
plot(df$COSTT4_A, df$MD_EARN_WNE_P10)

## Epsilon is a PARAMETER
## We can use the residuals (errors in the sample)
## to infer how EPSILON behaves

## Regression Model
model1 = lm(MD_EARN_WNE_P10~COSTT4_A, data = df)
## let's remove exponential
options(scipen = 999)
summary(model1)
anova(model1)

## Inference
## b0 = 30658.18159
## b1 = 0.50979

## ASSUMPTION 1: Mean(Epsilon) = 0
## The model is UNBIASED model

e = model1$residuals
mean(e) ## we generally do not check this assumption
hist(e, breaks = 30)


## ASSUMPTION 2: Var(Epsilon) = Sigma^2
## No matter the cost of college
## the variation around the regression is about the same
plot(df$COSTT4_A, df$MD_EARN_WNE_P10)
abline(model1, col = "red", lwd = 4)

## variability does not seem constant on the regression line

## when we have MULTIPLE predictor
## plot(fitted_values vs residuals)
plot(model1$fitted.values, e)

## How do we estimate the variance around the regression line?

## Mean squared error (MSE) - Estimate of the variance
## look for MSE in the ANOVA table
anova(model1) ## col: Mean Sq row: Residuals
## 142799718

## MSE = SSE / error df
## error df = n - (parameters estimated)
## error df = n - (k+1)
## MSE = 439680330339 / (3081 - 2) = 142799718
## MSE estimates Sigma^2

## MSE is in squared dollars
## sqrt(MSE) which we call RMSE
## You can find in the summary
## under Residual standard error: 11950
## The model has an estimated error of $11,950
## This assumption not holding tells you
## the error can be a lot higher than $11,950
## when predictions are made for higher cost of college

## In R you can get this plot and more using plot(model1)
plot(model1)


## ASSUMPTION 3: Epsilon ~ N(0, var)
hist(e, breaks = 30) ## the tails of the distribution

## The Q-Q plot is better (blows up the tails)
plot(model1)
## this assumption does not hold on the tails of the distribution
## Some predictions are a lot LOWER or HIGHER than what they should be.


## ASSUMPTION 4: Epsilons are INDEPENDENT
## Need a time (order) variable
## We can't test this Assumption on this particular problem.




