## CHECK FOR MISSING DATA
colSums(is.na(df))


## IMPUTE 1 VARIABLE WITH THE MEAN
df$Income[is.na(df$Income)] = mean(df$Income, na.rm = T)


## IMPUTE 1 VARIABLE WITH THE MEDIAN
df$Age[is.na(df$Age)] = median(df$Age, na.rm = T)

## IMPUTING MANY VARIABLES AT THE SAME TIME
## make sure to install the mice package
## install.packages('mice')
library(mice)

## Impute missing values using mean imputation
imputed_df <- mice(df, m = 5, maxit = 50, method = 'mean', seed = 500)

## Complete the imputed data
df <- complete(imputed_df, 1)

## Now 'df' contains the data with imputed values
## for ALL variables with missing values
head(df)