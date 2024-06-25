## Intro to MLR
## Read NYC East River Bike Crossings
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/nyc-east-river-bicycle-counts.csv',
              stringsAsFactors = T)
head(df)

## Scatter plot matrix
plot(df)

## Use High Daily Temperature (F) and Low Daily Temperature (F) predictors
## Total (total number of crossings)


## Drop a Variable
df$Date = NULL

## Scatter plot
plot(df$High.Temp.F, df$Total)

## SLR
reg_ht = lm(Total ~ High.Temp.F, data = df)
summary(reg_ht)

## Scatter plot
plot(df$Low_Temp_F, df$Total)

## SLR
reg_lt = lm(Total ~Low_Temp_F, data = df)
summary(reg_lt)


## MLR
reg1 = lm(Total ~ High.Temp.F + Low_Temp_F, data = df)
summary(reg1)

## Scatter3D
library(rgl)
library(car)

scatter3d(Total ~ High.Temp.F+Low_Temp_F, data = df)


## In the language of the problem

#* As the daily high temperature increases by 1 degree 
#* Fahrenheit, we estimate the number of daily crossings 
#* to increase by 523.79 holding the low daily temperature 
#* constant. This would be a hard problem as high and low 
#* temperatures move together (are correlated).

#* As the daily low temperature increases by 1 degree Fahrenheit,
#*  we estimate the number of daily crossings to decrease by 218.96
#* for a constant high temperature.

## Correlation among predictor (collinear)
cor(df$High.Temp.F, df$Low_Temp_F)


## Assumptions
plot(reg1)


## Day against the residuals to check for assumption 4
plot(df$Day, reg1$residuals, type = "l", lty = 1, xlab = "Day", ylab = "Residuals")
abline(0,0, col = "red")



