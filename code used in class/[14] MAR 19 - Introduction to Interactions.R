## INTERACTIONS

## Data: CEO Comp
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/CeoCompensation.csv',
              stringsAsFactors = T)

## y = COMP in $1000s
## x1 = EXPER in years
## x2 = SALES in 100 million

## subset variables
df = df[, c("COMP", "EXPER", "SALES")]

## scatter plot matrix
plot(df)

## correlation matrix
cor(df)
## even though the predictors
## EXPER AND SALES are fairly unrelated linearly
## That does not mean there is NO interaction


## FIRST-ORDER MODEL (no interactions, no higher-order terms)
reg1 = lm(COMP ~ EXPER + SALES, data = df)
summary(reg1)

## Interpretation of slopes
## Let's call slopes (The effect of a variable on y)

## e.g., the effect of EXPER on COMP
## definition of effect
## by how much does COMP change when we change EXPER
## rise / run
## d COMP / d EXPER

## COMP = 594.93432 + 26.25240 EXPER + 0.07140 SALES
## d COMP / d EXPER = 26.25240

COMP = 594.93432 + 26.25240*2 + 0.07140*10 ## old comp
COMP = 594.93432 + 26.25240*3 + 0.07140*10 ## new comp inc EXPER by 1

## What is the effect of SALES on COMP?
## d COMP / d SALES =  0.07140 

## This model (first-order) consider only linear effects
library(rgl)
library(car)
scatter3d(COMP ~ EXPER + SALES, data = df, fit = "quadratic")


## FITTING HIGHER-ORDER MODELS

## Interactions
#### The effect of EXPER depends on the levels (values)
#### of another variable SALES

## How can we test if two predictors interact (EXPER with SALES)
## x3 = EXPER*SALES
## in R, EXPER:SALES creates the interaction (multiplication)
## Test 
## H0: B_EXPER:SALES = 0 (no interaction)
## HA: B_EXPER:SALES != 0 (interaction)
## if we reject H0, that means there IS  a significant interaction 

## Idea: If you have suspicion of a possible interaction 
## Test it, if model improves (adj-R2 gets better, and significant interaction)
options(scipen = 999)
reg2 = lm(COMP ~ EXPER + SALES + EXPER:SALES, data = df)
summary(reg2)

## H0: B_EXPER:SALES = 0 (no interaction)
## HA: B_EXPER:SALES != 0 (interaction)
## t = 3.592 std errors aways from zero
## p(|t| > 3.592) | H0 is true = 0.000519
## We conclude the two variables interact

## test for EXPER shows non-significance (IGNORE)
## test for SALES shows non-significance (IGNORE)
## if interaction between x1*x2 is significant 
## leave x1 and x2 in the model regardless of tests

vif(reg2) ## are disregarded for interacting variables


## The effect of changing exper
## d COMP / d EXPER = 


## example: SALES = 10, EXPER = 1 (+1)
SALES = 10
EXPER = 1
COMP = 776.298893 +  0.990161*EXPER + 0.018976*SALES + 0.007667*EXPER*SALES
## OLD COMP = 777.5555

SALES = 10
EXPER = 2
COMP = 776.298893 +  0.990161*EXPER + 0.018976*SALES + 0.007667*EXPER*SALES
## NEW COMP = 778.6223

## DELTA = 1.0668 (effect is 0.990161 + 0.007667*SALES)

## Interpretation of effects when interaction is present
## Effect 
## step 1) include the slope of the variable = 0.990161
## step 2) include the slope of interaction * interacting variable: 0.007667 * SALES
## add two:  0.990161 + 0.007667 * SALES
## d COMP / d EXPER = 0.990161 + 0.007667 * SALES


summary(reg2)

## Interpretation in the language of the problem
## Effect = 0.990161  +  0.007667 * SALES
## The effect of EXPER on the COMP depends on the SALES
## e.g., if SALES = 100
Effect = 0.990161  +  0.007667 * 100

## If SALES = 100 million, increasing the experience of the CEO
## by 1 year, is related to a 1.756 increase in the compensation

## e.g., if SALES = 1
Effect = 0.990161  +  0.007667 * 1
## If SALES = 1 million, increasing the experience of the CEO
## by 1 year, is related to a 0.99 increase in the compensation

## e.g., if SALES = 3000
Effect = 0.990161  +  0.007667 * 3000








