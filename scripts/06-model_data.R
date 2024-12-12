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
trt_apt <- read.csv("data/02-analysis_data/toronto_apartment_evaluation.csv")

# Filter dataset to remove rows with missing values
trt_apt_cleaned <- trt_apt %>%
  filter(!is.na(CURRENT.BUILDING.EVAL.SCORE), 
         !is.na(YEAR.BUILT), 
         !is.na(CONFIRMED.UNITS), 
         !is.na(CONFIRMED.STOREYS), 
         !is.na(PROPERTY.TYPE.CODE))

# Convert PROPERTY_TYPE_CODE to a factor
trt_apt_cleaned$PROPERTY.TYPE.CODE <- as.factor(trt_apt_cleaned$PROPERTY.TYPE.CODE)

# Fit a Bayesian linear model using rstanarm
# Predicting CURRENT.BUILDING.EVAL.SCORE based on YEAR.BUILT, PROPERTY_TYPE_CODE, CONFIRMED.STOREYS, and CONFIRMED.UNITS
bayesian_model <- stan_glm(
  CURRENT.BUILDING.EVAL.SCORE ~ YEAR.BUILT + PROPERTY.TYPE.CODE + CONFIRMED.STOREYS + CONFIRMED.UNITS,
  data = trt_apt_cleaned,
  family = gaussian(),
  prior = normal(0, 2.5),
  prior_intercept = normal(0, 5),
  chains = 4,
  iter = 2000,
  seed = 123
)


#### Save data ####
saveRDS(bayesian_model, "model/bayesian_model.rds")
