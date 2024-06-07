## MATRIX NOTATION

## let's create matrix X
X = matrix(c(3.5, 4.0, 3.2, 1,2,3, 80, 84, 120), nrow = 3) ## we can specify nrow = 3 as well
print(X)

## matrix dimension
dim(X)



## create the vector x = [3.5, 4.0 , 3.2]
x = c(3.5, 4.0 , 3.2)
print(x)


# Original X matrix
X

# transposed X matrix
t(X)

## Matrix Addition / Subtraction
X

## suppose we need to add 12 credit hours to our matrix X
C = matrix(c(0, 0, 0, 0, 0 , 0, 12, 12, 12), ncol = 3)
print(C)

## addition
R = X - C
print(R)

## scalar multiplication
2*X

## matrix multiplication
## suppose we have matrix A
A = matrix(c(7,6,1,4,4,1,-3,9,6), nrow = 3, ncol = 3)
print(A)

## matrix B
B = matrix(c(2,2,-1,-1,4,2,4,1,5), ncol = 3)
print(B)

## matrix C
C = matrix(c(1,2,3,4,5,6,7,8,9,10, 11,12), ncol = 3)
print(C)

## vector x
x = c(3,2,7)

## A * B
A %*% B

## A(3x3) * C (4x3)
A %*% C

## C (4x3) * A(3x3)
C %*% A

## C (4x3) * x (3x1)
C %*% x


## Independent matrices
X = matrix(c(3.5, 4.0, 3.2, 1,2,3, 80, 84, 120), nrow = 3) ## we can specify nrow = 3 as well
print(X)
det(X) ## independent

A = matrix(c(1,2,3,4,4,1,6,8,7), ncol = 3)
print(A)
det(A) ## singular / dependent

C = matrix(c(7,6,1,4,4,1,-3,9,6), nrow = 3, ncol = 3)
print(C)
det(C) ## independent

C = matrix(c(1,2,3,4,5,6,7,8,9,10, 11,12), ncol = 3)
print(C)

## matrix inverse
## conditions: square and independent
solve(X) %*% X

solve(A)

solve(C)


## Matrix Formulation of Regresssion

## suppose we have 1 predictor
x1 = c(3,12,6,20,14)
y = c(50, 45, 55, 15, 15)

## let's create the design matrix
X = matrix(c(1,1,1,1,1,3,12,6,20,14), ncol = 2)

beta_estimates = solve(t(X) %*% X) %*% (t(X) %*% y)
print(beta_estimates)

## using lm function
reg1 = lm(y ~ x1)
summary(reg1)


## suppose we have 2 predictors
x1 = c(3,12,6,20,14)
x2 = c(21, 18, 33, 7, 7)
y = c(50, 45, 55, 15, 15)

## let's create the design matrix
X = matrix(c(1,1,1,1,1, 3,12,6,20,14, 21, 18, 33, 7, 7), ncol = 3)

beta_estimates = solve(t(X) %*% X) %*% (t(X) %*% y)
print(beta_estimates)

## using lm function
reg2 = lm(y ~ x1 + x2)
summary(reg2)

## suppose we have 3 predictors
## one is a linear combination
x1 = c(3,12,6,20,14)
x2 = c(21, 18, 33, 7, 7)
x3 = x1*3

y = c(50, 45, 55, 15, 15)

## let's create the design matrix
X = matrix(c(1,1,1,1,1, 3,12,6,20,14, 21, 18, 33, 7, 7, 9, 36, 18, 60, 42), ncol = 4)

beta_estimates = solve(t(X) %*% X) %*% (t(X) %*% y)
print(beta_estimates)

## using lm function
## the function works but produces NA values
reg3 = lm(y ~ x1 + x2 + x3)
summary(reg3)

## design/model matrix
model.matrix(reg3)








