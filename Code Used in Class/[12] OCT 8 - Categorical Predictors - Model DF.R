## Categorical Predictors
## Incorporating / encoding to regression

### CHECKING / CORRECTING VARIABLE TYPES

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/airfares.csv')

## you want all categorical predictors to be read as factors
df$GATE = as.factor(df$GATE)

## Instead always use stringsAsFactors = T
## so that every categorical predictor is read as a factor
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/airfares.csv',
              stringsAsFactors = T)

mean(df$NEW) ## if the average, min, max make sense then it should be a numeric, otherwise a factor


## NUMBER OF LEVELS
str(df)
##  S_CODE  : Factor w/ 8 levels 

## nlevels function
nlevels(df$E_CITY)

## LEVELS
levels(df$S_CODE)
levels(df$VACATION)


## REFERENCE (BASE) LEVEL
## this is the level we compare against
## leves(df$var)  (first level in the list)
levels(df$S_CITY)
## [1] "Albuquerque         NM" is the reference

levels(df$SLOT)
## "Controlled" is the reference (base) level

## if you run a regression, the ref level is what compare against
reg1 = lm(FARE ~ SLOT, data = df)
summary(reg1)
## the ref level does NOT show on the reg output

## variable VACATION (vac route: yes, vac route: no)
levels(df$VACATION)
## [1] "No"  is the reference

reg2 = lm(FARE ~ VACATION, data = df)
summary(reg2)

## to relevel
df$VACATION = relevel(df$VACATION, ref = "Yes")

levels(df$VACATION)
## [1] "Yes"  is the reference

reg2 = lm(FARE ~ VACATION, data = df)
summary(reg2)


## One hot encoding for VACATION = {No, Yes}
## 1) VACATIONNo = {0:  vacation route, 1: NOT vacation route}
## 2) VACATIONYes = {0: not vacation route, 1: vacation route}

## Encoding means we need to change ALL variables using encoding
VACATIONNo = ifelse(df$VACATION == "No", 1, 0)
VACATIONYes = ifelse(df$VACATION == "Yes", 1, 0)

## ISSUE with one hot encoding (singular matrix)
reg3 = lm(df$FARE ~ VACATIONYes + VACATIONNo)
summary(reg3) ## NAs are the result of a linear combination in the model matrix
model.matrix(reg3)
## for non-linear models (RF, Boosting, Deep Learning) 

## DUMMY-ENCODING
## this is the way that we need to encode
## leave one level out (ref)

## Encoding means we need to change ALL variables using encoding
## Do not create VACATIONNo (call this the reference)
VACATIONYes = ifelse(df$VACATION == "Yes", 1, 0)

reg4 = lm(df$FARE ~ VACATIONYes)
summary(reg4) 
model.matrix(reg4)


## examples
## ref level is included in the y-intercept
levels(df$GATE)

## regression example
reg5 = lm(FARE ~ GATE, data = df) ## dummy-variable was created automatically
summary(reg5)

## what is the meaning of the (Intercept)  193.129
## E(FARE) = B0 + B1*GATEFree
## and GATEFree = {0: constrained, 1: free}
## If the value of GATEFree is zero (constrained), the estimated FARE is  193.129  

## use S_CODE as predictor of FARE
## reg5 - summary
reg5 = lm(FARE ~ S_CODE, data = df)
summary(reg5)

## AIRPORT EXAMPLE POWERPOINT
## FARE = 150 + 20*DIST + 30*DB - 10*DC + 40* DD + 25*DE
## ESTIMATED FARE (DIST = 500 MILES AND AIRPORT D)
DIST = 5
DB = 0 ## not airport B
DC = 0 ## not airport C
DD = 1 ## airport D 
DE = 0 ## not airport E
FARE = 150 + 20*DIST + 30*DB - 10*DC + 40* DD + 25*DE
FARE

## Y-INTERCEPT
## for a flight with a distance of 0 miles
## coming out of airport A, the estimated fare is $150

## As the distance increases by 1000 miles, holding everything else
## constant, the fare increases by $20

## What does the estimate for dummy for airport E mean (DE)?
## The estimated fare for airport E is $25 more than
## airport A holding everything else constant

## SIGNIFICANCE OF DUMMY VARIABLES
## If 1 level is significant then we consider the WHOLE
## Variable to be an important predictor of y

## Is S_CODE a significant predictor of FARE?
## Yes, there is information in the variable S_CODE
## Some airports have statistically significant differences
## in the FARES
## For example, EWR is statistically more expensive than (Unknown)
## $33.87 
## There are some airport that do not have statistically signficant
## differences

## What is the model df contributed by variable E_CITY?
## 68 levels
## model df = 68 - 1= 67

## SUPPOSE WE USE DISTANCE, SW, VACATION, E_CODE as predictors
## of FARE? WHAT WOULD BE THE TOTAL MODEL DF?

## DIST = 1 model df
## SW = 1 model df
## VACATION = 1 model df
## E_CODE = 7 model df

## TOTAL MODEL DF = 10 model df (the lower the better)
## ERROR DF =  n - (k+1)  where k is MODEL DF (638 - 11)
## ERROR DF (the higher the better)
