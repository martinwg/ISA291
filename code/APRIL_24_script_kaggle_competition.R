## read
df = read.csv('training.csv', stringsAsFactors = T)  ## download from kaggle

## structure
str(df)

## check for missing


## variable selection technique
## say 20-25 variables


## train/test


## build your AWESOME model
## got to get those 5+


## prediction for the test (kaggle)
newdata = read.csv('test.csv', stringsAsFactors = T) ## download from kaggle
predictions = predict(awesomemodel, newdata)
my_predictions = data.frame(ID = newdata$ID, close = predictions)
write.csv(my_predictions, "my_predictions.csv", row.names = F)  ## transform to CSV file
## SUBMIT CSV FILE TO KAGGLE
## CLICK SUBMIT PREDICTIONS
## UPLOAD YOUR CSV FILE
