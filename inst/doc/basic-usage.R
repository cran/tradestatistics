## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  cache = FALSE,
  collapse = TRUE,
  message = FALSE,
  comment = "#>"
)

## ----pkgs---------------------------------------------------------------------
library(tradestatistics)

## ----tables, eval = T---------------------------------------------------------
ots_tables

## ----countries, eval = T------------------------------------------------------
ots_countries

## ----commodities, eval = T----------------------------------------------------
ots_sectors

ots_industries

## ----country_code-------------------------------------------------------------
# Single match with no replacement
ots_country_code("Chile")

# Single match with replacement
ots_country_code("America")

# Double match with no replacement
ots_country_code("Germany")

## ----commodity_code2----------------------------------------------------------
ots_sector_code(" AgriCulture ")
ots_industry_code("  CeReaLS")

## ----aggregate1, eval = F-----------------------------------------------------
# ots_create_tidy_data(
#   years = 2019,
#   importers = "chl",
#   exporters = "arg",
#   table = "itpde_imp_exp"
# )

## ----aggregate2, eval = F-----------------------------------------------------
# ots_create_tidy_data(
#   years = 2018:2019,
#   importers = c("chl", "Peru", "col"),
#   exporters = c("arg", "Brazil"),
#   table = "itpde_imp_exp"
# )

## ----sector1, eval = F--------------------------------------------------------
# ots_create_tidy_data(
#   years = 2018:2019,
#   importers = c("chl", "Peru", "col"),
#   exporters = c("arg", "Brazil"),
#   table = "itpde_imp_exp_sec"
# )

## ----industry1, eval = F------------------------------------------------------
# ots_create_tidy_data(
#   years = 2018:2019,
#   importers = c("chl", "Peru", "col"),
#   exporters = c("arg", "Brazil"),
#   table = "itpde_ind"
# )

