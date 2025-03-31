## Interactions Example
## Interaction Plots

## Insurance Data
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/insurance.csv',
              stringsAsFactors = T)
head(df)

## y = charges (medical costs of insurance applier in next 10 years)
## x1 = age (+)
## x2 = bmi (+)
## smoker = { no, yes} 

## Relationships
plot(df$age, df$charges)
abline(lm(charges ~ age, data = df), col = 'red')

plot(df$bmi, df$charges)
abline(lm(charges ~ bmi, data = df), col = 'red')

library(rgl)
library(car)
scatter3d(x = df$age, z = df$bmi, y = df$charges, groups = df$smoker) 


## Interaction Model 
## y = charges
## x1 = age
## x2 = bmi
## x3 = smoker
## x2x3 = bmi and smoker
## if bmi increases (two different slopes)

reg1 = lm(charges ~ age + bmi + smoker + bmi:smoker, data = df)
summary(reg1)

## Effect of Age?
## As Age Increases by 1 year, how does charges change?
## As age increases by 1 year, we estimate the 
## charges to increase by $267 holding the other vars constant


## Effect of BMI
## Effect (Equation): 7.109 + 1430.920*smokeryes
## smokeryes = {1, 0}

## for smokeryes = 0 (meaning a non-smoker)
## As bmi increases by 1, we estimate the medical costs
## to increase $7.109 controlling for other factors

## for smokeryes = 1 (meaning a smoker)
## As bmi increases by 1, we estimate the medical costs
## to increase $1438.029 controlling for other factors

## Interaction Plot
## is a plot of the variables interacting
## y = charges, x = bmi (plot two levels or different levels of x2 = smoker)
## y = charges, x = bmi (smokers) - SLOPE 1
## y = charges, x = bmi (non-smokers) - SLOPE 2
## ARE SLOPES PARALLEL? Yes - interaction not present, no - interaction present
## sjPlot (plot interactions)
library(sjPlot)
plot_model(reg1, type = "int")


## Age*BMI

reg2 = lm(charges ~ age + bmi + smoker + bmi:smoker + age*bmi, data = df)
summary(reg2)

## H0: age:bmi = 0
## HA: age:bmi ~= 0
## there is no enough evidence to suggest an interaction
## between age and bmi
## DROP THE INTERACTION
reg2 = lm(charges ~ age + bmi + smoker + bmi:smoker, data = df)
summary(reg2)



## POLYNOMIAL MODEL



