#' Expresses tidy data from the API in dollars of a reference year
#' @description Uses inflation records from The World Bank to
#' convert trade records and express them in dollars of the same year.
#' @param trade_data A tibble obtained by using ots_create_tidy_data.
#' Default set to \code{NULL}.
#' @param reference_year Year contained within the years specified in
#' api.tradestatistics.io/year_range (e.g. \code{2010}).
#' Default set to \code{NULL}.
#' @importFrom data.table `:=` rbindlist last
#' @export
#' @examples
#' \dontrun{
#' # The next example can take more than 5 seconds to compute,
#' # so this is shown without evaluation according to CRAN rules
#'
#' # Convert dollars of 1980 to dollars of 2010
#' d <- ots_create_tidy_data(years = 1980, reporters = "chl", partners = "chn")
#' ots_inflation_adjustment(trade_data = d, reference_year = 2010)
#' }
#' @keywords functions
ots_inflation_adjustment <- function(trade_data = NULL, reference_year = NULL) {
  # Check input -------------------------------------------------------------
  if (is.null(trade_data)) {
    stop("The input data cannot be NULL.")
  }

  if (is.null(reference_year)) {
    stop("The reference year cannot be NULL."
    )
  }

  ots_inflation_min_year <- min(tradestatistics::ots_inflation$from)
  ots_inflation_max_year <- max(tradestatistics::ots_inflation$from)

  if (!is.numeric(reference_year) |
    !(reference_year >= ots_inflation_min_year &
      reference_year <= ots_inflation_max_year)) {
    stop(sprintf("The reference year must be numeric and contained within ots_inflation years range that is %s-%s.",
        ots_inflation_min_year,
        ots_inflation_max_year
      )
    )
  }

  # Filter year conversion rates and join data ------------------------------
  years <- unique(trade_data$year)
  
  d1 <- lapply(
    years,
    function(year) {
      if (year <= reference_year) {
        tradestatistics::ots_inflation[to <= reference_year & to > year,
          .(conversion_factor = last(cumprod(conversion_factor)))][,
          `:=`(year = ..year, conversion_year = ..reference_year)][,
          .(year, conversion_year, conversion_factor)]
      } else {
        tradestatistics::ots_inflation[from >= reference_year & from < year,
          .(conversion_factor = 1/last(cumprod(conversion_factor)))][,
          `:=`(year = ..year, conversion_year = ..reference_year)][,
          .(year, conversion_year, conversion_factor)]
      }
    }
  )
  d1 <- rbindlist(d1)
  d1 <- d1[, `:=`(conversion_factor = ifelse(year == conversion_year, 1, conversion_factor))]
  
  d2 <- trade_data[d1, on = .(year), allow.cartesian = TRUE][,
    `:=`(export_value_usd = export_value_usd * conversion_factor,
         import_value_usd = import_value_usd * conversion_factor)]
  
  if (any("top_export_trade_value_usd" %in% names(d2))) {
    d2 <- d2[,
      `:=`(top_export_trade_value_usd = top_export_trade_value_usd * conversion_factor,
           top_import_trade_value_usd = top_import_trade_value_usd * conversion_factor)]
  }
  
  if (any("top_exporter_trade_value_usd" %in% names(d2))) {
    d2 <- d2[,
      `:=`(top_exporter_trade_value_usd = top_exporter_trade_value_usd * conversion_factor,
           top_importer_trade_value_usd = top_importer_trade_value_usd * conversion_factor)]
  }

  return(d2)
}
