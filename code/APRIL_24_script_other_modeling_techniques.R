## Other modeling techniques
## 

df = read.csv('https://raw.githubusercontent.com/martinwg/ISA291/main/data/loan_amount.csv',
              stringsAsFactors = T)

## STRUCTURE
str(df)

## UNNECESSARY VARIABLES
df$Customer.ID = NULL
df$Name = NULL
df$Property.ID = NULL
df$Property.Age = NULL

## GETTING A SAMPLE OF THE DATA
idx = sample(1:nrow(df), size = 1000)
df = df[idx,]
str(df)

## GET RID OF MISSING VALUES
colSums(is.na(df))
## no imputation if y is missing
df = df[!is.na(df$Loan.Sanction.Amount..USD.),] 

## MODEL-BASED IMPUTATION 
library(missForest)
imp = missForest(df)
df = imp$ximp
colSums(is.na(df))


## SPLIT INTO TRAINING AND TEST
trainIndex = sample(1:nrow(df), round(0.7*nrow(df)))
df.train = df[trainIndex,]
df.test = df[-trainIndex,]


## BACKWARD VARIABLE SCREENING
null = lm(Loan.Sanction.Amount..USD. ~ 1, data = df.train)  ## no variables    
full = lm(Loan.Sanction.Amount..USD. ~ ., data = df.train)  ## all variables
b_reg = step(full, scope = list(lower = null, upper = full, direction = "backward", trace = 2, k = 2))  ## start with a full


## FORWARD VARIABLE SCREENING (start with a null)
null = lm(Loan.Sanction.Amount..USD. ~ 1, data = df.train)  ## no variables    
full = lm(Loan.Sanction.Amount..USD. ~ ., data = df.train)  ## all variables
f_reg = step(null, scope = list(lower = null, upper = full, direction = "forward", trace = 2, k = 2))

## STEPWISE VARIABLE SCREENING (start with a null)
null = lm(Loan.Sanction.Amount..USD. ~ 1, data = df.train)  ## no variables    
full = lm(Loan.Sanction.Amount..USD. ~ ., data = df.train)  ## all variables
s_reg = step(null, scope = list(lower = null, upper = full, direction = "both", trace = 2, k = 2))

## WHAT IF I HAVE 200+ VARS?
## Random Forests is a FAST non-linear model
library(randomForest)
rf = randomForest(Loan.Sanction.Amount..USD. ~ ., data = df.train)
varImpPlot(rf)
rf$importance
vars = rf$importance > 38443938779
df.train = data.frame(df.train[,vars], Loan.Sanction.Amount..USD. = df.train$Loan.Sanction.Amount..USD.)

