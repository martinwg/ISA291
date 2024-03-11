## Model Complexity 
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/insurance.csv',
              stringsAsFactors = T)

## print some obs
head(df)

## structure of the data
str(df)

## numeric variables
## age, bmi, children, charges (response)

## categorical predictors
## sex, smoker, region

## How many model df do we have if we use ALL variables to predict charges?
## every numeric adds 1 model degrees of freedom (not counting the response)
## 3 model df (numeric)

## every categorical variables adds #levels-1 model df
## 1 + 1 + 3 = 5 model df (categorical)

## ANSWER: 8 model df

## Regression 
reg1 = lm(charges ~ ., data = df)
summary(reg1)


## R Syntax
## the first level is chosen as the reference
## northeast (ref)
## regionnorthwest = {0: not ,1: "northeast"}

## smoker
## no: reference
## smokeryes


## Dataset 2
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/CARGO.csv',
              stringsAsFactors = T)

head(df)

## Regression
reg2 = lm(COST ~ CARGO, data = df)
summary(reg2)

## CARGO
## default level for reference: DURABLE
## CARGOFragile = {0,1}
## CARGOSemiFrag = {0,1}

## summary(reg1)
## first data set
summary(reg1)
## Is region significant?
## if there is one level that is significant
## then the whole variable brings information.


## ANOVA
## combines ALL THE levels per each variable
anova(reg1)
## the anova shows the combined contribution of the variables (with all levels)
## this is the additional contribution given the other variables

## DATASET 2
summary(reg2)
anova(reg2)


## model matrix
## is the matrix of predictors (with a column of 1s as the first column)
model.matrix(reg2)


## DATASET 1
model.matrix(reg1)[, -9] ## we can use the model matrix to delete (drop) levels


## EXAMPLES
df2 = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/automobiles.csv',
               stringsAsFactors = T)

reg3 = lm(price ~ make + engine.size, data = df2)
summary(reg3)


## ILLUSTRATION OF A 3D PLANE
## suppose y = "price"
## x1 = horsepower
## x2 = "highway.mpg"
## adding bodystyle creates 5 different planes

reg4 = lm(price ~ horsepower + highway.mpg + make, data = df2)
summary(reg4)
library(rgl) ## plot3d
library(car)## plot3d
scatter3d(price ~ horsepower + highway.mpg | body.style, data = df2)


