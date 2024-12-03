#### Preamble ####
# Purpose: Simulate and save a dataset about apartment evaluation in Toronto.
# Author: Yiyi Yao
# Date: 03 December 2024
# Contact: ee.yao@mail.utoronto.ca
# License: MIT
# Pre-requisites: none


#### Workspace setup ####
library(dplyr)
library(tidyverse)


#### Simulate raw data ####
# Set seed for reproducibility
set.seed(123)

# Simulate data
n <- 1000  # Number of apartments

# Generate dataset
toronto_apartments <- data.frame(
  Apartment_ID = 1:n,
  Ward = sample(c("Etobicoke", "North York", "Scarborough", "Downtown", "York", "East York"), n, replace = TRUE),
  Year_Built = sample(1900:2022, n, replace = TRUE),
  Facilities_Score = sample(1:5, n, replace = TRUE),
  Safety_Score = sample(1:5, n, replace = TRUE),
  Maintenance_Score = sample(1:5, n, replace = TRUE),
  Cleanliness_Score = sample(1:5, n, replace = TRUE),
  Pest_Control_Log = sample(0:1, n, replace = TRUE),
  Evaluation_Score = NA  # Placeholder for overall evaluation score
)

# Calculate the overall evaluation score as a weighted average of other scores
toronto_apartments <- toronto_apartments %>%
  mutate(Evaluation_Score = round(
    0.3 * Facilities_Score +
      0.25 * Safety_Score +
      0.25 * Maintenance_Score +
      0.2 * Cleanliness_Score, 1))

# Add latitude and longitude to represent geographic data
toronto_apartments <- toronto_apartments %>%
  mutate(
    Latitude = jitter(rep(43.7, n), amount = 0.05),
    Longitude = jitter(rep(-79.4, n), amount = 0.05)
  )

# View first few rows
head(toronto_apartments)


#### Save simulated data ####
write.csv(toronto_apartments, "data/00-simulated_data/simulated_apt_data.csv", row.names = FALSE)
