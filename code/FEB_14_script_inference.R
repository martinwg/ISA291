## SCORECARD DATA EXAMPLE

df = read.table('https://raw.githubusercontent.com/martinwg/ISA291/main/data/scorecard_example.txt',
                sep = " ", header = T, stringsAsFactors = T)

head(df)


## scatter plot
plot(df$Cost4_A, df$md_earn_wne_p10)


## get the regression using x = cost, y = earnings
## summary
## anova table
options(scipen = 999)
reg1 = lm(md_earn_wne_p10~Cost4_A, data = df)
summary(reg1)
anova(reg1)


## t-statistic
## how many std deviations away is the estimate from zero
## 37.05

## p-value 
## IF H0 is true, this is the probability that we get t statistc
## as extreme as the one we got

## the degrees of freedom for the t-statistic
## n - (k+1)
## 3848 - (2) = 3846  ## error degrees of freedom

## Conclusion
##  We have enough evidence to reject H0
## and conclude that there is a linear relationship between
## cost and earnings

## Confidence interval on the slope 
confint(reg1) ## default 95%
## With 95% confidence, the true B1 is between 0.4586341 and 0.5098834
confint(reg1, level = .99)

## code
confint(reg1, level = 0.8)


## correlation - r
cor(df$Cost4_A, df$md_earn_wne_p10)

## square correlation  - R2
cor(df$Cost4_A, df$md_earn_wne_p10)^2

## ANOVA
## SSE - unexplained error - 336061060359
## SSR - explained error - 119954813942
## SST - total variation - 456015874301
## R2 ratio of explained to total variation
R2 = 119954813942 / 456015874301
R2
## the percent of the variation that we can explain with the model
## we can explain 26.3% of the variation in earnings using cost 
## as a predictor


## PREDICT gets point estimates, CI on the mean, CI on the individual
predict(reg1, data.frame(Cost4_A = 50000)) ## point
predict(reg1, data.frame(Cost4_A = 50000), interval = "confidence") ## 95% CI mean
predict(reg1, data.frame(Cost4_A = 50000), interval = "prediction") ## 95% CI individual






