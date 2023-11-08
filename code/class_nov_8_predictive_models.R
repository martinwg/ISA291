## Predictive Modeling
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/umbrellas.csv')

## Print some obs
head(df)

## Check for Missing Values
colSums(is.na(df))

## Descriptive Modeling
## We use these models to describe the relationships between predictors
## and response
## We check model adequacy metrics like R2, adj-R2, p-values, F-statistic (goodness of fit)
reg1 = lm(Umbrellas ~ Rainfall, data = df)
summary(reg1)
anova(reg1)
## assumptions check
plot(reg1)
## given the assumptions, a higher-order model might perform better
plot(df$Rainfall, df$Umbrellas)

## Quadratic Model
reg2 = lm(Umbrellas ~ Rainfall + I(Rainfall^2), data = df)
summary(reg2)
anova(reg2)

## The relationship is non-linear
## The effect 1.470514 + 2*-0.004251 *Rainfall

## Plot the NON-LINEAR relationship
fake_rainfall = seq(80, 180, 0.1)
predicted_umbrellas = predict(reg2, data.frame(Rainfall = fake_rainfall))

## scatter plot with original
## add the fake rainfall with the predicted rainfall
plot(df$Rainfall, df$Umbrellas)
lines(fake_rainfall, predicted_umbrellas, col = "red", lwd = 4)

## As the rainfall increases from 80 to 81 inches, then
## the effect (change)  is 0.790354, meaning the number of umbrellas
## sold increases by 0.79


## As the rainfall increases from 160 to 161 inches, then
## the effect (change)  is 0.110194, meaning the number of umbrellas
## sold increases by 0.110194

## EXTRAPOLATION
## What happens at higher rainfall 200
predict(reg2, data.frame(Rainfall = 200))

plot(df$Rainfall, df$Umbrellas, xlim = c(80,300), ylim = c(-20, 70))
fake_rainfall = seq(80, 300, 0.1)
predicted_umbrellas = predict(reg2, data.frame(Rainfall = fake_rainfall))
lines(fake_rainfall, predicted_umbrellas, col = "red", lwd = 4)


## 3rd Model
reg3 = lm(Umbrellas ~ Rainfall + I(Rainfall^2) + I(Rainfall^3) + I(Rainfall^4), data = df)
summary(reg3)
anova(reg3)

plot(df$Rainfall, df$Umbrellas, xlim = c(80,300), ylim = c(13, 100))
fake_rainfall = seq(80, 300, 0.1)
predicted_umbrellas = predict(reg3, data.frame(Rainfall = fake_rainfall))
lines(fake_rainfall, predicted_umbrellas, col = "red", lwd = 4)



## PREDICTIVE MODEL
## Goal: predict accurately NEW data
## R2, Adj-R2, F pvals, t-statistics (goodness of fit) are less important
## NEW data predictions matter the most
## How do we get new data?
## DATA -- SPLIT (train/test)

## split into train and test
## set a seed (replicating a random split)
set.seed(291)
## random obs for the train (70%), test (30%)
trainIndex = sample(1:nrow(df), size = round(0.7*nrow(df)), replace = FALSE)
trainIndex  ## obs selected for training dataset

## create training and test
df.train = df[trainIndex, ]
df.test = df[-trainIndex, ]


## Let's Build 3 models
## 1) First-Order Model
reg1 = lm(Umbrellas ~ Rainfall, data = df.train)
summary(reg1)
anova(reg1)

## Check the performance on TEST
## calculate R2, ASE, RASE validation
## similar to R2, MSE, RMSE

## ASE sum(y - yhat)^2 / nobs
ASE_MODEL1 = sum((df.test$Umbrellas - predict(reg1, df.test))^2) / nrow(df.test)
RASE_MODEL1 = sqrt(ASE_MODEL1)

## R2 = SSR/SST
## R2 = 1 - SSE/SST
R2_MODEL1 = 1 - (sum((df.test$Umbrellas - predict(reg1, df.test))^2) / 
                   sum((df.test$Umbrellas - mean(df.test$Umbrellas))^2))




## 2) Second-Order Model
reg2 = lm(Umbrellas ~ Rainfall + I(Rainfall^2), data = df.train)
summary(reg2)
anova(reg2)

## Check the performance on TEST
## calculate R2, ASE, RASE validation
## similar to R2, MSE, RMSE

## ASE sum(y - yhat)^2 / nobs
ASE_MODEL2 = sum((df.test$Umbrellas - predict(reg2, df.test))^2) / nrow(df.test)
RASE_MODEL2 = sqrt(ASE_MODEL2)

## R2 = SSR/SST
## R2 = 1 - SSE/SST
R2_MODEL2 = 1 - (sum((df.test$Umbrellas - predict(reg2, df.test))^2) / 
                   sum((df.test$Umbrellas - mean(df.test$Umbrellas))^2))


## 3) Third-Order Model
reg3 = lm(Umbrellas ~ Rainfall + I(Rainfall^2) + I(Rainfall^3), data = df.train)
summary(reg3)
anova(reg3)

## Check the performance on TEST
## calculate R2, ASE, RASE validation
## similar to R2, MSE, RMSE

## ASE sum(y - yhat)^2 / nobs
ASE_MODEL3 = sum((df.test$Umbrellas - predict(reg3, df.test))^2) / nrow(df.test)
RASE_MODEL3 = sqrt(ASE_MODEL3)

## R2 = SSR/SST
## R2 = 1 - SSE/SST
R2_MODEL3 = 1 - (sum((df.test$Umbrellas - predict(reg3, df.test))^2) / 
                   sum((df.test$Umbrellas - mean(df.test$Umbrellas))^2))

## Select that has the best statistics on the TEST data
## regardless of statistics (p-values, R2)


