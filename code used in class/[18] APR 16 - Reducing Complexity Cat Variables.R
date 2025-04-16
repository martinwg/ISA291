## Model Complexity
#### Focus on reducing model complexity

## Example 1) insurance.csv

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/insurance.csv',
              stringsAsFactors = T)
head(df)


#### What are the total model df if we use ALL predictors?
#### y = charges
#### x1 = age (1 model df)
#### x2 = sex (1 model df)
#### x3 = children ( 1 model df)
#### x4 = bmi (1 model df)
#### x5 = smoker (1 model df)
#### x6 = region (3 model df)

#### total (k) = 8 model df --- complexity (7 axes)

#### ERROR DF
#### How many obs you have left to fill the dimensional space (for a better plane)
#### n - (k+1)
#### 1338 - 9 = 1329

options(scipen = 999)
reg1 = lm(charges ~ ., data = df)  ## . means all variables
summary(reg1)
anova(reg1)


## F-statistic: 500.8 on 8 and 1329 DF
## shows model and error df

#### PREDICTIONS (PREDICTIVE MODEL)
## is complexity in check?
## are we overfitting the data.
## this can get out of hand when you include higher-order terms

###

options(scipen = 999)
reg2 = lm(charges ~ . + I(bmi^2) + I(bmi^3) + I(bmi^4) + bmi:smoker
          + I(age^2), data = df)  ## . means all variables
summary(reg2)
anova(reg2)

### we are NOT sure of overfitting
### but the higher k the most likely the model is overfitting

#### PREDICTIVE MODELS
###### we want to estimate the model performance in NEW unseen data
###### got new insurance data 
###### and we used this model reg2 
###### if model performance is NOT good on the new data (overfitting)
###### We can split data into (train / test) 
###### build the model on train
###### predict the test and check the performance


### reg1 (first-order)
summary(reg1)

## can we combine some levels so that region has fewer df?
## Yes
## regionnorthwest is NOT statistically different than the ref (regionnortheast)
## combine (northwest with northeast)

#### forcats (for categoricals)
install.packages('forcats')
library(forcats)

## north variable
df$region = fct_collapse(df$region,
  north = c('northeast', 'northwest'),
  southeast = c('southeast'),
  southwest = c('southwest')
)


options(scipen = 999)
reg1 = lm(charges ~ . - sex, data = df)  ## . means all variables
summary(reg1)
anova(reg1)


#### housing_ames.csv
#### price of homes

#### BEFORE ANY MODELS, we need data manipulation
#### get variables ready for analysis
#### reducing the dimensions
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/housing_ames.csv',
              stringsAsFactors = T)
head(df)

reg1 = lm(SalePrice ~ ., data = df)
summary(reg1)

#### RoofMatl
levels(df$RoofMatl)

#### reg
reg_roof = lm(SalePrice ~ RoofMatl, data =df)
summary(reg_roof)

## combine ALL MATERIALS (other)
## just leave the WdShngl 
df$RoofMatl = fct_collapse(df$RoofMatl,
                           WoodShingles = c('WdShngl'),
                           other_level = "Other")
df$RoofMatl = relevel(df$RoofMatl, ref = "Other")



#### reg
reg_roof = lm(SalePrice ~ RoofMatl, data =df)
summary(reg_roof)