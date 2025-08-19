#' Get Sales Summary Statistics
#'
#' This function calculates summary statistics for sales data,
#' grouped by a category (e.g., Product, Region, or Time).
#'
#' @param data A data.frame containing sales data.
#' @param group_col The column name to group by (default: "Category").
#' @param sales_col The column name for sales values (default: "Sales").
#' @param include_percent Logical, whether to include percentage of total sales (default: FALSE).
#' @return A tibble with summary statistics: Total Sales, Average Sales, Min, Max, (and optional Percent_of_Total).
#' @examples
#' sample_data <- data.frame(
#'   Category = c("Product A", "Product B", "Product A", "Product B"),
#'   Sales = c(300, 500, 200, 400)
#' )
#' get_sales_summary(sample_data)
#' @export
get_sales_summary <- function(data, group_col = "Category", sales_col = "Sales", include_percent = FALSE) {
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package 'dplyr' is required. Please install it.", call. = FALSE)
  }

  # input checks
  if (!group_col %in% names(data)) {
    stop(paste("Column", group_col, "not found in data"))
  }
  if (!sales_col %in% names(data)) {
    stop(paste("Column", sales_col, "not found in data"))
  }

  # convert col names to symbols
  group <- rlang::sym(group_col)
  sales <- rlang::sym(sales_col)

  # computes summary
  summary_df <- data %>%
    dplyr::group_by(!!group) %>%
    dplyr::summarise(
      Total_Sales = sum(!!sales, na.rm = TRUE),
      Average_Sales = mean(!!sales, na.rm = TRUE),
      Min_Sales = min(!!sales, na.rm = TRUE),
      Max_Sales = max(!!sales, na.rm = TRUE),
      .groups = "drop"
    ) %>%
    dplyr::arrange(dplyr::desc(Total_Sales))

  # adds percentage if needed
  if (include_percent) {
    summary_df <- summary_df %>%
      dplyr::mutate(Percent_of_Total = round(Total_Sales / sum(Total_Sales) * 100, 2))
  }

  return(summary_df)
}
