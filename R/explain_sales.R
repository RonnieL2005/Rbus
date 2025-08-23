#' Explain Future Sales Using Python API
#'
#' This function sends historical sales data to a deployed Python FastAPI endpoint
#' and retrieves an explanation of the forecasted sales trend.
#'
#' @param sales A numeric vector of historical sales values.
#' @param method Forecasting method supported by the API ("ets" or "linear").
#' @param months_ahead Number of months ahead to forecast/explain (default is 6).
#' @param api_url The URL of the Python API endpoint (default is
#' "https://rbus-api.onrender.com/explain_sales").
#'
#' @return A character string containing the explanation of the forecasted sales.
#'
#' @examples
#' sales_data <- c(100, 200, 150, 300, 250, 400)
#' explain_sales(
#'   sales = sales_data,
#'   method = "ets",
#'   months_ahead = 6,
#'   api_url = "https://rbus-api.onrender.com/explain_sales"
#' )
#'
#' @export
explain_sales <- function(
    sales,
    method = "ets",
    months_ahead = 6,
    api_url = "https://rbus-api.onrender.com/explain_sales"
) {
  if (!is.numeric(sales)) {
    stop("sales must be a numeric vector.")
  }

  if (!method %in% c("ets", "linear")) {
    stop("Invalid method. Supported methods are: 'ets', 'linear'.")
  }

  body <- list(
    months_ahead = months_ahead,
    sales_data = as.numeric(sales),
    method = method
  )

  res <- httr::POST(
    url = api_url,
    httr::content_type_json(),
    body = jsonlite::toJSON(body, auto_unbox = TRUE)
  )

  if (httr::status_code(res) != 200) {
    stop("API request failed with status: ", httr::status_code(res))
  }

  result <- httr::content(res, as = "parsed", type = "application/json")

  # Extract explanation (string)
  explanation <- as.character(result$explanation)

  return(explanation)
}
