## Variable Selection Techniques

#### ALL-SUBSETS TECHNIQUE
# this technique creates every possible combination

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/cellphone_prices.csv',
              stringsAsFactors = T)

head(df)


## split into training and test
set.seed(291)
trainIndex = sample(1:nrow(df), round(0.8*nrow(df)))
df.train = df[trainIndex, ]
df.test =  df[-trainIndex, ]


## missing values
colSums(is.na(df)) ## missing vals per variable

## df = na.omit(df) -- would remove ALL missing values

## BEST-SUBSETS (leaps)
#### y = Price
##### Best 1-variable model
##### Best 2-variable model
library(leaps)

reg_s = regsubsets(Price ~ ., data = df.train, nbest = 1)
summary(reg_s)

## best 1 variable:  RAMGB
## best 2 variables: Battery + Camera
## best 3 variables: StorageGB + Battery + Camera


## which is the model with the best adj-R2?
reg_s_summary = summary(reg_s)
best_adjr2 = which.max(reg_s_summary$adjr2)
reg_s_summary$outmat[best_adjr2,]

## which is the model with the best BIC?
#### BIC tends to select models with fewer variables
reg_s_summary = summary(reg_s)
best_bic = which.min(reg_s_summary$bic)
reg_s_summary$outmat[best_bic,]


## selecting the higher-order to use.
## build a model with ALL interactions possible
#### . means all variables
#### (.)^2 means all interactions
## also include ALL quadratics
## exclude original variables (force them in)

## we have 5 that are significant
reg_q = regsubsets(Price ~ (.)^2 + I(RAMGB^2) +
                   I(ScreenSize^2) + I(StorageGB^2)
                   + I(Battery^2) + I(Camera^2),
                   data = df.train, force.in = 1:5, nbest = 1)

summary(reg_q)

## which is the model with the best adj-R2?
reg_q_summary = summary(reg_q)
best_adjr2 = which.max(reg_q_summary$adjr2)
reg_q_summary$outmat[best_adjr2,]

## candidate model 1
model1 = lm(Price ~ . + I(RAMGB^2) + I(Battery^2) + StorageGB:Battery,
            data = df.train)
summary(model1)

## predictive metrics
library(caret)
postResample(predict(model1, df.test), df.test$Price)


## Variable screening with many predictors
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/housing_ames_mod.csv',
              stringsAsFactors = T)

head(df)

## missing values
colSums(is.na(df))

## fix these values
##### option 1) remove ALL 
##### df = na.omit(df)
##### NOT recommended if you have many missing obs


##### option 2) imputation
##### create FAKE values when missing
##### if missing - take mean, median 
df$LotArea[is.na(df$LotArea)] = mean(df$LotArea, na.rm = T)
df$TotalBsmtSF[is.na(df$TotalBsmtSF)] = median(df$TotalBsmtSF, na.rm = T)


## split into training and test 
#### 70% training, 30% test
set.seed(291)
trainIndex = sample(1:nrow(df), round(0.7*nrow(df)))
df.train = df[trainIndex, ]
df.test =  df[-trainIndex, ]

## SELECT VARIABLES
regsubsets(SalePrice ~., data = df.train, nbest = 1)
#### too many predictors

#### 1) drop variables that you KNOW are not important
df.train$Id = NULL

#### 2) BACKWARDS, FORWARD, STEPWISE


#### Backward variable screening technique

#### a) largest model: full
#### b) smallest model: null

full = lm(SalePrice ~ ., data = df.train)
null = lm(SalePrice ~ 1, data = df.train)

#### c) scope = list(lower = null, upper = full)
#### options: trace = 0 (nothing printed), trace = 2 (prints everything)
#### d) direction = "backward" 
#### step(full, scope, trace, statistic)
#### BIC: k = log(nrow(df.train))
#### AIC: k = 2
reg_b = step(full, scope = list(lower = null, upper = full), trace = 2, k = 2, direction = "backward")  
summary(reg_b) ## variables selected

#### BIC is better at removing MANY predictor

reg_b = step(full, scope = list(lower = null, upper = full), trace = 2, k = log(nrow(df.train)), direction = "backward" )
summary(reg_b) ## variables selected

















