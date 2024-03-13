## Interactions
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/CeoCompensation.csv',
              stringsAsFactors = T)

## obs
head(df)

## Create a regression using EXPER and SALES as predictors of COMP
reg1 = lm(COMP ~ EXPER + SALES, data = df)
summary(reg1)
## this regression does NOT measure any interaction between EXPER and SALES

## Create an interaction between EXPER and SALES
## x3 = EXPER*SALES
reg2 = lm(COMP ~ EXPER + SALES + EXPER:SALES, data = df)
summary(reg2)

## The interaction is related to the orginal variables
## it creates multicollinearity
## because EXPER:SALES is significant, we keep EXPER and SALES even if they are not significant

## INTERPRETATION OF THE ESTIMATES
options(scipen = 999)
summary(reg2)

## INTERPRET THE COMBINED EFFECT (EFFECT) OF VARIABLE
## EXPER
## As experience increases by 1 year, then we estimate the compensation
## to change by 0.990161 + 0.007667*SALES

## As experience increases by 1 year, then we estimate the compensation
## to change by 1.06M for a company with 10M in sales

## As experience increases by 1 year, then we estimate the compensation
## to change by 1.76M for a company with 10M in sales

## As experience increases by 1 year, the effect of the experience on the compensation
## will depend on the SALES of the company


## The interaction plot
plot(df$EXPER, df$COMP)
abline(lm(COMP ~ EXPER, data = df), col = "red")

plot(df$SALES, df$COMP)
abline(lm(COMP ~ SALES, data = df), col = "red")

## an interaction plot is a scatter plot of a predictor against the response
## with different levels of a second predictor
library(sjPlot)
plot_model(reg2, type = "int")
## because the two SLOPES are different, the interaction is important


## READ THE AUTOMOBILES DATA SET
df2 = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/automobiles.csv',
               stringsAsFactors = T)

head(df2)

## 1) create a regression using y = price, x1 = highway.mpg, x2 = engine.size
reg3 = lm(price ~ highway.mpg + engine.size, data = df2)
summary(reg3)


## 2) create a regression using y = price, x1 = highway.mpg, x2 = engine.size, 
## x3 = highway.mpg X engine.size
reg4 = lm(price ~ highway.mpg + engine.size + highway.mpg:engine.size, data = df2)
summary(reg4)

## The interaction p-value shows it is significant
## We need to keep both highway.mpg and engine.size even IF NOT SIGNIFICANT


## INTERPRETATION IS BASED ON THE EFFECTS
## What is the effect of highway.mpg on the price?
## As the highway mpg increases by 1, the estimated price changes
## by: 91.721 - 2.973*engine.size

## Example engine size = 100
## As the highway mpg increases by 1, the estimated price changes
## by: 91.721 - 2.973*100 = -$205.6
plot_model(reg4, type = "int")










