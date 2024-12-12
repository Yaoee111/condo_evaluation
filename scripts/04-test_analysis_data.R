#### Preamble ####
# Purpose: Test the analysis data about apartment evaluation.
# Author: Yiyi Yao
# Date: 03 December 2024
# Contact: ee.yao@mail.utoronto.ca
# License: MIT
# Pre-requisites: 02-clean_data.R


#### Workspace setup ####
library(dplyr)


#### Test analysis data ####
# Read the dataset
trt_apt <- read.csv("data/02-analysis_data/toronto_apartment_evaluation.csv")

# Testing the dataset
# Check for missing values
missing_values <- sapply(trt_apt_cleaned, function(x) sum(is.na(x)))
print("Missing values in each column:")
print(missing_values)

# Summary statistics of the dataset
summary_stats <- summary(trt_apt_cleaned)
print("Summary statistics:")
print(summary_stats)

# Check for unique values in categorical columns
unique_wards <- unique(trt_apt_cleaned$Ward)
print("Unique wards:")
print(unique_wards)

# Correlation matrix for numerical columns
numerical_columns <- trt_apt_cleaned %>%
  select(YEAR.BUILT, CONFIRMED.STOREYS, CONFIRMED.UNITS, 
         CURRENT.BUILDING.EVAL.SCORE)
correlation_matrix <- cor(numerical_columns, use = "complete.obs")
print("Correlation matrix:")
print(correlation_matrix)

# Visualize distribution of Evaluation Score
hist(trt_apt_cleaned$CURRENT.BUILDING.EVAL.SCORE, main = "Distribution of Evaluation Score", xlab = "Evaluation Score", col = "lightblue", border = "black")

# Test for outliers using boxplot
boxplot(trt_apt_cleaned$CURRENT.BUILDING.EVAL.SCORE, main = "Boxplot of Evaluation Score", ylab = "Evaluation Score", col = "lightgreen")

# Test for normality of Evaluation Score using Shapiro-Wilk test
shapiro_test <- shapiro.test(trt_apt_cleaned$CURRENT.BUILDING.EVAL.SCORE)
print("Shapiro-Wilk test for normality of Evaluation Score:")
print(shapiro_test)

# Count the number of apartments built before and after 2000
count_before_2000 <- nrow(trt_apt_cleaned %>% filter(YEAR.BUILT < 2000))
count_after_2000 <- nrow(trt_apt_cleaned %>% filter(YEAR.BUILT >= 2000))
print("Number of apartments built before 2000:")
print(count_before_2000)
print("Number of apartments built after 2000:")
print(count_after_2000)

# Test for relationships between categorical variables and Evaluation Score using ANOVA
anova_result <- aov(CURRENT.BUILDING.EVAL.SCORE ~ PROPERTY.TYPE.CODE, data = trt_apt_cleaned)
print("ANOVA test for relationship between Property Type Code and Evaluation Score:")
print(summary(anova_result))

# Scatter plot of Year Built vs Evaluation Score
plot(trt_apt_cleaned$YEAR.BUILT, trt_apt_cleaned$CURRENT.BUILDING.EVAL.SCORE, main = "Year Built vs Evaluation Score", xlab = "Year Built", ylab = "Evaluation Score", col = "blue", pch = 19)
