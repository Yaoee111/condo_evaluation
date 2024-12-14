#### Preamble ####
# Purpose: Model the analysis data.
# Author: Yiyi Yao
# Date: 03 December 2024
# Contact: ee.yao@mail.utoronto.ca
# License: MIT
# Pre-requisites: 02-clean_data.R

#### Workspace setup ####
library(rstanarm)
library(dplyr)

#### Model data ####
# Load the dataset
trt_apt <- read.csv("data/02-analysis_data/toronto_apartment_evaluation.csv")

# Filter dataset to remove rows with missing values
trt_apt_cleaned <- trt_apt %>%
  filter(!is.na(CURRENT.BUILDING.EVAL.SCORE), 
         !is.na(YEAR.BUILT), 
         !is.na(CONFIRMED.UNITS), 
         !is.na(CONFIRMED.STOREYS), 
         !is.na(PROPERTY.TYPE.CODE), 
         !is.na(WARD))

# Convert PROPERTY.TYPE.CODE to a factor for categorical modeling
trt_apt_cleaned$PROPERTY.TYPE.CODE <- as.factor(trt_apt_cleaned$PROPERTY.TYPE.CODE)

# Convert WARD to a factor since it represents regions
trt_apt_cleaned$WARD <- as.factor(trt_apt_cleaned$WARD)

# Fit a Bayesian linear model using rstanarm
# Predicting CURRENT.BUILDING.EVAL.SCORE based on YEAR.BUILT, PROPERTY.TYPE.CODE, CONFIRMED.STOREYS, CONFIRMED.UNITS, and WARD
bayesian_model <- stan_glm(
  CURRENT.BUILDING.EVAL.SCORE ~ YEAR.BUILT + PROPERTY.TYPE.CODE + CONFIRMED.STOREYS + CONFIRMED.UNITS + WARD,
  data = trt_apt_cleaned,
  family = gaussian(),
  prior = normal(0, 2.5),
  prior_intercept = normal(0, 5),
  chains = 4,
  iter = 2000,
  seed = 123
)

#### Save model ####
saveRDS(bayesian_model, "model/bayesian_model.rds")
