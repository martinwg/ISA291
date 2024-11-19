## Logistic Regression (Introduction)
## if y = {0,1} - where 1: the level of interest

## logistic transformation (sigmoid function)
## link between regular regression - regression to predict binary variable

x = 3.2
## 1) exp(x) / (1+exp(x))
## 2) 1 / (1 + exp(-x))

exp(x) / (1+exp(x)) ##  0.9608343
1 / (1 + exp(-x))   ##  0.9608343

x = -5

exp(x) / (1+exp(x)) ## 0.006692851
1 / (1 + exp(-x))   ## 0.006692851

## function
logistic = function(x){
  p = exp(x) / (1+exp(x))
  return(p)
}

logistic(1.32)
## logistic(x) -> 1 if x -> large +
## logistic(x) -> 0 if x -> large -

## FITTING A LOGISTIC REGRESSION

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/default.csv',
              stringsAsFactors = T)

df = df[,c("default", "balance")]

## what if y is NOT encoded as 0 and 1, instead you have ("non-default", "default")
## df$default = ifelse(df$default == "default", 1, 0)

## scatter plot (not very informative)
plot(df$balance, df$default)

## side-by-side box plot is MORE helpful
library(ggplot2)
ggplot(df, aes(as.factor(default), balance)) + geom_boxplot()

## fit
## model_object = glm(y ~ x1 + x2, data = df, family = "binomial")

lr1 = glm(default ~ balance, data = df, family = "binomial")
options(scipen = 999)
summary(lr1)

## We have a customer with a balance past due of $2000
## What is the prob that the customer defaults?

## LOG ODDS CALCULATIONS

## log(odds) of default
-10.6513306 + 0.0054989*2000

## 0.3464694 is the log(odds) of default

## what are the log(odds) of default for some one P.D. Balance of $500
-10.6513306 + 0.0054989*500

## -7.901881 are the log(odds) of default

## PROBABILITY CALCULATIONS

## We have a customer with a balance past due of $2000
## What is the prob that the customer defaults?

logodds = -10.6513306 + 0.0054989*2000

exp(logodds) /(1+exp(logodds))  ## 0.5857612
logistic(logodds)

## The prob of default is 58.58% (balance P.D. of $2000)

## Calculate the prob(default) customer P.D. balance of $500
logodds = -10.6513306 + 0.0054989*500
logistic(logodds)
## prob(default) is  0.0003699101

## Graph a SIMPLE logistic regression (1 predictor)
predicted_data = data.frame(balance = seq(min(df$balance), max(df$balance), len = 500))

## fill the predicted with probabilities
predicted_data$probability = predict(lr1, predicted_data, type = "response")

## plot
plot(df$balance, df$default)
lines(probability ~ balance, predicted_data, lwd = 2, col = "red")

## ODDS CALCULATION

## What are the odds of default for someone P.D. $1937?

## 1) prob(default)
logodds = -10.6513306 + 0.0054989*1937
prob = logistic(logodds)
odds = prob /(1 - prob)


## Example from notes
## lr2 = -0.8 + 0.4*support_calls
logodds = -0.8 + 0.4*5 ## log(odds) of renewing is 1.2
p = 1 / (1 + exp(-logodds)) ## prob(renewing) = 0.7685248
odds = p /(1-p) ## odds(renewing) = 3.320117  (3.3 to 1 odds of renewing)

## other relationships
exp(logodds)






























