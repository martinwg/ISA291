## Insurance Dataset
## let's use the clean data
df = read.csv("https://raw.githubusercontent.com/martinwg/ISA291/main/data/insurance.csv", stringsAsFactors = T)
head(df)

## Calculate Model DF
# age: 1 model df
# sex: 1 model df
# bmi: 1 model df
# children: 1 model df
# smoker: 1 model df 
# region: 3 model df

## Error DF
1338 - (8+1)

## Regression
reg1 = lm(charges ~ ., data = df)
summary(reg1)

## Min Obs
## 9 obs

## Higher-order model
reg2 = lm(charges ~ (.)^2 + I(age^2) + I(bmi^2) + I(children^2), data = df)
summary(reg2)

## SMALL DATA SET ILLUSTRATION
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/HR_small.csv', stringsAsFactors = T)
df

## let's fix data types
library(dplyr)
df$Age_Group = as.factor(df$Age_Group)
df$Annual_Income = df$Annual_Income %>% gsub('\\$', '', .) %>% gsub(',', '', .) %>% as.numeric()
df$ID_Number = NULL ## delete variable
df

## MODEL DF
# Sex: 1 model df
# Age: 1 model df 
# Age_Group: 3 model df
# Educational_Level: 3 model df


## MIN NUMBER OF OBS NEEDED TO ESTIMATE SLOPES AND Y-INTERCEPT
## 9 obs

## REGRESSION
reg1 = lm(Annual_Income ~ ., data = df)
summary(reg1)

