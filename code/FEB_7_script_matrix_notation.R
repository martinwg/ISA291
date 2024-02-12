## MATRIX NOTATION

## MATRICES AND VECTORS
A = matrix(c(7,6,1,4,4,1,-3,9,6), nrow = 3, ncol = 3)
A

## DIMENSION
dim(A)

## VECTORS (does not care if it's row or col vector)
x = c(3,2,7)

## TRANSPOSE 
## t()
t(A)

## TRANSPOSE of x
t(x)

## MATRIX B
B = matrix(c(2,2,-1,-1,4,2,4,1,5), ncol = 3)

## SUM A+B
A+B

## SCALAR MULTIPLICATION
2*B
B*2

## A
A

## x
x

## MATRIX MULTIPLICATION
A %*% x

## MATRIX MULTIPLICATION A B
A %*% B

## CREATE A
A = matrix(c(1,2,3,4,4,1,6,8,7), nrow = 3)
A

## DETERMINANT
## determinant is zero
det(A)


## B
B

## det
det(B)

B = matrix(c(2,2,-1,-1,4,2,4,4,-2.001), ncol = 3)
B

det(B)

## INVERSE MATRIX
## ALWAYS COMPUTED USING 1/det(A)*SOMETHINGELSE

## INVERSE OF MATRIX A
solve(A)



## INVERSE OF MATRIX B
solve(B)

## CREATE EXAMPLE USING MATRIX ALGEBRA
## WITH REGRESSION ANALYSIS

## DESIGN MATRIX
## MODEL MATRIX
## X
X = matrix(c(1,1,1,1,1,3,12,6,20,14, 6, 24, 12, 40, 28.0005 ), ncol = 3)
## y vector
y = c(50,45,55,15,15)

## ESTIMATES
## betahat = (X'X)^-1 (X'y)

solve(t(X) %*% X)  %*%  (t(X)%*%y)

## R Implementation
df = data.frame(x = c(3,12,6,20,14), y = c(50,45,55,15,15))
df

## lm
reg1 = lm(y ~ x, data = df)
summary(reg1)

## DESIGN MATRIX or MODEL MATRIX
model.matrix(reg1)
















