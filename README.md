# CPI-Inflation-Forecasting-Project
Project Overview

This project applies time series forecasting techniques to analyze annual Consumer Price Index (CPI) inflation data from 1963 to 2015. Using R, I developed and compared several forecasting approaches to examine their performance and evaluate forecasting accuracy.

Project Objectives

Explore historical annual CPI inflation trends.

Apply different time series forecasting techniques.

Generate forecasts and compare their performance.

Evaluate forecasting accuracy across different methods.

Forecasting Methods

This project uses the following forecasting techniques:

1. Naive Forecasting

Uses the most recent actual observation as the forecast for the next period.

2. Moving Average

3-period Moving Average (MA3)

7-period Moving Average (MA7)

3. Simple Exponential Smoothing (SES)

Alpha = 0.2

Alpha = 0.5

Alpha = 0.8

Different smoothing parameters are used to evaluate how the weighting of historical observations affects forecast performance.

Tools & Technologies

R: Data processing, forecasting, and statistical analysis.

RStudio: Development environment for writing and executing R code.

Repository Structure

CPI_Assignment.R..R – R script containing data processing, forecasting calculations, and accuracy evaluation.

CPI_change_2.csv – Original CPI inflation dataset.

README.md – Project documentation.

How to Run

Download or clone this repository.

Open the R script in RStudio.

Ensure the R script and CSV dataset are saved in the same working directory.

Run the script from beginning to end to reproduce the analysis.

Skills Demonstrated

R programming and data manipulation

Time series forecasting

Statistical analysis

Forecast accuracy evaluation

Data interpretation and analytical problem-solving

Project Summary

This project demonstrates the application of statistical forecasting methods to historical economic data. By comparing Naive Forecasting, Moving Averages, and Simple Exponential Smoothing, the analysis explores different approaches to forecasting annual inflation and evaluating their accuracy.
