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
varscreen = regsubsets(Price.... ~., data = df1.train, nbest = 1)
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
## NA values most often indicate perfect
## collinearity

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
cor(df3_sample$Income..USD., df3_sample$Property.Age, na.rm = TRUE)
df3_sample[, c("Income..USD." , "Property.Age")]

## DROP PROPERTY AGE
## ERROR
df3$Property.Age = NULL


## CHECK FOR MISSING
colSums(is.na(df3))

## IMPUTATION
df3$Income..USD.[is.na(df3$Income..USD.)] = mean(df3$Income..USD., na.rm = T)
df3$Current.Loan.Expenses..USD.[is.na(df3$Current.Loan.Expenses..USD.)] = mean(df3$Current.Loan.Expenses..USD., na.rm = T)
df3$Current.Loan.Expenses..USD.[df3$Current.Loan.Expenses..USD.<0] = 0

## impute #of dependents with 0
df3$Dependents[is.na(df3$Dependents)] = 0

## let's remove the obs with missing values on the response variable
df3 = na.omit(df3)

## SPLIT THE DATA INTO TRAINING AND TEST
set.seed(291)
trainIndex = sample(1:nrow(df3), round(0.6*nrow(df3))) ## 60% Train, 40% test
df3.train = df3[trainIndex,]
df3.test = df3[-trainIndex,]

## ALL SUBSETS TO SELECT VARIABLES
library(leaps)
varscreen = regsubsets(Loan.Sanction.Amount..USD.  ~., data = df3.train, nbest = 1)
summary(varscreen)

## WHAT IS THE BEST VARIABLES FOR ADJ-R2?
## select the variables based on BIC, CP, r2, ADJr2
## 1) save the summary
summary_varscreen = summary(varscreen)
which.max(summary_varscreen$adjr2)  ## select the best model based on adjR2
summary_varscreen$outmat[which.max(summary_varscreen$adjr2), ]

## WHAT IS THE BEST VARIABLES TO OPTIMIZE BIC
which.max(summary_varscreen$bic )  ## select the best model based on BIC
summary_varscreen$outmat[which.max(summary_varscreen$bic), ]


## THE BACKWARD VARIABLE SELECTION TECHNIQUE
## START WITH model with ALL VARIABLES
## Drops variables 1 by 1 until everything is significant (criteria)
## null model (lowest model you want to consider)
## full model (highest model to consider)
null = lm(Price.... ~ 1, data = df1.train)
full = lm(Price.... ~ ., data = df1.train)

b_reg1 = step(full, scope = list(lower = null, upper = full), direction = "backward", trace = 2, k = 2)


## DATASET2
null = lm(Prices ~ 1, data = df2.train)
full = lm(Prices ~ ., data= df2.train)

b_reg2 = step(full, scope = list(lower = null, upper = full), direction = "backward", trace = 2, k = 2)


## the variables selected are
f_reg2 = lm(Prices ~ Area + Garage + FirePlace + Baths + White.Marble + Black.Marble + 
              Floors + City + Solar + Electric + Fiber + Glass.Doors, data = df2.train)
summary(f_reg2)

plot(df2.train$Prices, df2.train$Area)


## DATASET3
null = lm(Loan.Sanction.Amount..USD. ~ 1, data = df3.train)
full = lm(Loan.Sanction.Amount..USD. ~ ., data = df3.train)

b_reg3 = step(full, scope = list(lower = null, upper = full), direction = "backward", trace = 2, k = 2)


## THe selected variables are:
# Age + Income.Stability + Location + Loan.Amount.Request..USD. + Dependents + Credit.Score + Has.Active.Credit.Card + 
# Property.Location + Co.Applicant + Property.Price

f = formula(Loan.Sanction.Amount..USD. ~ Age + Income.Stability + Location + 
  Loan.Amount.Request..USD. + Dependents + Credit.Score + Has.Active.Credit.Card + 
  Property.Location + Co.Applicant + Property.Price)

f_reg3 = lm(f, data = df3.train)
summary(f_reg3)









