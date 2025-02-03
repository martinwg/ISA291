## Fitting a Regression Model in R

## Analyst Salary Data Set
salary = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/Analyst_SalaryData.csv',
                  stringsAsFactors = T)

## print 10 obs
head(salary, 10)

## Scatter Plot (Bivariate [2 vars] plot)
## plot(x, y)
plot(salary$YearsExperience, salary$Salary)


## print analysts Age < 22
salary[salary$Age < 22 , ]

## print analyst with Age < 24 and Years of Experience > 1.5
salary[salary$Age < 24 & salary$YearsExperience > 1.5 , ]

## print analysts with exactly 3 years of experience
salary[salary$YearsExperience == 3 , ]


### Fit a first-order (No squared values or higher-order)
## x = YearsExperience
## y = Salary
## Beta_0: When Years of Experience is zero, the (TRUE) expected salary
## Beta_1: As years of Experience increases by 1, the CHANGE in salary

## sample of size n = 30
## we can get
## b0: estimated y-int
## b1: estimated slope

model1 = lm(Salary ~ YearsExperience, data = salary) 
summary(model1)

## TRUE MODEL: Salary = Beta_0 + Beta_1 Experience + epsilon
## ESTIMATED MODEL: Estimated Salary = 25792.2 + 9450.0 * Experience


