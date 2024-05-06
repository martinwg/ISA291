## how to impute with the mean
df$variable[is.na(df$variable)] = mean(df$variable, na.rm = T)

## how to impute with median 
df$variable[is.na(df$variable)] = median(df$variable, na.rm = T)

## how to impute with zeros
df$variable[is.na(df$variable)] = 0

## how to impute many variables using model imputation
library(missForest)
imp = missForest(df) 
df = imp$ximp 
colSums(is.na(df))
