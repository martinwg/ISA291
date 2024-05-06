## GETTING A SAMPLE OF THE DATA
## IF YOUR DATA SET IS TOO BIG
idx = sample(1:nrow(df), size = 10000)  ## choose a smaller data set. E.g, 10000 obs
df = df[idx,]
str(df)