#' Plot Sales Trend
#'
#' Creates a line plot of sales over time, optionally grouped by category.
#'
#' @param data A data frame containing at least a date column and a sales column.
#' @param date_col The name of the date column (default: "Date").
#' @param sales_col The name of the sales column (default: "Sales").
#' @param category_col Optional, the name of the category column (default: NULL).
#' @param color A single color to use when no category is provided (default: "red").
#' @param palette A named vector of colors to use when category_col is provided (default: NULL).
#'
#' @return A ggplot object.
#' @examples
#' \dontrun{
#' sample_data <- data.frame(
#'   Date = as.Date(c("2023-01-01", "2023-02-01", "2023-03-01")),
#'   Sales = c(200, 250, 300),
#'   Category = c("Product A", "Product B", "Product A")
#' )
#' plot_sales_trend(sample_data) # simple
#' plot_sales_trend(sample_data, category_col = "Category",
#'                  palette = c("Product A" = "blue", "Product B" = "green"))
#' }
plot_sales_trend <- function(data,
                             date_col = "Date",
                             sales_col = "Sales",
                             category_col = NULL,
                             color = "red",
                             palette = NULL) {
  library(ggplot2)

  # base aesthetics
  aes_base <- aes(x = .data[[date_col]], y = .data[[sales_col]])

  if (is.null(category_col)) {
    # Single color case
    p <- ggplot(data, aes_base) +
      geom_line(color = color, linewidth = 1.2) +
      labs(title = "Sales Trend", x = "Date", y = "Sales")
  } else {
    # Category + palette
    p <- ggplot(data, aes_base) +
      geom_line(aes(color = .data[[category_col]]), linewidth = 1.2) +
      labs(title = "Sales Trend by Category", x = "Date", y = "Sales", color = category_col)

    if (!is.null(palette)) {
      p <- p + scale_color_manual(values = palette)
    }
  }

  return(p)
}

