## Practice for Exam 2
#### Review

#### 1) Categorical Predictors
###### a) number of levels, number of dummies created (model df)
###### b) reference level (base)
###### c) significance (at least 1 level makes the whole predictor signif)

#### 2) Interactions
###### a) Compute the effect of a variable x1 if there is an interaction (x1x2)
###### b) Interpret the effect (example)
###### c) predict y if there is an interaction present (x1x2 - multiplication of x1 and x2)

#### 3) Polynomial Models
###### a) degree of the model 
###### b) For a quadratic model, know the signs of B1 and B2
###### c) Interpret and compute the effect (example)


## cardata.csv

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/cardata.csv',
              stringsAsFactors = T)

## model df (measure of complexity - want as low as possible)
## model df = k (number of slopes)
#### Numeric Variables: 1 model df
####

## highwaympg
reg1 = lm(price ~ highwaympg + citympg + fuelsystem, data = df)
summary(reg1)
anova(reg1)


##### Now we have 7 hyp. tests for 1 single variable: fuelsystem

## 1) 
## H0: B_2bbl = 0 (there is no diff between 2bbl and 1bbl)
## HA: B_2bbl != 0 (there is a diff between 2bbl and 1bbl)
## THERE IS NO STATISTICAL DIFF IN THE PRICE 


## We have 6 more tests


## Is fuelsystem (variable) important in predicting price?
#### Yes, at least one level is significant

## Which fuelsystem is the most expensive?
## the idi b/c it has the largest + diff compared to the base

## what is the base (ref)?
## 1bbl is the ref

## T or F. The 1bbl fuel system is the least expensive.
## F

## Reg4
reg4 = lm(price ~ horsepower + citympg + carbody, data = df)
summary(reg4)
anova(reg4)

## what are the total model df of this model?
## horsepower: 1
## citympg:    1
## carbody:    4
## total model df = 6


### model.matrix
model.matrix(reg4)

## Interactions
reg5 = lm(price ~ horsepower + citympg + carbody + horsepower:citympg, data = df)
summary(reg5)

## Effect of horsepower
## 300.325  -10.418*citympg
## it depends on citympg


## example
### 30 mpg city
300.325  -10.418*30

reg5 = lm(price ~ horsepower + citympg + carbody + I(citympg^2), data = df)
summary(reg5)

## effect of citympg
## -1809.97 +2*27.71 *citympg





