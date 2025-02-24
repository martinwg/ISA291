## Multicollinearity

## Read the data
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/nyc-east-river-bicycle-counts.csv',
              stringsAsFactors = T)

## Drop (Delete)
df$Day = NULL  ## setting the variable to NULL you delete the var from df

## Select specific and overwrite the data
df = df[, c("High.Temp.F", "Low_Temp_F", "Total")]

## Print Obs
head(df)

## scatter plot matrix (visualize)
plot(df)

## Reg
reg = lm(Total ~ High.Temp.F + Low_Temp_F, data = df)
summary(reg)
anova(reg)

## 3D Plot (car, rgl packages)
## only if you have 2 predictors
library(car)
library(rgl)
scatter3d(Total ~ High.Temp.F + Low_Temp_F, data = df)

## Multi-Collinearity
## means when two OR more predictors are very correlated
## if cor(x1, x2) > |0.9|
cor(df$High.Temp.F, df$Low_Temp_F)


## Perfect (EXTREME) multi-collinearity 
## Happens with dummy-encoded 
df$High.Temp.C = (df$High.Temp.F - 32) / 1.8
head(df)

## correlations
cor(df) ## correlation matrix

## Create a model now (x1, x2, x3)
reg = lm(Total ~ High.Temp.F + Low_Temp_F + High.Temp.C, data = df, singular.ok = F)
summary(reg)
anova(reg)
## NA (undefined) estimates can be because of perfect multicollinearity
## it can also be because n is extremely low (n < p)

## Singular matrix is one where two or more columns are DEPENDENT


## In the background (any software) is trying to compute b = (X'X)^-1 (X'y)
X = model.matrix(reg)

XTX = t(X) %*% X 
## diagonals of XTX are the variances of each variable
## off-diagonals are the co-variance (how they vary together)

det(XTX) ## determinant = 0 or close to zero in UNITS
## this determinant is TOO CLOSE TO ZERO IN THESE UNITS

## INVERSE DOES NOT EXIST
solve(XTX)

## Delete the High.Temp.C
df$High.Temp.C = NULL
head(df)

## Reg
reg = lm(Total ~ High.Temp.F + Low_Temp_F, data = df)
summary(reg)
anova(reg)

## by how much are the standard errors of the estimates inflated?
library(car)
vif(reg) ## the var estimate of high is 3.11 times inflated

## Creates a reg:
## lm(High.Temp.F ~ Low_Temp_C, data = df)
## gets R2
## vif_high = 1 / (1-R2)
## vif larger than 10 indicates severe multicollinearity
lt_reg = lm(Low_Temp_F~High.Temp.F, data = df)
summary(lt_reg) ## gets 0.6787
vif_low = 1 / (1 - 0.6787)
vif_low


## Very correlated variable (not perfect)
df$High.Temp.C = (df$High.Temp.F - 32) / 1.8 + rnorm(210, mean = 0, sd = 0.1)
head(df)
 
cor(df$High.Temp.F, df$High.Temp.C)


## hopefully NO NAs
reg = lm(Total ~ High.Temp.F + Low_Temp_F + High.Temp.C, data = df, singular.ok = F)
summary(reg)
anova(reg)

## variance inflation factors
vif(reg)

## too inflated std errors of estimates
## t = b1 / s_b1 
## t is lower than what it should be because s_b1 is inflated

## Higher-order models contain multi-collinearity
## high_temp + high_temp^2 + high_temp^3
## we expect some p-values to not be significant
## even if the variable is important
## we are going to keep variables in the model that are NOT significant

