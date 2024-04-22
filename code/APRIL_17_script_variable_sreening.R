## Variable Screening
## All-subsets Regression
## Meant to be used in smaller number of variables 10 - 30 
## Comprehensive methods to check ALL possible regressions

## DATASET 1 (<10 variables)
## Run a regression (drop variables 1 at a time)
## Check interactions + higher-order models

df1 = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/cellphone_prices.csv',
               stringsAsFactors = T)

str(df1)

## Check for Missing Values
colSums(is.na(df1))

## Scatter plot matrix
plot(df1)

## TRAIN/TEST split
set.seed(291)
trainIndex = sample(1:nrow(df1), round(0.7*nrow(df1)))
df1.train = df1[trainIndex,]
df1.test = df1[-trainIndex, ]

## ALL SUBSETS ALGORITHM
## install.packages('leaps')
library(leaps)
varscreen = regsubsets(Price.... ~. +, data = df1.train, nbest = 1)
summary(varscreen)

## select the variables based on BIC, CP, r2, ADJr2
## 1) save the summary
summary_varscreen = summary(varscreen)
which.max(summary_varscreen$adjr2)  ## select the best model based on adjR2
summary_varscreen$outmat[which.max(summary_varscreen$adjr2), ]

which.max(summary_varscreen$bic )  ## select the best model based on BIC
summary_varscreen$outmat[which.max(summary_varscreen$bic), ]


## Modeling
reg1 = lm(Price.... ~., data = df1.train)
summary(reg1)

## Check Performance on Test Data
library(caret)
postResample(df1.test$Price...., predict(reg1, df1.test))



## DATASET 2 (10 - 20 variables)
df2 = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/HousePrices.csv',
               stringsAsFactors = T)

## Structure (variables)
str(df2) ## checking for levels of categorical predictors, unnecessary variables

## Missing values
colSums(is.na(df2)) ## no missing

## no plots for n >100000
## can't check for multicollinearity
## what if two predictors are collinear

## SAMPLE DATA TO CHECK
set.seed(291)
idx = sample(1:nrow(df2), size = 1000)
df2_sample = df2[idx, ]

plot(df2_sample)
## correlation matrix
round(cor(df2), 3) ## >90% multicollinearity

## check for perfect collinearity
options(scipen = 999)
summary(lm(Prices ~ ., data = df2_sample))

## DROP COLLINEAR VARIABLES
df2$Indian.Marble = NULL

## TRAIN/TEST SPLIT
## 500000
set.seed(291)
trainIndex = sample(1:nrow(df2), round(0.4*nrow(df2)))
df2.train = df2[trainIndex,] ## 200000
df2.test = df2[-trainIndex, ] ## 500000


## variable screening on the training dataset
library(leaps)
varscreen = regsubsets(Prices ~., data = df2.train, nbest = 1)
summary(varscreen)


## DATASET # 3 (> 20 variables, many obs)
df3 = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/loan_amount.csv',
               stringsAsFactors = T)

## structure
str(df3)

## drop all unnecessary variables
df3$Customer.ID = NULL
df3$Name = NULL
df3$Property.ID = NULL

## SAMPLE DATA TO CHECK
set.seed(291)
idx = sample(1:nrow(df3), size = 1000)
df3_sample = df3[idx, ]

## plot only numerics
library(dplyr)
plot(df3_sample %>% select(is.numeric))
## correlation matrix
cor(df3_sample %>% select(is.numeric))


## CHECK FOR MISSING
colSums(is.na(df3))

## IMPUTATION


