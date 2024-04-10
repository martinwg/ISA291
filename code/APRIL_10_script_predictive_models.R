## PREDICTIVE MODELS
## Let's predict number of umbrellas sold using rainfall

## read data
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/umbrellas.csv')
df

## plot
plot(df$Rainfall, df$Umbrellas)

## DESCRIPTIVE MODEL
## What is the relationship between rainfall and # umbrellas sold?
reg1 = lm(Umbrellas ~ Rainfall, data = df)
summary(reg1)


## plot
plot(df$Rainfall, df$Umbrellas)
abline(reg1, col = "black", lwd = 2)

## 2nd order model
reg2 = lm(Umbrellas ~ Rainfall + I(Rainfall^2), data = df)
summary(reg2)
## as the rainfall increases by 1 inch, then the estimated number of 
## umbrellas sold will change by 1.470514 - 2*0.004251*Rainfall

## plot the quadratic relationship
f_rainfall = seq(0, 220, 1)
predictions = predict(reg2, data.frame(Rainfall = f_rainfall))
## plot
lines(f_rainfall, predictions, col = "red", lwd = 2)


## 3rd order
## stop there and go back to 2nd -order model
reg3 = lm(Umbrellas ~ Rainfall + I(Rainfall^2) + I(Rainfall^3), data = df)
summary(reg3)

## What happens with extrapolation
plot(df$Rainfall, df$Umbrellas, xlim = c(0, 220), ylim = c(0, 80))

lines(f_rainfall, predictions, col = "red", lwd = 2)

## EXTRAPOLATION
## Can severely limit the performance of a predictive model


## OVERFITTING
## Building model with either too few observations 
## oversampling and undersampling techniques should be used.
## When the models are too complex
## include too many predictor or too many higher-order terms


## SPLIT the data into training and test (validation)
## we want more data in the training set - build the models
## build multiple models on the training
## test data is ONLY to check the performance of the models

set.seed(291)
trainIndex = sample(1:nrow(df), round(0.7*nrow(df)) )
df.train = df[trainIndex, ]
df.test = df[-trainIndex, ]

## TRAINING SET
## this is where we build the model(s)

model1 = lm(Umbrellas ~ Rainfall, df.train)
summary(model1)

model2 = lm(Umbrellas ~ Rainfall + I(Rainfall^2), df.train)
summary(model2)

model3 = lm(Umbrellas ~ Rainfall + I(Rainfall^2) + I(Rainfall^3), df.train)
summary(model3)

## TEST SET
## only to check the models built on the training
## select the model that best performs on the test.

ASE_MODEL1 = sum(df.test$Umbrellas - predict(reg1, df.test))^2 / nrow(df.test)
## this is average squared error 
## packages like caret


