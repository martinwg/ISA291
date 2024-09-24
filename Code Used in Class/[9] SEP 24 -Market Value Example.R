## House Prices Example

## Read MarketValue
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/MarketValueData.csv',
              stringsAsFactors = T)

## print obs (10)
head(df)

## select only the cols
## x1 = House_Age
## x2 = Sqr_Ft
## y = Mkt_Value_1000s

df = df[ , c("House_Age", "Sqr_Ft", "Mkt_Value_1000s") ]
## another way can be to delete variables
## df$Address = NULL

## Scatter plot (x1 with y)
plot(df$House_Age, df$Mkt_Value_1000s)

## Scatter plot matrix
plot(df)  ## as long all variables are num

## Run a regression using
## x1 
## x2 
## y
## get the summary and anova
reg1 = lm(Mkt_Value_1000s ~ House_Age + Sqr_Ft, data = df)
summary(reg1)
anova(reg1)
