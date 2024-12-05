## Practice with Logistic Regression
#### Used in binary classification

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/employee_attrition.csv',
              stringsAsFactors = T)

head(df)


## PRE-PROCESSING
#### drop uninformative variables, constants
str(df)
df$EmployeeID = NULL
df$Over18 = NULL
df$StandardHours = NULL
df$EmployeeCount = NULL


#### check for missing values
colSums(is.na(df))

#### if missing, we have impute OR delete obs
#### ideally, imputation is the best option
df = na.omit(df)

#### Complexity (# model df)
str(df)
## numeric: 1 model df
## categorical: # levels - 1

## Encode the Response as {0,1}
df$Attrition = ifelse(df$Attrition == "Yes", 1, 0)


## let's check importance of levels for JobRole
summary(glm(Attrition ~ JobRole, data = df, family = "binomial"))

#### ref = "Healthcare Representative"

#### (Not correct) Human Resources employees are less likely to attrite
#### (correct) Human Resources employees are less likely to attrite than Healthcare Representatives (not statistically significant)

#### Keep Research Director
#### combine the rest of the levels to "other"
library(forcats)
df$JobRole = fct_collapse(df$JobRole,
                          ResearchDirector = c('Research Director'),
                          other_level = "Other")
levels(df$JobRole)

## What is the reference level for JobRole?
## "ResearchDirector" appears first (levels function)
## Relevel to "Other" being the reference
df$JobRole = relevel(df$JobRole, ref = "Other")

### Predictive Models (goal is to predict new data accurately)
#### We split the data into training/test
#### so we can infer how good the model is using NEW data
set.seed(291)
trainIndex = sample(1:nrow(df), round(0.7*nrow(df)))
df.train = df[trainIndex,] ## where we build the models
df.test = df[-trainIndex,] ## where we check performance

## Automatically select variables
## 1) Stepwise (best), 2) Forward, Backward, 3) All subsets

null = glm(Attrition ~ 1, data = df.train, family = "binomial")
full = glm(Attrition ~ ., data = df.train, family = "binomial")
lr1 = step(null, scope = list(lower = null, upper = full), trace = 2, k = 2, direction = "both")

## AIC: k = 2
## BIC: k = log(nrow(df)) - select fewer variables

aic_lr = glm(Attrition ~ TotalWorkingYears + MaritalStatus + BusinessTravel + 
               NumCompaniesWorked + Department + YearsSinceLastPromotion + 
               YearsWithCurrManager + Age + TrainingTimesLastYear + JobRole + 
               StockOptionLevel + Education, data = df.train, family = "binomial")

## To the aic_lr add the quadratic term for TotalWorkingYears

aic_lr = glm(Attrition ~ TotalWorkingYears + MaritalStatus + BusinessTravel + 
               NumCompaniesWorked + Department + YearsSinceLastPromotion + 
               YearsWithCurrManager + Age + TrainingTimesLastYear + JobRole + 
               StockOptionLevel + Education + I(TotalWorkingYears^2), 
             data = df.train, family = "binomial")
summary(aic_lr)

#### Suppose you want fewer predictors, you decide to use BIC
#### 1) stepwise using BIC
#### 2) to the BIC model add the quadratic for TotalWorkingYears

null = glm(Attrition ~ 1, data = df.train, family = "binomial")
full = glm(Attrition ~ ., data = df.train, family = "binomial")
lr1 = step(null, scope = list(lower = null, upper = full), trace = 2, k = log(nrow(df.train)))

bic_lr = glm(Attrition ~ TotalWorkingYears + MaritalStatus + BusinessTravel + 
               NumCompaniesWorked + YearsWithCurrManager + YearsSinceLastPromotion + 
               Age + Department + TrainingTimesLastYear + I(TotalWorkingYears^2), data = df.train,
             family = "binomial")
summary(bic_lr)

## Interpretations;
summary(bic_lr)

## For Logistic Regression
#### 1) signs tell the relationship
#### Age is negatively related to the prob(Attrite)
#### As age increases, it is less likely that they attrite
#### controlling for other factors


#### 2) Log(odds) interpretations
#### interpret TrainingTimesLastYear            
#### As the training times the employee had last year
#### increases by 1, the estimated log(odds) of attriting
#### decreases by 0.1457558 holding other vars constant

#### 3) odds interpretations
#### interpret TrainingTimesLastYear            
#### As the training times the employee had last year
#### increases by 1, the estimated odds of attriting
#### changes by a factor of 0.8643688 holding other vars constant

#### Create a table of signs
## TotalWorkingYears - + I(TotalWorkingYears^2)

#### TotalWorkingYears (Interpretation) - Quadratic Terms
#### 1) Log(odds)
#### As total working years increases by 1, we estimate 
#### the log(odds) of attriting to change by
#### -0.1901498+2*0.0041838*TotalWorkingYears
#### e.g., if working years = 2, then log(odds) will change by -0.1734146
#### holding other vars constant

#### 2) odds
#### As total working years increases by 1, we estimate 
#### the odds attriting to change by a factor of
#### exp(-0.1901498+2*0.0041838*TotalWorkingYears)
#### e.g., if working years = 2, then odds will change by a factor of
#### 0.840789 holding other vars constant

#### Categorical Predictor
#### Married Employees have log(odds) of attriting 0.0964649 higher
#### than DIVORCED (reference) employees, holding other vars constant

#### Predicting
#### Employee
#### TotalWorkingYears = 5
#### MaritalStatus = Divorced
#### Business Travel = 'travel_rarely'
#### NumofCompaniesWorked = 4
#### YearsSinceLastPromotion = 2
#### YearsCurrManager = 3
#### Age = 23
##### Department = Sales
#### PercentSalaryHike = 10
#### TrainingTimesLastYear = 4
#### StockOptionLevel = 1



#### 1) Log(odds) of attrition
## Use Code
df_new = data.frame(TotalWorkingYears = 5,
                    MaritalStatus = "Divorced",
                    BusinessTravel = "Travel_Rarely",
                    NumCompaniesWorked = 4,
                    YearsWithCurrManager = 3,
                    YearsSinceLastPromotion = 2,
                    Age = 23,
                    Department = "Sales",
                    TrainingTimesLastYear = 4)

### 0.1133071 -0.1901498 * 5 + .... + 0.0041838*5^2
                    
predict(bic_lr, df_new) ## log(odds)
## The log odds of attrition = -1.625293 

#### 2) Probability of attrition

## a) manually
## logistic 
exp(-1.625293) / (1+exp(-1.625293))
## The prob of attrition  = 0.1644762

## b) code
phat = predict(bic_lr, df_new, type = "response") ## prob
## prediction
prediction_for_new_employee = phat > 0.5

#### ACCURACY on Test (Predictive)
#### by default 0.5 cutoff (arbitrary cutoff)
#### if prob > 0.5 then we predict employee will attrite
#### How accurate is this model?

#### Prediction for ALL observations (prob)
#### condition (phat > 0.5) predict 1 otherwise 0

phat = predict(bic_lr, df.test, type = "response")
y_pred = phat > 0.5
y_true = df.test$Attrition

## How accurate is this model?
library(Metrics)
accuracy(y_true, y_pred) 
## 84.2% accurate 