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


## INCLUDE MULTIPLE PREDICTORS (CATEGORICAL AND NUMERIC)
## y = FARE
## X1 = PAX
## X2 = DISTANCE
## X3 = VACATION
reg6 = lm(FARE ~ PAX + DISTANCE + VACATION, data = df)
## total model df = 3
summary(reg6)
anova(reg6)

## HYPOTHESIS TEST for PAX
## ho: Beta_PAX = 0
## ha: Beta_PAX != 0
## t-stat = -0.954
## df = 638 - (3 + 1) = 634
## is this estimate too far away from zero that we can consider
## rejecting H0?
## P(t-stat > |-0.954|) if H0 true: 0.34
## Not enough to reject H0

## HYPOTHESIS FOR VACATION = {Yes, No}

## we have a hypothesis test for every dummy variable
## H0: Beta_VacationNo = 0 (there is no diff between the fares of
## vacation routes and no vacation routes)
## HA: Beta_VacationNo != 0 (There is a diff between the fares of
## non-vacation routes compared to vac routes)
## diff is $58
## t-stat = 13.028
## p-value: < 2e-16 (there is a statistical significant diff
## in the fares of Non-vacation routes compared to vac routes)

## Visualization 
library(car)
library(rgl)
scatter3d(FARE ~ PAX + DISTANCE | VACATION, data=df, id=list(method="identify"))

## Y-INTERCEPT
## If average passengers on the route is zero, and the distance
## of the route is zero miles, and it is a vacation route
## then we estimate the fare to be $39.29

## SLOPE FOR PAX
## As the number of average passengers increases by 1,
## we estimate the fare to decrease by 0.0001446
## holding other variables constant

## VACATION FOR VACATIONNO
## (dummy variables are interpret different)
## Non-Vacation routes on average cost $58.85 than (ref)
## vacation routes holding other variables constant


## INCLUDE MULTIPLE PREDICTORS (CATEGORICAL AND NUMERIC)
## y = FARE
## X1 = PAX (1 MODEL DF)
## X2 = DISTANCE (1 MODEL DF)
## X3 = S_CODE (7 MODEL DF)

options(scipen = 999)
reg7 = lm(FARE ~ PAX + DISTANCE + S_CODE, data = df)
summary(reg7)

## HYP TEST PAX: fail to reject H0, not statistically signi
## HYP TEST DIST: reject H0, statistically significant
## HYP TEST S_CODE (IF 1 DUMMY IS SIGNIFICANT - S_CODE IS IMPORTANT)
##### S_CODEDCA: this route is NOT statistically diff than *
##### S_CODEEWR: this route is statistically diff than *
#####
#####
#####


## visualization
scatter3d(FARE ~ PAX + DISTANCE | S_CODE, data=df, id=list(method="identify"), col = c("blue", "green", "orange", "magenta", "cyan", "red", "yellow", "gray", "black"))
## 


df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/automobiles.csv',
              stringsAsFactors = T)

reg = lm(price ~ make + fuel.type + horsepower, data = df)
summary(reg)
