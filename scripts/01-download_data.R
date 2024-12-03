#### Preamble ####
# Purpose: Download and save the data about apartment evaluation from the Toronto Open Data.
# Author: Yiyi Yao
# Date: 03 December 2024
# Contact: ee.yao@mail.utoronto.ca
# License: MIT
# Pre-requisites: none


#### Workspace setup ####
library(opendatatoronto)
library(dplyr)
library(tidyverse)


#### Download raw data ####
# get package
package <- show_package("4ef82789-e038-44ef-a478-a8f3590c3eb1")
package

# get all resources for this package
resources <- list_package_resources("4ef82789-e038-44ef-a478-a8f3590c3eb1")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
raw_data <- filter(datastore_resources, row_number()==1) %>% get_resource()
raw_data


#### save raw data ####
write_csv(
  x = raw_data,
  file = "data/01-raw_data/raw_apt_data.csv"
)
