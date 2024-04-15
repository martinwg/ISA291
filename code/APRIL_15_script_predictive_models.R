## CC BALANCE PROJECT

## READ THE DATA
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/Credit_data.csv',
              stringsAsFactors = T)
head(df)


## CHECK FOR MISSING DATA
colSums(is.na(df))

## IMPUTING DATA
## Replace the missing values with mean, median

is.na(df$Income) ## returns TRUE for Income missing

## subset obs with missing Income
df[ is.na(df$Income) , ]

## what is average Income?
mean(df$Income, na.rm = T)

## Impute
df$Income[is.na(df$Income)] = mean(df$Income, na.rm = T)

## Impute Limit and Age with the mean
df$Limit[is.na(df$Limit)] = mean(df$Limit, na.rm = T)
df$Age[is.na(df$Age)] = mean(df$Age, na.rm = T)

## CATEGORICAL
## do not impute



## Q1) Structure of the data
str(df)


## Q2) 
is.na(df$Income) 

## Q3)
## Impute
df$Income[is.na(df$Income)] = mean(df$Income, na.rm = T)
## Impute Limit and Age with the mean
df$Limit[is.na(df$Limit)] = mean(df$Limit, na.rm = T)
df$Age[is.na(df$Age)] = mean(df$Age, na.rm = T)

## Q4) Correlation Matrix
## avoid multicollinearity (r between two or more vars is > 0.9)
cor(df[, -c(7,8,9,10)])
library(dplyr)

## select numeric
df %>% select(where(is.numeric))

cor(df %>% select(where(is.numeric)))

##Q5)
## For many variables a plot might be better
install.packages('corrplot')
library(corrplot)
corrplot(cor(df %>% select(where(is.numeric))))

## Q6) yes, Limit and Rating are very correlated

## Q7) scatter plot matrix 
plot(df)

## Q8) split training / test
set.seed(291)
trainIndex = sample(1:nrow(df), round(0.7*nrow(df)))
df.train = df[trainIndex, ]
df.test = df[-trainIndex, ]

## MODEL 1
## FIRST-ORDER MODEL
reg1 = lm(Balance ~ ., data = df.train)
summary(reg1)

## final first model
reg1 = lm(Balance ~ . - Married - Age - Cards - Education, data = df.train)
summary(reg1)
