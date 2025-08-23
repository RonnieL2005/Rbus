#' Forecast Sales Using Python API
#'
#' This function sends sales data to a deployed Python FastAPI endpoint
#' and retrieves the forecasted sales for a specified number of months ahead.
#'
#' @param sales A numeric vector of historical sales values.
#' @param method Forecasting method supported by the API. Choices are:
#'   \code{"ets"} for exponential smoothing or \code{"linear"} for linear regression.
#' @param months_ahead Integer. The number of future months to forecast. Default is 6.
#' @param api_url The full URL of the Python API endpoint. Default is
#'   \code{"https://rbus-api.onrender.com/forecast_sales"}.
#'
#' @return A numeric vector of forecasted sales values from the Python API.
#'
#' @examples
#' # Forecast using ETS for the next 6 months
#' forecast_sales(
#'   sales = c(100, 200, 150, 300, 250, 400),
#'   method = "ets",
#'   months_ahead = 6,
#'   api_url = "https://rbus-api.onrender.com/forecast_sales"
#' )
#'
#' # Forecast using Linear method for the next 3 months
#' forecast_sales(
#'   sales = c(100, 200, 150, 300, 250, 400),
#'   method = "linear",
#'   months_ahead = 3
#' )
#'
#' @export
forecast_sales <- function(
    sales,
    method = "ets",
    months_ahead = 6,
    api_url = "https://rbus-api.onrender.com/forecast_sales"
) {
  # Checks inputs
  if (!is.numeric(sales)) {
    stop("sales must be a numeric vector.")
  }

  if (!method %in% c("ets", "linear")) {
    stop("Invalid method. Supported methods are: 'ets', 'linear'.")
  }

  # Prepares body according to API schema
  body <- list(
    months_ahead = months_ahead,
    sales_data = as.numeric(sales),
    method = method
  )

  # Sends POST request to Python API
  res <- httr::POST(
    url = api_url,
    httr::content_type_json(),
    body = jsonlite::toJSON(body, auto_unbox = TRUE)
  )

  # Handles response
  if (httr::status_code(res) != 200) {
    stop("API request failed with status: ", httr::status_code(res))
  }

  # Parses JSON response
  result <- httr::content(res, as = "parsed", type = "application/json")

  # Converts the list to a numeric vector
  forecast_values <- as.numeric(result$forecast)


  return(forecast_values)
}
