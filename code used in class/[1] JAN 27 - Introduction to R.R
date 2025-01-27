## Introduction to R
## RScripts are files used to save R Code

## Creating Variables (Objects)
## You can use =, <-, ->
x = 5
y <- 10
15 -> z

## Case sensitive
X = 5.2

## Built-in Functions
## c() - concatenate values (vector)
## mean() - obtains avg of a vector
## sd() - standard deviation of a vector
## print() - print a value on screen (colab)
## hist() - creates a histogram of a vector (variables)
## plot() - creates different plots (e.g., scatter plots)
## lm() - creates a linear regression
## rnorm() - creates normal observation (mean = 0, sd = 1)

## vector (variable) of salaries
sal = c(64, 70, 55, 80)

## create normal observations (vector)
x = rnorm(500)

## mean
mean(sal)

## std deviation
sd(x)

## histogram
hist(x)

## get help
## built-in help() or ?hist
help(hist)
?rnorm


## Data Types
gpa = 3.6
class(gpa)

num_internships = 2
class(num_internships)

## character
x = "John"

## boolean
spring = T
class(spring)

## vector (concatenation of variables)
## concatenation can be of numeric, booleans, characters, 
gpa = c(3.2, 4.0, 3.5)
class(gpa)

## indexing
gpa[2]  ## retrieving 2nd object

gpa[-3]  ## retrieve everything except 3rd

gpa[1:2]  ## slice of objects

