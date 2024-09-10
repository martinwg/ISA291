## The least-squares method
## Matrix notation

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/Analyst_SalaryData.csv',
              stringsAsFactors = T)

## Fit a regression
## y = Salary
## x = YearsExperience

reg1 = lm(Salary ~ YearsExperience, data = df)
summary(reg1) ## all statistics
reg1

## plot the regression (1 single predictor)
plot(df$YearsExperience, df$Salary)
abline(reg1, col = "red", lwd = 3)

## residuals
reg1$residuals

## anova table shows SSE
options(scipen = 999)
anova(reg1)

## What if we have two predictors
reg2 = lm(Salary ~ YearsExperience + Age, data = df)
summary(reg2)

## lm(Salary ~ YearsExperience, data)
y = df$Salary ## sets this as a vector
## predictors are put in a matrix
## [1 YearsExperience]
## the model matrix (design matrix)
model.matrix(reg1)

## Matrices 
## 3x3 dimension
A = matrix(c(3.5, 1, 80, 4.0,2, 84, 3.2, 3, 120), nrow = 3, byrow = T)
A

## dim obtains the dimension
dim(A)

## What is the dimension of X matrix (x = YearsExperience, y = Salary)?
## n X (p+1)
## answer: 30 x 2
dim(model.matrix(reg1))



## What is the dimension of X matrix 
## (x1 = YearsExperience, x2 = Age, y = Salary)?
## n X (p+1)
## answer: 30 x 3
dim(model.matrix(reg2))

## y vector
## dim nx1 
## What is the dimension of y vector
## answer:30x1

## Transpose of a matrix
## swaps rows and cols
A
## to get the transpose of A
t(A)

## What is the transpose of the X matrix
## x = YearsExperience
## y = Salary
model.matrix(reg1)

## transpose
t(model.matrix(reg1))


## matrix B
B = matrix(c(0, 0, 1, 0,0,1, 0,0, 1), ncol = 3, byrow = T)
B

## Add matrices A and B
A + B

## Subtract B from A
A - B

## matrix C (2x3)
C = matrix(c(0, 0, 1, 0,0,1), ncol = 3, byrow = T)
C

## Add A + C
A+C
## don't match (not conformable)

## Scalar multiplication
3*A

## for matrix multiplication
## cols of A MUST match rows of B
dim(A)  ## 3 x 3
dim(B)  ## 3 x 3

A %*% B  ## conformable (match)


## example 2
dim(A) ## 3 x 3
dim(C) ## 2 x 3

A %*% C

## example 3
dim(A)    ## 3 x 3
dim(t(C)) ## 3 x 2

A %*% t(C)

## matrices are DEPENDENT if columns are linear combinations of each
## other
## determinant of the matrix is zero for DEPENDENT
det(A) ## if det is NOT zero it is a good matrix

## matrix B
det(B) ## SINGULAR (det is zero): bad matrix

## inverse
## equivalent to 1/number 
## for matrices we divide by the determinant (if det is zero)
solve(A) ## gets inverse

## inverse for B not going to work (det is zero)
solve(B)

## matrix has to be square (rows = cols)
solve(C)

## the regression estimates are obtain ALL at the same time
## we use a single formulat
## estimates  = (X'X)^-1 (X'y)

## x = YearsExperience
## y = Salary
X = model.matrix(reg1)
y = df$Salary

## betahat
betahat = solve(t(X) %*% X)  %*%  (t(X) %*% y)
betahat


























