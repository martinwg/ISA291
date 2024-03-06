## Using Categorical Predictors

## HR SMALL
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/HR_small.csv',
              stringsAsFactors = T)

## Print Obs
df

## Check if variables are correctly encoded.
## str() returns the structure of the data
str(df)

## Age_Group should be categorical
## As age group increases by 1, then we estimate .... DOES NOT MAKE SENSE
## numeric -> factor
df$Age_Group = as.factor(df$Age_Group)

## Annual_Income should be numeric
## issues are: $ and ,
library(tidyr)
df$Annual_Income = df$Annual_Income %>% gsub("\\$", "", .) %>%  gsub(",", "", .) %>% as.numeric()


## check number of levels in the structure
## global environment
nlevels(df$Sex)

## E.g with Educational_Level
levels(df$Educational_Level)

## Reference level or base level
## This is used for comparison in dummy-variable encoding
levels(df$Age_Group) ## the first option that appears is the ref level

## Change the reference level
## relevel(variable, ref = "")
df$Educational_Level = relevel(df$Educational_Level, ref = "Diploma")

## create a regression using Sex as a prediction Annual_Income
reg1 = lm(Annual_Income ~ Sex, data = df)
summary(reg1)

## Female {F} is the reference level
## R automatically creates dummy variables for the rest of the levels
## SexM = {0: , 1: M}
## Estimate for B1 is -26000
## The estimated salary for MALES is 26000 less compared to Females

## Estimated salary for females - SexM = 0
## 77000  + (-26000) SexM  = 77000

## Estimated salary for males - SexM = 1
## 77000  + (-26000) 1  = 51000

## Regression with Education_Level as predictor
## 4 - 1 = 3 dummy variables
reg2 = lm(Annual_Income ~ Educational_Level, data = df)
summary(reg2)

## Number of Obs has to be greater # of variables (includes dummies) + 1
## n = 4
## 3 + 1

