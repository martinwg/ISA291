## Interpretations of Categorical Predictors

### Life Insurance Data
## y = charges (medical costs with 10 years of application)
## x1 = age
## bmi = ratio of weight and weight

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/insurance.csv',
              stringsAsFactors = T)
head(df)

### check if encoding is correct
## numeric variables are true numeric values
## categoricals are true cat variables
## All variables are encoded correctly


### linearity
plot(df)
## should we fit a non-linear relationship?
## e.g. bmi vs charges
plot(df$bmi, df$charges)


## Interpretations for categoricals
## x = smoker
nlevels(df$smoker) ## 2 levels
levels(df$smoker)

## what is the ref level?
## ref is "no"
## that means we create a dummy variable for "yes"
## smokeryes = {0: else, 1: smoker}

reg1 = lm(charges ~ smoker, data = df)
summary(reg1)

## showing the dummy-encoded variables in the model matrix
head(model.matrix(reg1))
head(df[,c("smoker", "charges")])

## Intepret the meaning in the language of the problem
## of the y-intercept (8434.3)
## what does smokeryes = 0 mean (not a smoker)

## The estimated medical costs of a person who is NOT  a smoker 
## is 8434.3 

## Interpret the meaning of the slope (23616.0)
## This is the estimated difference in medical costs
## for smokers (+$23,616) compared to NON-SMOKERS (reference)

summary(reg1)
## Estimated medical costs of NON-SMOKERS: $8434.3
## Estimated DIFF in medical costs of SMOKERS compared to NON-SMOKERS: $23616.0
## Estimated medical costs of SMOKERS: $8434.3 + $23616.0 = 32050.3

## Hypothesis of smokeryes slope
### H0: B_smokeryes = 0 (there is no difference in costs between smokers and non-smokers)
### HA: B_smokeryes != 0 (there is a statistical diff)

## b1_smokeryes =  23616.0  (there is a diff of $23,616)
## t = b1_smokeryes / s_b1 =  46.66 (std errors away from zero)

## what is the prob that we get that t value (or larger)
## if H0 is true?
##  <2e-16 ***

## Conclusion: There is a statistical difference between smokers
## and non-smokers in medical costs


## Region
## number of levels: 4
## what is the ref? northeast
levels(df$region)

## how many dummy-vars are created for region?
## 1st dummy: for northwest
## 2nd dummy: for "southeast"
## 3rd dummy: for southwest

reg2 = lm(charges ~ region, data = df)
summary(reg2)

## estimated costs for northeast customers? 13406.4 
## (T or F): customers from southeast's estimated cost is 1329.0 (False)
## this is just the difference in cost
## which customers have the lowest estimated medical costs? southwest
## which customers have the highest estimated medical costs? southeast

## Is region an important variable?
## what if 1 level out of the 3 that is statistically significant? 
## Yes, if at least one dummy from the region variable is significant
## we consider the variable to bring some information.











