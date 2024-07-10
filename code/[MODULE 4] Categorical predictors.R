## VARIABLE TYPES AND CATEGORICAL PREDICTORS
## insurance_raw.csv dataset

## VARIABLE TYPES
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/insurance_raw.csv',
              stringsAsFactors = T)
head(df)
str(df)

## 
as.numeric(df$charges)

## Change the charges to numeric
## removes $
## removes ,
## change to numeric
library(dplyr)
df$charges = df$charges %>% gsub("\\$", "", .) %>% gsub(",", "", .) %>% as.numeric()


## CATEGORICAL PREDICTORS
nlevels(df$sex)
nlevels(df$region)
levels(df$region)
levels(df$sex)
levels(df$smoker)

## relevel
df$smoker = relevel(df$smoker, ref = "yes")

## REGRESSION WITH CATEGORICAL PREDICTORS

reg1 = lm(charges ~ age + bmi + smoker, data = df)
summary(reg1)

## The estimated medical charges for non-smokers
## is 23823.68 less than smokers.

## relevel
df$smoker = relevel(df$smoker, ref = "no")

reg1 = lm(charges ~ age + bmi + smoker, data = df)
summary(reg1)

## Visualization
library(car)
library(rgl)
scatter3d(charges ~ age + bmi | smoker, data = df)

## REGRESSION WITH CATEGORICAL PREDICTORS MULTIPLE LEVELS
reg2 = lm(charges ~ age + bmi + region, data = df)
summary(reg2)

#* The estimated medical charges for patients from northwest
#* is 979.86 less than those patients from the northeast.
library(car)
library(rgl)
scatter3d(charges ~ age + bmi | region, data = df)

























