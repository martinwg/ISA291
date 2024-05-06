## create a predictions object
predictions = predict(final_model, test)

library(caret)
postResample(predictions, test$y)
