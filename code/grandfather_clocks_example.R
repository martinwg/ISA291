## Grandfather Clocks Example

## Read the data
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/GFCLOCKS.csv',
              stringsAsFactors = T)

## Print Some Obs
head(df)

## Create individual scatter plots
plot(df$AGE, df$PRICE)
plot(df$NUMBIDS, df$PRICE)

## Better yet: Create a scatter plot matrix
## all scatterplots (numeric) at the same time
plot(df)
## A 1st-order model might be appropriate

## Fit the Model
reg1 = lm(PRICE ~ AGE + NUMBIDS, data = df)
summary(reg1)
anova(reg1)

## SST (depends on PRICE only)
SST = 2555224 + 1727838 + 516727   

## Total SSR (sum up all SSRs)
SSR = 2555224 + 1727838 

## SSR of AGE
SSR_AGE = 2555224

## SSR of NUMBIDS Given that AGE is in the model 
## Extra SSR contributed by NUMBIDS
SSR_NUMBIDS_EXTRA = 1727838

## SSE
SSE = 516727

reg2 = lm(PRICE ~  NUMBIDS + AGE, data = df)
summary(reg2)
anova(reg2)


## PLOT 3D PLANE
install.packages('car')
install.packages('rgl')
install.packages('scatter3d')
library(rgl)
library(car)
scatter3d(df$AGE, df$PRICE, df$NUMBIDS)







