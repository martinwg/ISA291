## CEO Compensation Example
## Interaction Terms

## Read Data
df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/CeoCompensation.csv',
              stringsAsFactors = T)

## Print some obs
head(df)

## Model DF
reg1 = lm(COMP ~ ., data = df)
summary(reg1)

## Model DF (k)
## every numeric predictor = 1 df
## every categorical predictor = # levels - 1 df
## 9 model df for numeric variables
## 99 model df for Company
## 84 model df for Birth
## Total = 192 model df
## Need to estimate 192 slopes + 1 y-intercept = 193


## Error DF (n - (k+1))
## n = 100 obs
## 100 - (192+1) 

## ---------------------------------------------------------
## Let's use only SALES + EXPER - COMP

## first-order model assumes NO interactions
options(scipen = 999) ## gets rid of exponentials. e.g., 1+e-10
reg2 = lm(COMP ~ SALES + EXPER, data = df)
summary(reg2)

## 3D plot
library(rgl) ## mac - install a program Quartz
library(car)
scatter3d(COMP ~ SALES + EXPER, data = df)

## Test an interaction between SALES and EXPER
reg3 = lm(COMP ~ SALES + EXPER + SALES:EXPER, data = df)
summary(reg3)

## Interaction Plot
## Shows the different slopes
## install.packages('sjPlot') ## to plot interactions
library(sjPlot) ## load package
plot_model(reg3, type = 'int')

## SALES in X-AXIS
## COMP in Y-AXIS
## Showing the effect of SALES on COMP

## The Interaction plot shows as SALES REVENUE increases
## the effect of COMP depends on the EXPER of the CEO
## If the experience is very low (0.5 years - 6 months)
## then the COMP stays flat as SALES REVENUE increases
## changes by  0.018976 + 0.007667*EXPER or $22.8095
0.018976 + 0.007667*0.5


## But if the EXPER is high (say 35 years)
## then the COMP increases by 0.018976 + 0.007667*35
## $287 for every 1M increase in revenue.

## Let's show the interaction plot
## EXPER in X-AXIS
## COMP in Y-AXIS
reg3 = lm(COMP ~ EXPER + SALES + SALES:EXPER, data = df)
summary(reg3)
plot_model(reg3, type = 'int')

















