#' Predict future sales using different forecasting methods
#'
#' @param data A data.frame containing at least a numeric column 'Sales'
#' @param method The forecasting method to use: "mean3", "moving_avg", "linear"/"lm", or "ets"
#' @param window Number of months to use for moving average (only for "moving_avg" method)
#' @return A numeric prediction for the next sales value
#' @examples
#' sample_data <- data.frame(
#'   Month = c("Jan", "Feb", "Mar", "Apr", "May", "Jun"),
#'   Sales = c(100, 200, 250, 300, 400, 420)
#' )
#' predict_sales(sample_data, method = "mean3")
#' predict_sales(sample_data, method = "moving_avg", window = 2)
#' predict_sales(sample_data, method = "linear")
#' predict_sales(sample_data, method = "lm")
#'
#' @export
predict_sales <- function(data, method = c("mean3", "moving_avg", "linear", "lm", "ets"), window = 6) {
  method <- match.arg(method)

  if (!"Sales" %in% names(data)) {
    stop("Input data must contain a 'Sales' column.")
  }
  if (!is.numeric(data$Sales)) {
    stop("'Sales' column must be numeric.")
  }

  sales <- na.omit(data$Sales)
  if (length(sales) < 2) {
    stop("Not enough data to make a prediction (need at least 2 values).")
  }

  prediction <- NA

  if (method == "mean3") {
    # Average of last 3 months
    n <- min(3, length(sales))
    prediction <- mean(tail(sales, n))

  } else if (method == "moving_avg") {
    # Use the user-specified window, but not more than available data
    if (!is.numeric(window) || window <= 0) {
      stop("'window' must be a positive integer.")
    }
    n <- min(window, length(sales))
    prediction <- mean(tail(sales, n))

  } else if (method %in% c("linear", "lm")) {
    # Fit linear regression on time trend
    time <- seq_along(sales)
    fit <- lm(sales ~ time)
    next_time <- length(sales) + 1
    prediction <- predict(fit, newdata = data.frame(time = next_time))

  } else if (method == "ets") {
    # Exponential smoothing (needs forecast package)
    if (!requireNamespace("forecast", quietly = TRUE)) {
      stop("Package 'forecast' required for ETS method. Please install it.")
    }
    ts_data <- ts(sales, frequency = 12)  # assume monthly data
    fit <- forecast::ets(ts_data)
    fcast <- forecast::forecast(fit, h = 1)
    prediction <- as.numeric(fcast$mean)
  }

  return(prediction)
}



