## let's use the clean data
df = read.csv("https://raw.githubusercontent.com/martinwg/ISA291/main/data/insurance.csv", stringsAsFactors = T)
head(df)

## Scatter Plot
plot(df$bmi, df$charges, main = "Scatter plot of BMI vs Medical Costs")

## First-Order Model
reg1 = lm(charges ~ bmi, data = df)
summary(reg1)

## First-Order Model Plot
plot(df$bmi, df$charges, main = "Scatter plot of BMI vs Medical Costs")
abline(lm(charges ~ bmi, data = df), col = "red", lwd = 4)

## Second-Order Model
reg2 = lm(charges ~ bmi + I(bmi^2), data = df)
summary(reg2)

## Second-Order Model Plot
plot(df$bmi, df$charges, main = "Scatter plot of BMI vs Medical Costs")
## create some bmi values
bmi_values = seq(10,60, 0.1)
## let's predict the bmi values
bmi_predictions = predict(reg2, data.frame(bmi = bmi_values))
## add the curve plot
lines(bmi_values, bmi_predictions, col = "red", lwd = 4)

## Interpretation
## The effect: 813.975 + 2*-6.662*bmi
## As BMI increases by 1 unit, we estimate the change in the charges
## to be EFFECT holding other variables constant

## For a person with a BMI of 20
## As BMI increases by 1 unit (20 to 21), we estimate the charges
## to increase by 547.495 holding other variables constant

## For a person with a BMI of 50
## As BMI increases by 1 unit (50 to 51), we estimate the charges
## to increase by 147.775 holding other variables constant


## Third-Order Model
reg3 = lm(charges ~ bmi + I(bmi^2) + I(bmi^3), data = df)
summary(reg3)

## Third-Order Model Plot
plot(df$bmi, df$charges, main = "Scatter plot of BMI vs Medical Costs")
## create some bmi values
bmi_values = seq(10,60, 0.1)
## let's predict the bmi values
bmi_predictions = predict(reg3, data.frame(bmi = bmi_values))
## add the curve plot
lines(bmi_values, bmi_predictions, col = "red", lwd = 4)

## Interpretation
## The effect: -1858.8972 + 2*78.4798*bmi + 3*-0.8727*bmi^2
## As BMI increases by 1 unit, we estimate the charges
## to change by the EFFECT holding other variables constant

## For a person with a BMI of 20
## As BMI increases by 1 unit (20 to 21), we estimate the charges
## to increase by 233.0548 holding other variables constant

## For a person with a BMI of 50
## As BMI increases by 1 unit (50 to 51), we estimate the charges
## to decrease by 556.1672 holding other variables constant


plot(df$bmi, df$charges, main = "Scatter plot of BMI vs Medical Costs")

## SMOKERS MODEL
smoker_model = lm(charges ~  bmi + I(bmi^2), data = df[df$smoker == "yes", ])
## create some bmi values
bmi_values = seq(10,60, 0.1)
## let's predict the bmi values
bmi_predictions = predict(smoker_model, data.frame(bmi = bmi_values))
## add the curve plot
lines(bmi_values, bmi_predictions, col = "red", lwd = 4)

## NON-SMOKERS MODEL
nonsmoker_model = lm(charges ~  bmi + I(bmi^2), data = df[df$smoker == "no", ])
## create some bmi values
bmi_values = seq(10,60, 0.1)
## let's predict the bmi values
bmi_predictions = predict(nonsmoker_model, data.frame(bmi = bmi_values))
## add the curve plot
lines(bmi_values, bmi_predictions, col = "blue", lwd = 4)


## higher-order model
options(scipen =99)
final_reg = lm(charges ~  age + bmi + smoker + bmi:smoker + I(bmi^2), 
               data = df)
summary(final_reg)

## Interpretations
#* age: as age increases by 1 year, we estimate the charges 
#* to increase by $264.969 holding other variables constant. 

#* bmi: 
#  1) we calculate the effect as: 547.337-2*8.571*bmi + 1433.909 *smokeryes
#  We can then interpret the effect with examples, i.e., 
#  for a smoker with a BMI of 40, as the BMI increases by 1 (from 40 to 41) 
#  the estimated charges increase by $1295.566 
#  holding other variables constant.

# smoker: 
# The effect is calculated as: -20159.430 + 1433.909*bmi. 
# Giving an example, a smoker with a BMI of 30 is estimated 
# to incur medical charges of $22857.84 more than a non-smoker 
# with the same BMI.


