## MODEL BUILDING EXAMPLE

## Ames Data Set

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/housing_ames_mod.csv',
              stringsAsFactors = T)


## STEP 1) DATA PRE-PROCESSING
#### handle missing values
#### remove unnecessary variables (e.g., ID, names,...)
#### remove perfect multi-collinearity

colSums(is.na(df))
##### handling missing values (depends how many)
##### best practice (impute - variable by variable)
##### packages can impute all variable (rfImpute)
df = na.omit(df)  ## removes all missing (9 obs)

df$Id = NULL 
str(df)

## correlation plot
## Can do later


## STEP 2) FEATURE ENGINEERING
#### select only relevant variables
#### create NEW variables
#### combine levels of cats with many levels

# which techniques can we use to select variables
#### 1) all-subsets (only works with few variables)
#### 2) backward, forward, stepwise
#### 3) non-linear (advanced) - RF Variable Importance

## this is computationally expensive
## too many obs
## take a sample of your data 

# backwards
null = lm(SalePrice ~ 1, data = df)
full = lm(SalePrice ~ ., data = df)
bw_reg = step(full, 
              scope = list(lower = null, upper = full),
              trace = 2,
              k = log(nrow(df)),
              direction = "backward")

## what are the variables
summary(bw_reg)

## variables
bw_reg$call

## BIC Backward Variables
#lm(formula = SalePrice ~ MSSubClass + LotFrontage + LotArea + 
#     Neighborhood + Condition2 + OverallQual + OverallCond + YearBuilt + 
#     RoofMatl + MasVnrArea + ExterQual + BsmtExposure + BsmtFinSF1 + 
#     BsmtFinSF2 + BsmtUnfSF + X1stFlrSF + X2ndFlrSF + BedroomAbvGr + 
#     KitchenAbvGr + KitchenQual + TotRmsAbvGrd + GarageYrBlt + 
#     GarageArea + ScreenPorch + SaleCondition, data = df)


## forward
null = lm(SalePrice ~ 1, data = df)
full = lm(SalePrice ~ ., data = df)
fw_reg = step(null, 
              scope = list(lower = null, upper = full),
              trace = 2,
              k = log(nrow(df)),
              direction = "forward")

## what are the variables
summary(fw_reg)

## variables
fw_reg$call

# lm(formula = SalePrice ~ OverallQual + GrLivArea + BsmtFinSF1 + 
#      ExterQual + Condition2 + MSSubClass + Neighborhood + BsmtExposure + 
#      LotArea + SaleCondition + KitchenQual + RoofMatl + GarageArea + 
#      YearRemodAdd + TotalBsmtSF + OverallCond + YearBuilt + ScreenPorch + 
#      MoSold + Fireplaces + GarageYrBlt + KitchenAbvGr + TotRmsAbvGrd + 
#      BedroomAbvGr + LotFrontage, data = df)


## stepwise (both)
null = lm(SalePrice ~ 1, data = df)
full = lm(SalePrice ~ ., data = df)
step_reg = step(null, 
              scope = list(lower = null, upper = full),
              trace = 2,
              k = log(nrow(df)),
              direction = "both")

## what are the variables
summary(step_reg)

## variables
step_reg$call

# lm(formula = SalePrice ~ OverallQual + GrLivArea + BsmtFinSF1 + 
#      ExterQual + Condition2 + MSSubClass + Neighborhood + BsmtExposure + 
#      LotArea + SaleCondition + KitchenQual + RoofMatl + GarageArea + 
#      TotalBsmtSF + OverallCond + YearBuilt + ScreenPorch + GarageYrBlt + 
#      KitchenAbvGr + TotRmsAbvGrd + BedroomAbvGr + MasVnrArea + 
#      LotFrontage, data = df)


## Create new variables?
## reduce levels?
levels(df$Neighborhood) ## let's combine levels
library(forcats)

df$Neighborhood = fct_collapse(df$Neighborhood,
                               NoRidge = c("NoRidge"),
                               NridgHt = c("NridgHt"),
                               StoneBr = c("StoneBr"),
                               other_level = "Other")
df$Neighborhood = relevel(df$Neighborhood, ref = "Other")

step_reg = lm(formula = SalePrice ~ OverallQual + GrLivArea + BsmtFinSF1 +
     ExterQual + Condition2 + MSSubClass + Neighborhood + BsmtExposure +
     LotArea + SaleCondition + KitchenQual + RoofMatl + GarageArea +
     TotalBsmtSF + OverallCond + YearBuilt + ScreenPorch + GarageYrBlt +
     KitchenAbvGr + TotRmsAbvGrd + BedroomAbvGr + MasVnrArea +
     LotFrontage, data = df)
summary(step_reg)

## now for Condition
df$Condition2 = fct_collapse(df$Condition2,
                              PosN = c("PosN"),
                              other_level = "Other")
df$Condition2 = relevel(df$Condition2, ref = "Other")

## run regression again
step_reg = lm(formula = SalePrice ~ OverallQual + GrLivArea + BsmtFinSF1 +
                ExterQual + Condition2 + MSSubClass + Neighborhood + BsmtExposure +
                LotArea + SaleCondition + KitchenQual + RoofMatl + GarageArea +
                TotalBsmtSF + OverallCond + YearBuilt + ScreenPorch + GarageYrBlt +
                KitchenAbvGr + TotRmsAbvGrd + BedroomAbvGr + MasVnrArea +
                LotFrontage, data = df)
summary(step_reg)

## want to do this for the rest of the cat predictors
### BsmtExposure, SaleCondition, RoofMatl


## STEP 3) MODEL BUILDING
#### your model will be as good as the variables
#### split your data into training/test
#### get candidate models (3-4 top models based adj-R2 training)
###### fit models

set.seed(1)
trainIndex = sample(1:nrow(df), round(0.5*nrow(df)))
df.train = df[trainIndex, ]
df.test = df[-trainIndex, ]

#### candidate 1: (step model we fit - first-order )
model1 = lm(formula = SalePrice ~ OverallQual + GrLivArea + BsmtFinSF1 +
              ExterQual + Condition2 + MSSubClass + Neighborhood + BsmtExposure +
              LotArea + SaleCondition + KitchenQual + RoofMatl + GarageArea +
              TotalBsmtSF + OverallCond + YearBuilt + ScreenPorch + GarageYrBlt +
              KitchenAbvGr + TotRmsAbvGrd + BedroomAbvGr + MasVnrArea +
              LotFrontage, data = df.train)
summary(model1)

#### is there an interaction, quadratic, cubic that can add predictive power
#### more art than science
plot(df.train$LotArea, df.train$SalePrice)
abline(lm(SalePrice ~ LotArea, data = df.train), col = "red")


model2 = lm(formula = SalePrice ~ OverallQual + GrLivArea + BsmtFinSF1 +
              ExterQual + Condition2 + MSSubClass + Neighborhood + BsmtExposure +
              LotArea + SaleCondition + KitchenQual + RoofMatl + GarageArea +
              TotalBsmtSF + OverallCond + YearBuilt + ScreenPorch + GarageYrBlt +
              KitchenAbvGr + TotRmsAbvGrd + BedroomAbvGr + MasVnrArea +
              LotFrontage + LotArea:Neighborhood, data = df.train)
summary(model2)


## STEP 4) MODEL EVALUATION
#### R2, RMSE, MAE, AIC, BIC

library(caret)
yhat1 = predict(model1, df.test) ## split the data 
## yhat1 = predict(model1, df.test) 

postResample(yhat2, df.test$SalePrice)

df$RoofMatl
