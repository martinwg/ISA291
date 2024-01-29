## Script for introduction to R

# create a variable
x = 2.1
y = 2
name = "David"

## Assignment operator
x1 = 3.21
x1 <- 3.21
3.21 -> x1

## Histogram
set.seed(291)
x = rnorm(100)
hist(x)

## Help
help(hist)

## Case sensitive
hist(x)
Hist(x) ## Hist is NOT a function


## Basic Operations
x1 = 200
x2 = 150

x1+x2
x1^2
x1/x2

## Built-in Functions
x = c(1, 5, 8, 9)  # concatenate
mean(x) # average
sd(x) # std deviation
var(x) # variance
print('ISA 291')
print(x)

## Variable Types
x = 2.1
class(x)

name = "Peter"
class(name)

student = T
class(student)

student = TRUE
class(student)

## vectors
gpa = c(3.4, 3.9, 4.0, 2.9, 3.2, 3.4)

## indexing
gpa[3] ## student #3
gpa[-3]  ## every student except # 3
gpa[2:5]  ## slice from student 2 to 5

## Matrices
A = matrix(c(-2, 5, 6, 5, 2, 7), ncol = 3, nrow = 2, byrow = T)
A
## select #6
A[1, 3]
## select all second column
A[, 2]

## DataFrame
df = data.frame(sal = c(54, 64, 67, 70),
                exp = c(1,2,3,4),
                class = c("FR", "SO", "JR", "SR"))
class(df)
df

## hist
hist(df[,1])
hist(df$sal)

## Select only the first two columns
df[, 1:2]









