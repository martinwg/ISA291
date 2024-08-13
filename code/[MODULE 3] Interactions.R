## INTERACTIONS
## insurance_raw.csv dataset

## READ DATA
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/insurance_raw.csv',
              stringsAsFactors = T)

## Change the charges to numeric
## removes $
## removes ,
## change to numeric
library(dplyr)
df$charges = df$charges %>% gsub("\\$", "", .) %>% gsub(",", "", .) %>% as.numeric()


## INTERACTIONS
plot(df$bmi, df$charges)
abline(lm(charges ~ bmi, data = df), col = "red")

## Regression
reg1 = lm(charges ~ age + bmi + smoker, data = df)
summary(reg1)

## smokeryes = {0: not, 1: yes}
reg2 = lm(charges ~ age + bmi + smoker + bmi:smoker, data = df)
summary(reg2)

## Slope of BMI for non-smokers
## Slope of BMI for smokers
plot(df$bmi, df$charges)
abline(lm(charges ~ bmi, data = df[df$smoker == "no", ]), col = "blue", lwd = 3)
abline(lm(charges ~ bmi, data = df[df$smoker == "yes", ]), col = "red", lwd = 3)

## What is the effect of BMI on the charges?
#* As BMI increases by 1 unit, then we estimate the charges
#* to change by 7.109 + 1430.920*smokeryes
#* For non-smokers, As BMI increases by 1 unit, then we estimate 
#* the charges to increase by $7.109 holding other vars constant
#* For smokers, As BMI increases by 1 unit, then we estimate
#* the charges to increase by $1438.029 holding other vars constant


## bmi:age
reg3 = lm(charges ~ age + bmi + smoker + bmi:age, data = df)
summary(reg3)

## Plotting interactions
## install.packages('sjPlot')
library(sjPlot)
reg2 = lm(charges ~ age + bmi + smoker + bmi:smoker, data = df)
summary(reg2)

reg3 = lm(charges ~  bmi + age + smoker + bmi:age, data = df)
summary(reg3)
plot_model(reg3, type = "int")








