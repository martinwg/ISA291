## Reading Data in R
df = read.csv("CARGO.csv", stringsAsFactors = T)
df

# read.table
df = read.table("CARGO.txt", sep = "\t", header = T, stringsAsFactors =  T)
df

## Github
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/CARGO.csv', stringsAsFactors = T)


# POWER50
df = read.table("https://raw.githubusercontent.com/martinwg/ISA291/main/data/WPOWER50.txt",
                header = T,
                sep = "\t",
                stringsAsFactors = T) 

# inspection of data
head(df)

# 10 obs
head(df, 10)

# last 6 obs
tail(df)

## check variable types
str(df)

## Read automobiles.csv as auto
auto = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/automobiles.csv',
                stringsAsFactors = T)

# print the first 8 obs
head(auto, 8)

# check the variable types
str(auto)


# pre-loaded datasets
data()

# install a package using code
# install.packages("ada")
# install.packages("car")

# Package dataset
data()
data(BostonHousing)


## Select AGE for df
df[,3]
hist(df[,3])

## get a hist for price in auto
hist(auto[,25])
hist(auto$price)
hist(auto$engine.size)

## select RANK and TITLE from df
df[, c(1,5)]
df[, c("RANK", "TITLE")]

## AUTO -- SCATTER PLOT y = price, x = engine.size
plot(auto$engine.size, auto$price)
plot(auto[, "engine.size"], auto[,25])


## barchart for title for df
barplot(table(df$TITLE))

## barchart for drive.wheels on auto
barplot(table(auto$drive.wheels))

## auto get all cars with price < 12000
auto[auto$price < 12000 , ]
subset(auto, price < 12000)

## find auto -- price < 12000 and horsepower >= 100, or city.mpg  > 40
auto[auto$price < 12000 & auto$horsepower >= 100 | auto$city.mpg > 40, ]









