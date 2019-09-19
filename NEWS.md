# Version 0.2.5

Updates

* Added dependency on R >= 3.5.0 because serialized objects in serialize/load version 3 cannot be read in older versions of R
* Minimal changes in `ots_create_tidy_data()` to allow multiple countries as arguments, in line with API changes from September 2019

# Version 0.2.4

Updates

* Removes `product_code_length`
* The API was updated with simplified parameters and 2018 data

# Version 0.2.3

Updates

* Fixtures for testthat evaluation

Fixes

* Specific Windows error during check

# Version 0.2.2

Adds

* Inflation data
* Inflation adjustment function
* Minor changes in vignettes

# Version 0.2.1

Fixes

* Consistent use of colour vs color, color is used from now
* Fixed available tables description
* Adds `yrp_short` to available tables
* Adds `use_localhost` option for our own server or users who want to clone the
  database locally, therefore avoid having a separate branh for server installation
  