## Interpretations of Logistic Regression Estimates

## Read Heart Disease Dataset
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/heart_disease.csv',
              stringsAsFactors = T)

head(df)
## Goal: Probability of Developing Heart Disease (in 10 years)

## 1) MISSING VALUES
colSums(is.na(df))

#### a) for numeric variables
#### impute with MEAN or MEDIAN - MICE -
df$cigsPerDay[is.na(df$cigsPerDay)] = mean(df$cigsPerDay, na.rm = T)
df$BPMeds[is.na(df$BPMeds)] = mean(df$BPMeds, na.rm = T)
df$totChol[is.na(df$totChol)] = mean(df$totChol, na.rm = T)
df$BMI[is.na(df$BMI)] = mean(df$BMI, na.rm = T)
df$heartRate[is.na(df$heartRate)] = mean(df$heartRate, na.rm = T)
df$glucose[is.na(df$glucose)] = mean(df$glucose, na.rm = T)

#### b) for categorical variables
#### impute with the MODE
#### if encoded as categorical R automatically uses MISSING as a level (no need to do anything)
df$education = as.factor(df$education) ## now, no need to impute

## 2) PREDICTIVE MODEL (need an estimate of the error in NEW DATA)
#### SPLIT into training/test
set.seed(101)
trainIndex = sample(1:nrow(df), round(0.8*nrow(df)))
df.train = df[trainIndex,]
df.test = df[-trainIndex,]

## 3) MODELING
#### y = {0: did not develop HD, 1: developed HD}

#### 1) first-order model with ALL variables
reg1 = glm(TenYearCHD ~ ., data = df.train, family = "binomial")
summary(reg1)

#### The signs (slopes) tell you the type of relationship
##### a) cigsPerDay  sign + 
##### The higher the cigsPerDay, the higher the probability
##### to develop H.D. in 10 years - controlling for other factors. 
##### This is statistically significant

##### b) Intepret the estimate for cigsPerDay in the language of the problem
##### X not for the probability
##### Log(odds)
###### As the number of cigs per day increases by 1,
###### we estimate the log(odds) of developing H.D to increase by 0.0220441
###### controlling for other factors.

##### Odds
##### As the number of cigs per day increases by 1,
##### we estimate the odds of developing H.D. to CHANGE BY A FACTOR OF
##### 1.022289 holding the other vars constant

##### Odds
##### As BMI increases by 1 unit, 
##### we estimate the odds of developing H.D. to CHANGE BY A FACTOR OF 
##### 0.9930311 holding the other vars constant

#### Selecting only SIGNIFICANT predictors











