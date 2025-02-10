## Matrix Formulation of Regression

## var1 - GPA
## var2 - # internships
## var3 - starting sal

X = matrix(c(3.5, 1, 80, 4.0, 2, 84, 3.2, 3, 120), ncol = 3, byrow = T)
X

## dimension
dim(X)  ## rows cols

## vector (1 row or 1 col)
## R does not distinguish
z = c(3.5, 4.0, 3.2)

## Read Analyst Salary Data Set
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/Analyst_SalaryData.csv',
              stringsAsFactors = T)

## What would be the dimension of the X matrix if we want to predict Salary?
## y = Salary
## x1 = YearsExperience
## x2 = Age

## X matrix (Design or Model Matrix)
## 30 row and 3 cols
## 30 x 3

## y vector?
## 30 x 1

reg1 = lm(Salary ~ YearsExperience + Age, data = df)
summary(reg1)

## In the background, the lm function splits the data
X = model.matrix(reg1)
dim(X)

## y vector
y = reg1$model$Salary

## or y = df$Salary

## Let's get the transpose of X
## t() obtains the response
dim(X)

## transponse of X
t(X)
dim(t(X))

## scalar multiplication
2*X

## multiplying A*B
## cols of A = rows of B
## 3 x 3
A = matrix(c(3.5, 1, 80, 4.0, 2, 84, 3.2, 3, 120), ncol = 3, byrow = T)
A

## 2 x 3
B = matrix(c(5, 1, 2, 2, 1, 4), nrow = 2, byrow = T)
B

## is A*B conformable (good)? No
A %*% B

## is A*B' conformable (good)? Yes
## A(3x3) B'(3x2)
A %*% t(B)


## if det(A) = 0, then the cols of the matrix are NOT independent
## creates an issue
## if x1 = Degrees C, x2 = Degrees in F (det(X) = 0)
## x1 = GMAT, x2 = GRE (det(X) close to zero)
det(A)

## Inverse of a Matrix
## divide by det()
## if MATRIX is SINGULAR, we can't get the inverse
solve(A)

## To get estimates in regression
## Beta = (X'X)^-1 (X'y)
## (X'X)^-1 requires columns of X to be independent
## columns (variables) that are very related create issues

## dim 3x30   30x3  = 3 x 3
XTX = t(X) %*% X 
dim(XTX)
XTX

## inverse of XTX
XTXinv = solve(XTX)
XTXinv

## 3x30   30x1
## X'y
XTy = t(X) %*% y
XTy

## beta XTXinv * XTy
beta = XTXinv %*% XTy
beta

## df 
df$MonthsExp = df$YearsExperience * 12
df

reg2 = lm(Salary ~ YearsExperience + Age + MonthsExp, data = df,singular.ok = F)
summary(reg2)


## What if matrices are NOT exact linear combinations but they are correlated?

df$MonthsExp = df$YearsExperience * 12 + rnorm(30)
df


reg2 = lm(Salary ~ YearsExperience + Age + MonthsExp, data = df,singular.ok = F)
summary(reg2)
summary(reg1)


## when two or more predictors are very correlated,
## this creates multi-collinearity which results from 
## the inverse of the matrix being inflated 
## you can't trust the p-values
