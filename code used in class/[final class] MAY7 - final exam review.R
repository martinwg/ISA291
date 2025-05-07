## Final Exam Review

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/HR_Analytics.csv',
              stringsAsFactors = T)
head(df)

## 1ST PART

#### interpretation of slopes
#### interpretation of the t-stat
#### SST = SSR + SSE
#### Total Variation = Explained Variation + Unexplained Variation
#### interpret RMSE (estimated error)
#### F-statistic 
#### R2
#### Estimated least-squares model
#### Population model


## example 1:
reg1 = lm(EmpSatisfaction~SpecialProjectsCount, data = df)
summary(reg1)
anova(reg1)


## 1) Estimated error of the model
#### RMSE
#### 9.607

## 2) Interpret the y-intercept
## estimated satisfaction when number of special projects is zero

## 3) SSE?   sum((sat - pred)^2)
## 28427.9

## 4) estimated variance of the errors of the model
#### MSE = SSE / n - (k+1)
#### 92.299 

## 5) interpretation of slope for special project counts
## if the special project counts increases by 1,
## the satisfaction IS ESTIMATED TO increase by 0.1896

## 6) What % of variaton in satisfaction scores is estimated by this model?
## 0.00184

## 7) statistically significant?
## no

## model 2 example
reg2 = lm(EmpSatisfaction ~ PayRate + SpecialProjectsCount, data = df)
summary(reg2)
anova(reg2)

### 2ND PART
#### interpretations: 
#### categorical predictors (compare against the reference)
#### quadratic terms (a) compute effect (b) giving example
#### interactions terms (a) compute effect (c) giving example
#### complexity = model df (cat: # levels - 1, num: 1)
#### multicollinearity: when two or predictors are too correlated
#### if VIF > 10, x1 (VIF: 12), x2 (VIF: 2), x3 (VIF: 12.4)
#### this indicates the presence of severe multi-collinearity
#### causes the std errors to be inflated (greater )

## example 3
reg3 = lm(EmpSatisfaction ~ PayRate 
          + SpecialProjectsCount 
          + PerformanceScore + I(PayRate^2), data = df)
summary(reg3)

## interpret Performance Score Variable

df$PerformanceScore = relevel(df$PerformanceScore, ref = "PIP")

## Effect of Payrate
#### a)  0.1824165+2*-0.0009066*Payrate




