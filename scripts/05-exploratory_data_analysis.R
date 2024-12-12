#### Preamble ####
# Purpose: Graph the analysis data about apartment evaluation.
# Author: Yiyi Yao
# Date: 03 December 2024
# Contact: ee.yao@mail.utoronto.ca
# License: MIT
# Pre-requisites: 02-clean_data.R


#### Workspace setup ####
library(dplyr)
library(ggplot2)


#### Graphs ####
# Read the dataset
trt_apt <- read.csv("data/02-analysis_data/toronto_apartment_evaluation.csv")

# Univariate Analysis
## Histogram of Evaluation Score
ggplot(trt_apt, aes(x = CURRENT.BUILDING.EVAL.SCORE)) +
  geom_histogram(binwidth = 0.5, fill = "lightblue", color = "black") +
  theme_minimal() +
  labs(title = "Distribution of Evaluation Score", x = "Evaluation Score", y = "Count")

## Boxplot of Year Built
ggplot(trt_apt, aes(y = YEAR.BUILT)) +
  geom_boxplot(fill = "lightgreen", color = "black") +
  theme_minimal() +
  labs(title = "Boxplot of Year Built", y = "Year Built")

## Bar plot of PROPERTY.TYPE.CODE
ggplot(trt_apt, aes(x = PROPERTY.TYPE.CODE)) +
  geom_bar(fill = "lightcoral", color = "black") +
  theme_minimal() +
  labs(title = "Number of Apartments by Property Type", x = "Property Type", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Bivariate Analysis
## Scatter plot of Year Built vs Evaluation Score
ggplot(trt_apt, aes(x = YEAR.BUILT, y = CURRENT.BUILDING.EVAL.SCORE)) +
  geom_point(color = "blue", alpha = 0.6) +
  theme_minimal() +
  labs(title = "Year Built vs Evaluation Score", x = "Year Built", y = "Evaluation Score")

## Boxplot of Evaluation Score by Property Type
ggplot(trt_apt, aes(x = PROPERTY.TYPE.CODE, y = CURRENT.BUILDING.EVAL.SCORE)) +
  geom_boxplot(fill = "lightblue", color = "black") +
  theme_minimal() +
  labs(title = "Evaluation Score by Property Type", x = "Property Type", y = "Evaluation Score") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

## Correlation Matrix
numerical_columns <- trt_apt %>%
  select(YEAR.BUILT, CONFIRMED.STOREYS, 
         CONFIRMED.UNITS, CURRENT.BUILDING.EVAL.SCORE)
correlation_matrix <- cor(numerical_columns, use = "complete.obs")
print("Correlation matrix:")
print(correlation_matrix)

## Pair Plot
pairs(numerical_columns, main = "Pair Plot of Numerical Features")
