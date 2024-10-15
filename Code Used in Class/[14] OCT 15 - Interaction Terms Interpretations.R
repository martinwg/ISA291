## INTERACTIONS TERMS

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/CeoCompensation.csv',
              stringsAsFactors = T)
head(df)

## 1st-order model
## does NOT take into account any interactions
reg1 = lm(COMP ~ EXPER + SALES, data = df)
summary(reg1)

## plot the relationships
plot(df$EXPER, df$COMP)
abline(lm(COMP ~ EXPER, data = df), col = "red", lwd = 4)

plot(df$SALES, df$COMP)
abline(lm(COMP ~ SALES, data = df), col = "red", lwd = 4)

## plot joint relationship
library(rgl)
library(car)
scatter3d(COMP ~ EXPER + SALES, data = df)

## let's test an interaction between the EXPER and the SALES
## MAYBE there is a combined effect on the COMP
## Interactions are multiplications of the variable pair
## R --   EXPER:SALES
reg2 = lm(COMP ~ EXPER + SALES + EXPER:SALES, data = df)
summary(reg2)

## h0; Beta3 = 0
## HA: Beta3 != 0
## Interaction term is STATISTICALLY SIGNIFICANT
## Keep BOTH variables in the model because THEIR INTERACTION
## is significant

## INTERPRETATIONS
options(scipen = 999)
reg2 = lm(COMP ~ EXPER + SALES + EXPER:SALES, data = df)
summary(reg2)

## y-intercept: interpretation not affected with interactions
## We estimate the salary of a CEO, with NO experience and 
## company SALES equal to 0, to be 776.298893 thousand

## because there is a significant interaction
## DO NOT INTERPRET THE INDIVIDUAL SLOPES (pair)
## Instead interpret the COMBINED effect of each variable (pair)

## Effect of EXPER on the COMP
## As experience increases by 1 year, we estimate the COMP to change
## by: 0.990161 + 0.007667*SALES
## we need to know the exact SALES of the company to know by how much
## the compensation changes

## example: If SALES = 1MM
## As experience increases by 1 year, we estimate the COMP to change
## by: 0.990161 + 0.007667*1 = 0.997828, in other words, COMP increases
## by $997

## example: If SALES = 50MM
## As experience increases by 1 year, we estimate the COMP to change
## by: 0.990161 + 0.007667*100 = 1.756861, in other words, COMP increases
## by $1,756.86

## example: If SALES = 2000MM
## As experience increases by 1 year, we estimate the COMP to change
## by: 0.990161 + 0.007667*2000 = 16.32416, in other words, COMP increases
## by $16,324.16

## Effect of SALES on the COMP
## 0.018976 + 0.007667*EXPER
## As the sales of the company increases by 1MM, we estimate
## the compensation to change by 0.018976 + 0.007667*EXPER

## TRUE or ***(FALSE)
## As experience increases by 1 year, the compensation of the CEO
## is expected to increase by 0.990161

## plot the interaction
## you have to select multiple values of SALES
plot(df$EXPER, df$COMP)
abline(lm(COMP ~ EXPER, data = df), col = "red", lwd = 4)
abline(776.298893, 0.997828, col = "blue", lwd = 4) ## blue slope (1MM)
abline(776.298893, 1.756861, col = "green", lwd = 4) ## green slope (100MM)
abline(776.298893, 16.32416, col = "black", lwd = 4) ## black slope (2000MM)


## most useful way to plot an interaction (package)
## sjPlot - selects two completely different of SALES
install.packages('sjPlot')
library(sjPlot)
plot_model(reg2, type = "int")
## because the two slopes are VERY DIFFERENT
## the effect OF experience depends heavily on the SALES


## AUTOMOBILES (Price)
df2 = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/automobiles.csv',
               stringsAsFactors = T)

## y = price
## x1 = highway.mpg
## x2 = engine.size in cc
## 1st-order regression (no higher-order terms)
reg1 = lm(price ~ highway.mpg + engine.size, data = df2)
summary(reg1)

## how to know if there is an interaction
## residuals will have non-constant variance
## residuals might not be normally distribution
plot(reg1)

## knowing the problem can tell you about possible interactions
## As the MPG of a car increases, do you think the price of 
## the car should be different depending on engine.size?
## Ford, Honda, Chevy (lower Engine Sizes) - as MPG increases price should decrease
## Ferrari, BMW M3 (higher Engine Sizes) -
## there might be an interaction present (TEST IT)
reg2 = lm(price ~ highway.mpg + engine.size 
          + highway.mpg:engine.size , data = df2)
summary(reg2)


## PLOT THE INTERACTION
plot_model(reg2, type = "int")

## interpret the effect of highway.mpg
## in the language of the problem
## 1) make sure to understand
## the effect of highway.mpg on the price
## depends on the engine.size

## 2) How so?
## As highway.mpg increase by mile, we estimate
## the price of the car to CHANGE BY
## 91.721 -2.973*engine.size

## 3) Give examples
## Suppose that engine.size 100cc
## As highway.mpg increase by mile, we estimate
## the price of the car to decrease by $205.6


## what is the estimated change in the price
## if engine.size increases by 1cc for a car that gets
## 30MPG?

## 1) when is an interaction significant?
## 2) for an interaction plot, answer whether there is an interaction
## 3) definition of interaction: effect of a variable depends on another
## 4) determine the exact effect of a variable on the response


## y = price
## x1 = engine.size
## x2 = highway.mpg
## x3 = fuel.type = {diesel or gas}
reg3 = lm(price ~ engine.size + highway.mpg + fuel.type,
          data = df2)

summary(reg3)


## is there an interaction between engine.size and fuel.type
reg4 = lm(price ~ engine.size + highway.mpg + fuel.type
          +  engine.size:fuel.type, data = df2)

summary(reg4)

## interaction of engine size and fuel type (NOT SIGNIFICANT)
## do NOT INCLUDE THE INTERACTION because it makes
## the model MORE COMPLEX

## effect of engine.size on the price
## 165.80 -25.52fuel.typegas 
## fuel.typegas is only 0 or 1 

## increases the price by 165.80 for A DIESEL CAR
## increases the price by 140.28 for A GAS CAR
