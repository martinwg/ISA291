## Introduction to R
## RScripts are files where we save R code
## THIS IS NOT THE FILE FOR HOMEWORK ASSIGNMENTS

## Creating variables
## Assignment operator = or <- or ->  
x = 5
y <- 10
15 -> z

## Read data
## analyst_data = read.csv()
## analyst_data <- read.csv()

## CONSOLE
## clear the console: CTRL + L or CMD + L

## TYPES OF VARIABLES
n_students = 35
class(n_students)  ## class checks the type of var

avg_gpa = 3.4
class(avg_gpa)

# strings are characters in R
course = 'ISA 291'
class(course)
## for vars we want to change characters to factor

## Booleans (TRUE or FALSE)
## Calls these vars logical
## T or F
summer = T
class(summer)
Fall = TRUE
Spring = F
class(Spring)

## PLOTS PANEL
?rnorm
normal_vars = rnorm(100)
hist(normal_vars)  ## hist obtains a histogram

## Basic Operations
x1 = 10
x1^3 + 20

## Normal Obs
y = rnorm(1000) ## TRUE MEAN (MU = 0)

## sample mean
mean(y)

## sample std dev ## TRUE SD (SIGMA = 1)
sd(y)

## VECTORS ARE MATRICES WITH 1 COLUMN OR 1 ROW
gpa = c(3.2, 4.0, 3.5, 3.7)

## what is the GPA of the 3rd student?
gpa[3]

## what are the gpas of the first 3 students?
## taking a slice of a vector
gpa[1:3]

## what are gpas except for student 3?
gpa[-3]

## MATRIX (has columns and rows)

A = matrix(c(-2,5,6,5,2,7), nrow = 2, ncol = 3, byrow = T)
print(A)

## Select only the first row?
A[1 , ]

## Select second column?
A[ , 2]






