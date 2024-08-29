## Reading Data into R

## Is the data in your computer?
## 1) working directory
## Session > Set Working Directory > Choose Directory 
## 2) write data set name in quotes (can use tab to complete)
df = read.csv('cardata.csv', header = T, stringsAsFactors = T)

## Is the data in a website (github)?
## No need to set working directory
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/cardata.csv',
              stringsAsFactors = T)

## Example 3
## WPOWER50.txt
WPOWER50 = read.table('https://raw.githubusercontent.com/martinwg/ISA291/main/data/WPOWER50.txt',
                      sep = "\t", header = T, stringsAsFactors = T)

## Print the first 10 obs for df
head(df, 10)

## Check Variable Types
str(df)

## Overwrite (modify)
## e.g., REMOVE A VARIABLE
df = df[,-1]
str(df)

## Check Pre-loaded data sets
data()

## You can use data sets from packages
## make sure to install the package (1-time)
## load the package (every time you open R)
data("BostonHousing")

## MANIPULATING DATA FRAMES

## Selecting 1 variable
## Get a histogram of the price variable in df
hist(df$price)
## Get a hist of horsepower color red
hist(df$horsepower, col = "red")

## Selecting > 1 variable
df[,c(23, 24, 25)] ## var indices needed
df[,23:25]  ## var indices needed
df[, c("citympg", "highwaympg", "price")] ## name

## PACKAGE
## dplyr
df %>% select(citympg, highwaympg, price)

## summary statistics
summary(df) ## for the whole dataset
summary(df$price)

## plots
## scatter plot (needs two vars)
## plot(x,y)
plot(df$horsepower, df$price)

## bar chart (categorical vars)
barplot(table(df$carbody))

## conditionals
## select fueltype equal to gas
df[ df$fueltype == "gas", ]

## only select cars with horsepower > 150
supercars = df[ df$horsepower > 150, ]

## select gas cars with horsepower > 200
df[df$fueltype == "gas" & df$horsepower > 200, ]

## pie() 






