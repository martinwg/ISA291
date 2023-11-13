## Goal: Predictive Model for Credit Card Balance

## Read data
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/Credit_data.csv',
              stringsAsFactors = TRUE)

## model df
## error df (a lot larger than the model df)   
## say n = 50000
## Error = n - (k+1)
## n = 400

## CHECKING DIMENSIONS OF VARIABLES
## 1) structure
str(df)

## 2) if a variable has TOO MANY levels, we might to use dimension reduction
## 3) Delete uninformative variables (IDs, Names, addresses,...)
## e.g., df$variable = NULL

## CHECK MISSING VALUES
## 1) numeric variables
colSums(is.na(df))

## Imputation: replacing missing values with something (mean, median, model)
## 1 by 1
df[is.na(df$Income), 'Income'] = median(df$Income, na.rm = T )
df[is.na(df$Limit), 'Limit'] = median(df$Limit, na.rm = T )
df[is.na(df$Age), 'Age'] = median(df$Age, na.rm = T )

colSums(is.na(df))

## 2) categorical variables
levels(df$Ethnicity)[1] = "Unknown"

## MODEL-BASED
## install missForest
install.packages('missForest')
library(missForest)

df_imputed = missForest(df)$ximp

## CORRELATION MATRIX
## multi-collinearity refers to variables (predictors) that are
## too correlated
library(dplyr)
cor(df %>% select(where(is.numeric)) )
## limit and Income - 0.79109765
## careful when cor > |.9|

## CORRELATION MATRIX PLOT
install.packages('corrplot')
library(corrplot)
corrplot(cor(df %>% select(where(is.numeric)) ))
## multicollinearity
## p-values are no longer valid for the variables that are correlated
## the standard errors are INFLATED
## when two variables are too correlated - drop one

## SCATTER PLOT MATRIX
plot(df)

## TRAIN / TEST SPLIT
set.seed(291)
trainIndex = sample(1:nrow(df), round(0.7*nrow(df)), replace = TRUE)
df.train = df[trainIndex, ]
df.test = df[-trainIndex, ]


## CHECK MULTICOLLINEARITY WITH VIF
## Variance Inflation Factor
reg1 = lm(Balance ~ ., data = df.train)
summary(reg1)

library(car)
vif(reg1)
## if VIF or GVIF > 10
## then there severe multicollinearity


## MODEL 1:
reg1 = lm(Balance ~ . - Limit, data = df.train)
summary(reg1)

## MODEL 1 PERFORMANCE
ASE_MODEL1 = sum((df.test$Balance - predict(reg1, df.test))^2) / nrow(df.test)
RASE_MODEL1 = sqrt(ASE_MODEL1)
R2_MODEL1 = 1 -  (sum((df.test$Balance - predict(reg1, df.test))^2) / 
                    sum((df.test$Balance - mean(df$Balance))^2))

## IF R2_MODEL IS BAD, BUT R2 IS GOOD ON THE TRAINING - OVERFIT


## MODEL 2 
reg2 = lm(Balance ~ . + I(Limit^2) + Income:Age, data = df.train)
summary(reg2)

reg2 = lm(Balance ~ . + I(Limit^2) + Income:Age - Cards - Ethnicity - Gender - Education, data = df.train)
summary(reg2)




