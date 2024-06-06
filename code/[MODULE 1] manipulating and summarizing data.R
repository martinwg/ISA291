## READ CARS DATA SET
CARS = read.csv('cardata.csv', stringsAsFactors = T)

## PRINT SOME OBS
head(CARS)

## CHECK VARIABLE TYPES
str(CARS)

## SELECTING 1 VARIABLE 
CARS[,10] 
CARS$wheelbase
CARS[,'wheelbase']

### installing packages
## dplyr
## install.packages('dplyr')

### loading packages
library(dplyr)
CARS %>% select(wheelbase)

## SELECTING MULTIPLE VARIABLES
CARS[,c(10,11)]
CARS[,c('wheelbase','carlength')]
CARS %>% select(wheelbase, carlength)

## PLOTS
## summary of ALL variables
summary(CARS)
## summary of 1 variable
summary(CARS$CarName)

## histogram
## 1 single numeric variable
hist(CARS$price, col = "red", breaks = 20, main = "Histogram of Prices")

## boxplot
## 1  single numeric variable
boxplot(CARS$price, col = "red", horizontal = T, main = "Boxplot of Prices")

## bar chart
## 1 single categorical variable
barplot(table(CARS$fueltype))

## pie chart
## 1 single categorical variable
pie(table(CARS$fueltype))

## scatterplot
## relationship between 2 numeric
## plot(x, y)
plot(CARS$wheelbase, CARS$price)

## multiple box plots
## relationship between 1 categorical (x) and 1 numeric (1)
## plot(x, y)
plot(CARS$drivewheel, CARS$price)






