#### Preamble ####
# Purpose: Clean the raw data about apartment evaluation to make it clear for analysis.
# Author: Yiyi Yao
# Date: 03 December 2024
# Contact: ee.yao@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-download_data.R


#### Workspace setup ####
library(dplyr)


#### Clean raw data ####
# Read the dataset
trt_apt <- read.csv("data/01-raw_data/raw_apt_data.csv")

# Filter dataset to keep only relevant wards (13) and remove rows with NA in Year.Built
trt_apt_filtered <- trt_apt %>%
  filter(WARD %in% c("13"))%>%
  filter(!is.na(YEAR.BUILT))

# Select only relevant features for predicting building condition
trt_apt_selected <- trt_apt_filtered %>%
  select(RSN, WARD, WARDNAME, YEAR.BUILT, PROPERTY.TYPE, CONFIRMED.STOREYS, 
         CONFIRMED.UNITS, CURRENT.BUILDING.EVAL.SCORE)

# Create a new column PROPERTY_TYPE_CODE with categorization
trt_apt_cleaned <- trt_apt_selected %>%
  mutate(PROPERTY.TYPE.CODE = case_when(
    PROPERTY.TYPE == "PRIVATE" ~ 1,
    PROPERTY.TYPE == "SOCIAL HOUSING" ~ 2,
    PROPERTY.TYPE == "TCHC" ~ 3,
    TRUE ~ 0  
  ))

# View the cleaned dataset
head(trt_apt_cleaned)


#### Save cleaned data ####
write.csv(trt_apt_cleaned, "data/02-analysis_data/toronto_apartment_evaluation.csv", row.names = FALSE)
