## INTERACTION EFFECTS:
## CEO COMPENSATION

## read data 
df =  read.csv('https://raw.githubusercontent.com/martinwg/ISA291/refs/heads/main/data/CeoCompensation.csv',
               stringsAsFactors = T)

## print obs
head(df)

## Create a reg
## y = COMP
## x1 =  EXPER
## x2 =  SALES

reg1 = lm(COMP ~ EXPER + SALES, data = df)
summary(reg1)
## THIS DOES NOT MEASURE ANY INTERACTION

## EFFECT OF EXPER
## +26.25240 
## EFFECT OF SALES
## +0.07140

## How can we check if the two vars interact?
## 1) create a new var (EXPER*SALES)
## 2) check if slope is statistically signf
## 3) if significant, there IS an interaction
reg2 = lm(COMP ~ EXPER + SALES + EXPER:SALES, data = df)
summary(reg2)
## H0: beta_expandsales = 0
## HA: beta_expandsales != 0
## There is a significant interaction between EXP and SALES




