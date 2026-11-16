# CPI Forecasting Project
# Name: Steven Nguyen

#======================================================================
# Import the CSV data file
cpi <- read.csv("CPI_change_2.csv", fileEncoding = "UTF-8-BOM")

# Display the first six rows
head(cpi)

# Check the number of observations
nrow(cpi)

# Open the data in a table
View(cpi)

# Extract the year from each date
cpi$Year <- as.integer(format(as.Date(cpi$observation_date), "%Y"))

# Put the observations in chronological order
cpi <- cpi[order(cpi$Year), ]

# Store the years and actual CPI changes
year <- cpi$Year
y <- cpi$INFLATION
n <- length(y)

# Identify the evaluation period: 2001-2015
evaluation <- year >= 2001 & year <= 2015
actual <- y[evaluation]

# Check the number of years being evaluated
print(length(actual))

# Exercise 3.2(a): Moving-average forecasts

# Create empty spaces for the forecasts
MA3 <- rep(NA, n)
MA7 <- rep(NA, n)

# Three-term moving average
for (i in 4:n) {
  MA3[i] <- mean(y[(i - 3):(i - 1)])
}

# Seven-term moving average
for (i in 8:n) {
  MA7[i] <- mean(y[(i - 7):(i - 1)])
}

# Create a table for 2001-2015
ma_forecasts <- data.frame(
  Year = year[evaluation],
  Actual = actual,
  MA3 = MA3[evaluation],
  MA7 = MA7[evaluation]
)

# Display the forecast table
print(round(ma_forecasts, 4))

# Exercise 3.2(b): RMSE and MAE

# Calculate forecast errors for 2001-2015
error_MA3 <- actual - MA3[evaluation]
error_MA7 <- actual - MA7[evaluation]

# Create an accuracy table
ma_accuracy <- data.frame(
  RMSE = c(
    sqrt(mean(error_MA3^2)),
    sqrt(mean(error_MA7^2))
  ),
  MAE = c(
    mean(abs(error_MA3)),
    mean(abs(error_MA7))
  ),
  row.names = c("MA3", "MA7")
)

print(round(ma_accuracy, 4))

# Answer:
# The seven-term moving average has lower RMSE and MAE.
# Therefore, it performs better over 2001-2015.

# Exercise 3.2(c): RelMAE and MASE

# Naive forecast: use the previous year's actual value
naive <- c(NA, y[1:(n - 1)])

# Naive MAE for the evaluation period
naive_MAE <- mean(abs(actual - naive[evaluation]))

# RelMAE
ma_accuracy$RelMAE <- ma_accuracy$MAE / naive_MAE

# MASE denominator: average absolute change in training data
training <- y[year < 2001]
mase_scale <- mean(abs(diff(training)))

# MASE
ma_accuracy$MASE <- ma_accuracy$MAE / mase_scale

# Display all moving-average accuracy measures
print(round(ma_accuracy, 4))

# Answer:
# Both RelMAE values are below 1, so both moving averages
# outperform the naive method over 2001-2015.
# Both MASE values are below 1, so their evaluation MAEs
# are below the training-period naive MAE.

# Exercise 3.5(a): Simple exponential smoothing

# Create empty forecast vectors
SES_02 <- rep(NA, n)
SES_05 <- rep(NA, n)
SES_08 <- rep(NA, n)

# Use the 1963 actual value to forecast 1964
SES_02[2] <- y[1]
SES_05[2] <- y[1]
SES_08[2] <- y[1]

# Calculate forecasts for 1965 onward
for (i in 3:n) {
  SES_02[i] <- 0.2 * y[i - 1] + 0.8 * SES_02[i - 1]
  SES_05[i] <- 0.5 * y[i - 1] + 0.5 * SES_05[i - 1]
  SES_08[i] <- 0.8 * y[i - 1] + 0.2 * SES_08[i - 1]
}

# Create a forecast table
year <- cpi$Year

ses_forecasts <- data.frame(
  Year = year,
  Actual = y,
  SES_02 = SES_02,
  SES_05 = SES_05,
  SES_08 = SES_08
)

# Display forecasts for 1964-2015
print(round(ses_forecasts[year >= 1964, ], 4))

# Exercise 3.5(b): SES accuracy for 2001-2015

# Calculate forecast errors
error_SES02 <- actual - SES_02[evaluation]
error_SES05 <- actual - SES_05[evaluation]
error_SES08 <- actual - SES_08[evaluation]

# Create an accuracy table
ses_accuracy <- data.frame(
  RMSE = c(
    sqrt(mean(error_SES02^2)),
    sqrt(mean(error_SES05^2)),
    sqrt(mean(error_SES08^2))
  ),
  MAE = c(
    mean(abs(error_SES02)),
    mean(abs(error_SES05)),
    mean(abs(error_SES08))
  ),
  row.names = c("SES_0.2", "SES_0.5", "SES_0.8")
)

print(round(ses_accuracy, 4))

# Answer:
# Among the three SES options, alpha = 0.2 has the lowest RMSE.
# Alpha = 0.5 has the lowest MAE.
# Alpha = 0.8 has the highest RMSE and MAE.

# Exercise 3.5(c): Compare all five forecasting methods

# Combine RMSE and MAE results
comparison <- rbind(
  ma_accuracy[, c("RMSE", "MAE")],
  ses_accuracy
)

print(round(comparison, 4))

# Answer:
# All methods are evaluated over the same period: 2001-2015.

# The seven-term moving average has the lowest overall RMSE,
# approximately 1.1540.

# SES with alpha = 0.5 has the lowest overall MAE,
# approximately 0.8331.

# SES with alpha = 0.2 and 0.5 beats the three-term moving
# average on both RMSE and MAE.

# Compared with the seven-term moving average, SES with
# alpha = 0.2 and 0.5 has lower MAE but higher RMSE.

# SES with alpha = 0.8 performs worse than both moving
# averages on both measures.

# The preferred method depends on the accuracy measure.
# RMSE gives greater weight to large errors than MAE.