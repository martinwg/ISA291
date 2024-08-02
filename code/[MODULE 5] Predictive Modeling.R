## AN EXAMPLE ON EXTRAPOLATION
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/nyc-east-river-bicycle-counts.csv', stringsAsFactors = T)
plot(df$High.Temp.F, df$Total)

## FIRST-ORDER MODEL
reg1 = lm(Total ~ High.Temp.F, data = df)
summary(reg1)

### scatterplot
plot(df$High.Temp.F, df$Total)
abline(reg1, col = 'red', lwd = 4)

### extrapolating the relationship
plot(df$High.Temp.F, df$Total, xlim = c(35, 140), ylim = c(4500, 45000))
abline(reg1, col = 'red', lwd = 4)

## SECOND-ORDER MODEL
reg2 = lm(Total ~ High.Temp.F + I(High.Temp.F^2), data = df)
summary(reg2)

### scatterplot
plot(df$High.Temp.F, df$Total)
temps = seq(35, 140, 0.1)
pred_temps2 = predict(reg2, data.frame(High.Temp.F = temps))
lines(temps, pred_temps2, col = "red", lwd = 4)

### extrapolating the relationship
plot(df$High.Temp.F, df$Total, xlim = c(35, 140), ylim = c(4500, 45000))
lines(temps, pred_temps2, col = "red", lwd = 4)

## THIRD-ORDER MODEL
reg3 = lm(Total ~ High.Temp.F + I(High.Temp.F^2) + I(High.Temp.F^3), data = df)
summary(reg3)

### scatterplot
plot(df$High.Temp.F, df$Total)
temps = seq(35, 140, 0.1)
pred_temps3 = predict(reg3, data.frame(High.Temp.F = temps))
lines(temps, pred_temps3, col = "red", lwd = 4)

### extrapolating the relationship
plot(df$High.Temp.F, df$Total, xlim = c(35, 140), ylim = c(4500, 45000))
lines(temps, pred_temps3, col = "red", lwd = 4)

## PLOTTING THE 3 MODELS AT THE SAME TIME
plot(df$High.Temp.F, df$Total, xlim = c(35, 140), ylim = c(4500, 45000))
## MODEL 1
abline(reg1, col = 'red', lwd = 4)
## MODEL 2
lines(temps, pred_temps2, col = "blue", lwd = 4)
## MODEL 3
lines(temps, pred_temps3, col = "green", lwd = 4)


## EXAMPLE ON PREDICTIVE MODELING
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/umbrellas.csv')
df

## RELATIONSHIP
plot(df$Rainfall, df$Umbrellas)

## STEPS TO TAKE
## After the data is clean (no missing values, incorrectly coded vars)
## 1) Split the data into training/test
set.seed(291) ## set a seed for replicability
trainIndex = sample(1:nrow(df), size = round(0.7*nrow(df)))
df_train = df[trainIndex, ]
df_test = df[-trainIndex, ]

## 2) Create Models on the training dataset
## model 1
reg1 = lm(Umbrellas ~ Rainfall, data = df_train)
summary(reg1)
abline(reg1, col = "red")

## model 2
reg2 = lm(Umbrellas ~ Rainfall +I(Rainfall^2), data = df_train)
summary(reg2)

## model 3
reg3 = lm(Umbrellas ~ Rainfall+ I(Rainfall^2)+I(Rainfall^3), data = df_train)
summary(reg3)

## 3) Check the Performance on a new data set for validation (Test Set)
## we first create true values
ytrue = df_test$Umbrellas
## and predicted values for each model
yhat = predict(reg1, df_test)

## then we calculate the performance metrics
## RMSE is sqrt(sum(y-yhat)^2)
RMSE_MODEL1 = sqrt(mean((ytrue - yhat)^2))
RMSE_MODEL1
## MAE is mean(|y-yhat|)
MAE_MODEL1 = mean(abs(ytrue - yhat))
MAE_MODEL1
## R2 = SSR/SST or 1 - (SSE/SST)
SSE = sum((ytrue - yhat)^2)
SST = sum((ytrue - mean(ytrue))^2)
R2_MODEL1 = 1 - (SSE/SST)
R2_MODEL1
## COMPLEXITY IS k
COMPLEXITY_MODEL1 = 1
## AIC = n*log(SSE/n)+2k
n = nrow(df_test)
k = COMPLEXITY_MODEL1
SSE = sum((ytrue - yhat)^2)
AIC_MODEL1 = n*log(SSE/n) + 2*k
AIC_MODEL1
## BIC = n*log(SSE/n)+log(n)k
BIC_MODEL1 = n*log(SSE/n) + log(n)*k
BIC_MODEL1

## automatic metric calculation
## not all metrics are available
library(caret)
## Let's do the performance metrics for all models
ytrue = df_test$Umbrellas
## model 1 predictions
yhat1 = predict(reg1, df_test)
## model 2 predictions
yhat2 = predict(reg2, df_test)
## model 3 predictions
yhat3 = predict(reg3, df_test)

## model 1 performance
postResample(ytrue, yhat1)
## model 2 performance
postResample(ytrue, yhat2)
## model 3 performance
postResample(ytrue, yhat3)













