## Read the Data
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/HR_small.csv',
              stringsAsFactors = T)

## Structure of the data
## Check the variable type
str(df)

## Correct types
## Numeric to Categorical
## Age_Group: This is a group variable
## Get estimates for each group
df$Age_Group = as.factor(df$Age_Group)
str(df)

## Categorical to Numeric
## Annual_Income: 
## need to remove ,
## need to remove $
library(tidyr)
df$Annual_Income = df$Annual_Income %>% gsub("\\$", "", .) %>% gsub(",", "", .) %>% as.numeric()

## Number of Levels in Categorical Variable
df$Educational_Level
nlevels(df$Educational_Level)

## levels
levels(df$Educational_Level)

## The reference level
## the level you compare against (dummy-encoding)
levels(df$Educational_Level)
# "Bachelor's" is the reference level
# Starts with B
# E.g, On average employees with a Masters earn ------ more/less
## compared to those with a Bachelor's degree

# What if you want to compare against High School Diploma employee
df$Educational_Level = relevel(df$Educational_Level, ref = 'Diploma')
levels(df$Educational_Level)

## Create a model only with Sex as predictor of salary
## Sal = Beta0 + Beta1 Dummy_Male + epsilon
reg1 = lm(Annual_Income ~ Sex, data = df)
summary(reg1)
levels(df$Sex)
df$Sex = relevel(df$Sex, ref = "M")
reg1 = lm(Annual_Income ~ Sex, data = df)
summary(reg1)

## SexF = {0: Not Female, 1: Female}
## Estimated Sal = 51000 + 26000 SexF
## What is the estimated salary for males?
## SexF = 0
## Estimated Sal = 51000 + 26000*0
## Estimated Sal for Males = 51000 

## What is the estimated salary for females?
## Estimated Sal = 51000 + 26000*1
## Estimated Sal for Females = 77000 

## Slope for SexF
## This is the difference in salary (y)  between Females (dummy)
## compared to Males (reference)

## Regression with Educational Level
## # levels = 4
## # dummies = 3
## reference level = "Diploma"
levels(df$Educational_Level)
reg2 = lm(Annual_Income ~ Educational_Level, data = df)
summary(reg2)
