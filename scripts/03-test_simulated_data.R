#### Preamble ####
# Purpose: Test the simulated data about apartment in Toronto.
# Author: Yiyi Yao
# Date: 03 December 2024
# Contact: ee.yao@mail.utoronto.ca
# License: MIT
# Pre-requisites: 00-simulate_data.R


#### Workspace setup ####
library(dplyr)


#### Test simulated data ####
# Read the dataset
trt_apt <- read.csv("data/00-simulated_data/simulated_apt_data.csv")

# Check structure and summary of dataset
print("Structure of the dataset:")
str(trt_apt)

print("Summary of the dataset:")
summary(trt_apt)

# Check for missing values
missing_values <- sapply(trt_apt, function(x) sum(is.na(x)))
print("Missing values in each column:")
print(missing_values)

# Check for unique values in categorical columns
unique_wards <- unique(trt_apt$Ward)
print("Unique wards:")
print(unique_wards)

# Summary statistics of numerical columns
numerical_summary <- trt_apt %>%
  select(where(is.numeric)) %>%
  summary()
print("Summary statistics of numerical columns:")
print(numerical_summary)

# Correlation matrix for numerical columns
numerical_columns <- trt_apt %>%
  select(where(is.numeric))
correlation_matrix <- cor(numerical_columns, use = "complete.obs")
print("Correlation matrix of numerical columns:")
print(correlation_matrix)

# Boxplot to detect outliers in Evaluation Score
boxplot(trt_apt$Evaluation_Score, main = "Boxplot of Evaluation Score", ylab = "Evaluation Score", col = "lightgreen")

# Shapiro-Wilk test for normality of Evaluation Score
shapiro_test <- shapiro.test(trt_apt$Evaluation_Score)
print("Shapiro-Wilk test for normality of Evaluation Score:")
print(shapiro_test)

# Count number of apartments built before and after 2000
count_before_2000 <- nrow(trt_apt %>% filter(Year_Built < 2000))
count_after_2000 <- nrow(trt_apt %>% filter(Year_Built >= 2000))
print("Number of apartments built before 2000:")
print(count_before_2000)
print("Number of apartments built after 2000:")
print(count_after_2000)

# ANOVA test for relationship between Ward and Evaluation Score
anova_result <- aov(Evaluation_Score ~ Ward, data = trt_apt)
print("ANOVA test for relationship between Ward and Evaluation Score:")
print(summary(anova_result))

# Scatter plot of Year Built vs Evaluation Score
plot(trt_apt$Year_Built, trt_apt$Evaluation_Score, main = "Year Built vs Evaluation Score", 
     xlab = "Year Built", ylab = "Evaluation Score", col = "blue", pch = 19)
