## Practice for Exam 2
## Review
#### Categorical Predictors
####### number of levels, number of dummies (model df)
####### reference (base) levels (compare against)
####### significance (1 level is significant, keep the variable - all levels)

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/cardata.csv',
              stringsAsFactors = T)

## structure (types of vars)
str(df)

## example for highwaympg
reg1 = lm(price ~ highwaympg, data = df)
summary(reg1)
anova(reg1)

## fuelsystem      
levels(df$fuelsystem)
nlevels(df$fuelsystem) ## see structure

## example for highwaympg
reg1 = lm(price ~ fuelsystem, data = df)
summary(reg1)
anova(reg1)

## reference on fueltype
levels(df$fueltype)

## example
reg1 = lm(price ~ fueltype, data = df)
summary(reg1)
anova(reg1)

## example
reg1 = lm(price ~ carbody, data = df)
summary(reg1)
anova(reg1)

## y = price
## x1 = horsepower (1 model df)
## x2 = citympg (1 model df)
## x3 = carbody (4 model df)
## Total model df = 6 model df
reg2 = lm(price ~ horsepower + citympg + carbody,
          data = df)
summary(reg2)
anova(reg2)

## predict
predict(reg2, data.frame(horsepower = 102, citympg = 25, carbody = "sedan"))

library(rgl)
library(car)
scatter3d(price ~ horsepower + citympg + carbody,data = df)


## Interactions and Quadratic
reg3 = lm(price ~ horsepower + citympg + I(citympg^2) + carbody + 
            horsepower:citympg, data = df)
summary(reg3)

## CANNOT drop citympg - interaction horsepower:citympg is sign
## CAN drop I(citympg^2) 

## EFFECT of citympg
# -398.455 + 2*11.710*citympg + -7.950*horsepower

## Effect of Horsepower 
##  245.913 -7.950*citympg

