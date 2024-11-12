## Variable Screening Techniques
## Reduce the number of predictors

## Read Data
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/housing_ames_mod.csv',
              stringsAsFactors = T)
head(df)

## Missing Values
colSums(is.na(df)) ## this function ONLY checks for numeric variables
## LotArea (6 obs missing)
## TotalBsmtSF (3 obs missing)  

## Impute the missing values
## fill missing with mean, median

## Impute LotArea with the median of LotArea
## median(df$LotArea, na.rm = T)
df$LotArea[is.na(df$LotArea)] = median(df$LotArea, na.rm = T)

## Impute TotalBsmtSF with the mean of TotalBsmtSF
df$TotalBsmtSF[is.na(df$TotalBsmtSF)] = mean(df$TotalBsmtSF, na.rm = T)

## MICE (takes too long to work)

## (ALTERNATIVE) Removing ALL observation with missing values
df = na.omit(df)

## structure (variables, cat, num)
str(df)

## Remove UNINFORMATIVE variables
## IDs, Names, street address
df$Id = NULL

## 1) SPLIT TRAIN/TEST 
set.seed(291)
trainIndex = sample(1:nrow(df), round(0.7*nrow(df)))
df.train = df[trainIndex,]
df.test =  df[-trainIndex,]

## print obs training
head(df.train)

## print obs validation
head(df.test)

## 2) VARIABLE SCREENING
#### a) ALL SUBSETS (too computationally expensive)
library(leaps)
reg_allsubsets = regsubsets(SalePrice~., data = df.train, nbest = 1, nvmax = 15)

#### b) BACKWARD SELECTION (works faster)
###### need to specify metric (AIC - more variables, BIC - fewer variables)

## smallest model to consider
null = lm(SalePrice ~ 1, data = df.train)

## largest model to consider
full = lm(SalePrice ~ ., data = df.train)

## create a backward regression (reg_backward) use step
## step(starting_model, 
## scope = list(lower = SMALLEST MODEL, upper = LARGEST MODEL))
## trace = 2 (prints EVERYTHING), trace = 0 (prints NOTHING)
## k = 2 (AIC), k = log(nrow(df.train)) (BIC)
## direction = "backward" default

reg_backward = step(full, scope = list(lower = null , upper = full), trace = 2,
                    k = 2)
summary(reg_backward)
## there are LINEAR COMBINATIONS on the variables
## NA estimates
## smaller 

## MODEL found using backward selection technique
## Variables found important
# reg1 = lm(formula = SalePrice ~ MSZoning + LotFrontage + LotArea + Street + 
#             LandContour + LandSlope + Neighborhood + Condition1 + Condition2 + 
#             BldgType + OverallQual + OverallCond + YearBuilt + YearRemodAdd + 
#             RoofMatl + Exterior1st + MasVnrType + MasVnrArea + ExterQual + 
#             BsmtQual + BsmtExposure + BsmtFinType1 + BsmtFinSF2 + BsmtUnfSF + 
#             TotalBsmtSF + X1stFlrSF + X2ndFlrSF + BsmtHalfBath + BedroomAbvGr + 
#             KitchenAbvGr + KitchenQual + TotRmsAbvGrd + Functional + 
#             Fireplaces + GarageYrBlt + GarageCars + PavedDrive + MoSold + 
#             SaleType + SaleCondition, data = df.train)


reg_backward = step(full, scope = list(lower = null , upper = full), trace = 2,
                    k = log(nrow(df.train)))
summary(reg_backward)

## FINAL VARIABLES WITH BIC
## BIC = MSE + log(n)(k+1)
## penalty log(n) called k in step function
reg2 = lm(formula = SalePrice ~ MSSubClass + LotArea + LandSlope + Condition2 + 
            OverallQual + OverallCond + YearBuilt + MasVnrArea + BsmtQual + 
            BsmtFinSF1 + TotalBsmtSF + X1stFlrSF + X2ndFlrSF + BedroomAbvGr + 
            KitchenAbvGr + KitchenQual + TotRmsAbvGrd + GarageYrBlt + 
            GarageCars + SaleCondition, data = df.train)

options(scipen = 999)
summary(reg2)


## FORWARD VARIABLE SELECTION
## use BIC for this example
reg_forward = step(null, scope = list(lower = null , upper = full), trace = 2,
                    k = log(nrow(df.train)), direction  = "forward")
summary(reg_forward)

## STEPWISE VARIABLE SELECTION
## use BIC for this example
reg_stepwise = step(null, scope = list(lower = null , upper = full), trace = 2,
                    k = log(nrow(df.train)), direction  = "both")
summary(reg_stepwise)

## WE CAN IMPROVE THESE MODELS BY COMBINING LEVELS (insignificant)
## ALSO CONSIDER INCLUDING INTERACTIONS

## add LotArea squared to check significance
reg3 = lm(formula = SalePrice ~ OverallQual + GrLivArea + BsmtFinSF1 + 
            Condition2 + ExterQual + MSSubClass + YearBuilt + LotArea + 
            SaleCondition + BedroomAbvGr + TotalBsmtSF + OverallCond + 
            BsmtQual + MasVnrArea + KitchenAbvGr + TotRmsAbvGrd + MasVnrType + 
            GarageCars + GarageYrBlt + I(LotArea^2), data = df.train)
summary(reg3)
  




