## Data Structures
#### Reading data (.csv, .txt)

## Matrices
A = matrix(c(-2, 5, 6, 5, 2, 7), nrow = 2, byrow = T)   
class(A)

## Indexing (double) [rows, columns]
A[,1] ## prints 1st column
A ## whole matrix
A[2,] ## second row
A[3,]

## DataFrames
#### Same as matrices, but allow for different types

df = data.frame(
  sal = c(56,64,67,70),
  exp = c(1,2,3,4),
  class = c("FR", "SO", "JR", "SR")
)

## Histogram of salary
#### index col = 1
print(df)

hist(df[,1])
hist(df$sal) ## $ retrieves 1 column

#### mean, median, (summary)
summary(df$sal)

## Reading Data into R
#### 1) github link
#### github / data / click Raw / copy link
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/cardata.csv', 
              stringsAsFactors = T)

#### What if the data is not listed in website?
#### 2) in a folder
#### create a working directory (pointed to that folder)
#### then read the file directly
#### a) Session / Set Working Directory / Choose Directory / Point to the folder
df1 = read.csv('Cars.csv', stringsAsFactors = T)


#### 3) separator is not a ,
#### e.g., a tab separated file
df2 = read.table('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/WPOWER50.txt',
                 header = T, sep = "\t" stringsAsFactors = T)

### print first 10 obs of df
head(df, 10)
head(df2)

## click on the data set (opens up a tab with data set)

## checking variable types
str(df)
## can also click to environment (blue arrow)


## Data sets from packages
data()

## install mlbench
## JUST need to install a package 
## install.packages('mlbench')
## library(mlbench)


## 1) Get the histogram of price on df
hist(df$price)

## 2) select only variables citympg and price
df[, c("citympg", "price")]

## 3) bar chart of fueltype
barplot(table(df$fueltype))







