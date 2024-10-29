## MODEL COMPLEXITY

## insurance 
## Estimate of the medical costs of patients 5-years 
## To know the insurance premiums 

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/insurance.csv',
              stringsAsFactors = T)
str(df)

## What are the model df contributed by region?
## num or factor?
## factor
## 4 - 1 = 3 model df

## What are the model df contributed by age?
## num
## 1 model df

## We want to check if we need to exclude some factor variables
## with too many levels 

## Regression with ALL predictors
## . means ALL variables 
options(scipen = 999)
reg1 = lm(charges ~ ., data = df)
summary(reg1)
anova(reg1)


## MODEL DF: 8 (AS LOW AS POSSIBLE)
## ERROR DF: 1329 (AS HIGH AS POSSIBLE)
## n - (k+1)
## 1338 - (8+1) = 1329

## you get both in the F-statistic test
## F-statistic: 500.8 on 8 and 1329 DF

## How many observations do we need to estimate the statistics?
## we need n > k+1
## n > 9 (the lowest number of obs we can have)

## example
df_small = df[1:9,]

## are the statistics estimable?
## n = 9 (1 statistic is NOT estimable)
reg2 = lm(charges ~ ., data = df_small)
summary(reg2)
anova(reg2)


## Original Regression
levels(df$region)
reg1 = lm(charges ~ ., data = df)
summary(reg1)
anova(reg1)

## DO NOT DROP THE REGION
## B/C at least one level is significantly different
## compared to the reference (northeast)

## COULD WE DROP SOME LEVELS?
## collapsing categorical levels
## we can only use two dummy variables
## regionsoutheast  and regionsouthwest   
## set the reference to BOTH northeast and northwest

## create an "other" level (northeast and northwest)

## package "forcats"
## install.packages("forcats")
library(forcats)

## functions from "forcats"

## table of levels of a variable
fct_count(df$region)

## collapse levels
## remember to overwrite the variable
df$region = fct_collapse(df$region, 
             north = c("northeast", "northwest"),
             southeast = c('southeast'), 
             southwest = c('southwest') )

## df$variable = fct_collapse(df$variable,
#                 important_level = c("level"),
#                 other_level = "other")

## Run the regression again
reg1 = lm(charges ~ ., data = df)
summary(reg1)
anova(reg1)

## A REAL EXAMPLE
## housing_ames.csv

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/housing_ames.csv',
              stringsAsFactors = T)


## Create a reg with RoofMatl
reg1 = lm(SalePrice ~ RoofMatl, data = df)
summary(reg1)

## levels
levels(df$RoofMatl)
## TIles is reference

## Wood shingles cost on average 230250
## than tiles (statistically significant)

## we could collapse the variable
## make only two different levels
## WdShngl vs other 

df$RoofMatl = fct_collapse(df$RoofMatl,
                           WoodShingles = c("WdShngl"),
                           other_level = "Other Roof Types")
levels(df$RoofMatl)

df$RoofMatl = relevel(df$RoofMatl, ref = "Other Roof Types")
levels(df$RoofMatl)

reg1 = lm(SalePrice ~ RoofMatl, data = df)
summary(reg1)