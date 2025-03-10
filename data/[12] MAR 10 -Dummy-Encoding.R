## Incorporating Categorical Predictors
## Encoding (dummy-variable encoding)

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/airfares.csv',
              stringsAsFactors = T)

## y = FARE
## info about routes

## NUMERIC VARIABLES
#### can be int (integer, 1,2 10) or num (float, anything with decimals)
#### is there any variable that should NOT be a numeric type?
mean(df$NEW) ## average number of airlines flying new routes is 2.75 by year
## interpretation of slope makes sense
## As the number of airlines increases by 1 in the route, the estimated FARE changes by Beta_New

## CATEGORICAL PREDICTORS
#### should be read as factor (factor variables are encoded easily)
#### should any factor variable be changed to numeric?
#### dollar-based variable $700.00  (read as factor), should be changed

## NUMBER OF LEVELS OF CATEGORICAL PREDICTORS
nlevels(df$E_CODE)  ## 8 levels

## think about modifying variables with TOO MANY levels (> 20 levels)
## e.g., E_CITY with 68 levels creates too many dummy variables

## LEVELS OF CATEGORICAL PREDICTORS
levels(df$S_CODE)
levels(df$E_CITY)

## REFERENCE (BASE) LEVEL OF A CATEGORICAL PREDICTOR
## this is what we compare against
## it is the level we leave out when creating dummy variables
levels(df$VACATION)
## in R reference level is the first one when you run levels()
## "No" is the ref
levels(df$S_CODE)
## "*" is the reference

## how do we encode in R?
## you can do this manually with code
## Vacation = {"No", Yes"}
## with two levels you want to create 1 single dummy
Vacation_Route = ifelse(df$VACATION == "Yes", 1, 0)

## easiest way is to let lm function create the dummy encoding
reg1 = lm(FARE ~ VACATION, data = df)
summary(reg1)
## "No" is the ref, 
## so you get slope for OTHER LEVELS not the ref

## say example starting airport code S_CODE
levels(df$S_CODE)
# "*" the ref
reg2 = lm(FARE ~ S_CODE, data = df)
summary(reg2)


## You do not want a predictor that creates too many levels
## > 20 consider dropping or modifying (more on this later)
reg3 = lm(FARE ~ E_CITY, data = df)
summary(reg3)













