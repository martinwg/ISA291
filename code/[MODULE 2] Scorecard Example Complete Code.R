## COLLEGE SCORECARD 
college = read.csv("https://raw.githubusercontent.com/martinwg/ISA291/main/data/college_scorecard.csv",
                  stringsAsFactors = TRUE)
head(college)

## SUBSET VARS
college = college[, c('COSTT4_A', 'MD_EARN_WNE_P10')]
head(college)

## OMIT MISSING OBS
college = na.omit(college)

## STRUCTURE
str(college)

## REMOVE EXPONENTIAL NOTATION
options(scipen = 999)

## SUMMARY
summary(college)

## SCATTERPLOT
plot(college$COSTT4_A, college$MD_EARN_WNE_P10)

## LM() TO ESTIMATE RELATIONSHIP
reg1 = lm(MD_EARN_WNE_P10 ~ COSTT4_A, data = college)
summary(reg1)

## TYPE
class(reg1)

## NAMES FUNCTION TO LIST ELEMENTS
names(reg1)

## PLOT THE REGRESSION LINE
plot(college$COSTT4_A, college$MD_EARN_WNE_P10)
abline(reg1, col = "red")

## ANOVA
anova(reg1)

## CHECKING ASSUMPTIONS

## ASSUMPTION 1: MEAN(ERROR TERM)
residuals = reg1$residuals
hist(residuals, col = "red", breaks = 20)
mean(residuals)

## ASSUMPTION 2: VAR(ERROR TERM)
predicted = reg1$fitted.values
plot(predicted, residuals)
abline(0,0, col = 'red')

## automated graphs
plot(reg1)

## ASSUMPTION 3: ERROR TERM ~ N(0, VAR)
qqnorm(residuals)
qqline(residuals, col = "red")
shapiro.test(residuals) ## H0: residuals is NORMAL

## INFERENCE ON THE SLOPE
reg1 = lm(MD_EARN_WNE_P10 ~ COSTT4_A, data = college)
summary(reg1)

## HYPOTHESIS TEST
# H0: BETA1 = 0
# HA: BETA1 != 0

# b0 = 0.50979
# s_b0 = 0.01196
# t = b0 / s_b0 = 42.62
# The estimate of the slope is 42.62 std errors away from zero.
# t ~ tdist(3079) 
# p-value: the probability of the t-value being as extreme as 42.62
# given that the H0 is true.
# alpha of 0.05 (threshold)
# conclusion: there is enough evidence against H0, so there is
# a linear relationship between cost and median earnings.

## Confidence interval
confint(reg1)
confint(reg1, level = 0.99)


## correlation coefficient
cor(college$COSTT4_A, college$MD_EARN_WNE_P10)

## coefficient of determination (R2)
anova(reg1)

## Point Estimate
30658.18159 + 0.50979*50000

yhat = predict(reg1, data.frame(COSTT4_A=50000))
yhat

## Confidence Interval (mean)
predict(reg1, data.frame(COSTT4_A=50000), 
        interval = "confidence")


## Prediction Interval (individual)
predict(reg1, data.frame(COSTT4_A=50000), 
        interval = "prediction")


## Plot
pred.int <- predict(reg1, interval="prediction", level=0.95)
mydata <- cbind(college, pred.int)
# 2. Regression line + confidence intervals
library("ggplot2")
p <- ggplot(mydata, aes(COSTT4_A, MD_EARN_WNE_P10)) +
  geom_point() +
  stat_smooth(method = lm)
# 3. Add prediction intervals
p + geom_line(aes(y = lwr), color = "red", linetype = "dashed")+
  geom_line(aes(y = upr), color = "red", linetype = "dashed")

