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
lr1 = step(null, scope = list(lower = null, upper = full), trace = 2, k = 2)

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



