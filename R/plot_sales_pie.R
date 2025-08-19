#' Plot Sales Contribution by Category (Pie Chart)
#'
#' This function creates a pie chart showing the proportion of total sales
#' contributed by each category.
#'
#' @param data A data.frame containing sales data.
#' @param category_col The column name for categories (default: "Category").
#' @param sales_col The column name for sales values (default: "Sales").
#' @return A ggplot object representing the sales pie chart.
#' @examples
#' sample_data <- data.frame(
#'   Category = c("Product A", "Product B", "Product C"),
#'   Sales = c(300, 500, 200)
#' )
#' plot_sales_pie(sample_data)
#' @export
plot_sales_pie <- function(data, category_col = "Category", sales_col = "Sales") {
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Package 'ggplot2' is required. Please install it.", call. = FALSE)
  }
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package 'dplyr' is required. Please install it.", call. = FALSE)
  }

  # convert col names to symbols
  category <- rlang::sym(category_col)
  sales <- rlang::sym(sales_col)

  # aggregate data
  df <- data %>%
    dplyr::group_by(!!category) %>%
    dplyr::summarise(TotalSales = sum(!!sales, na.rm = TRUE)) %>%
    dplyr::ungroup()

  # calculate percentage
  df <- df %>%
    dplyr::mutate(Percent = TotalSales / sum(TotalSales) * 100,
                  Label = paste0(!!category, " (", round(Percent, 1), "%)"))

  # plot
  p <- ggplot2::ggplot(df, ggplot2::aes(x = "", y = TotalSales, fill = !!category)) +
    ggplot2::geom_col(width = 1, color = "white") +
    ggplot2::coord_polar(theta = "y") +
    ggplot2::labs(title = "Sales Contribution by Category", fill = "Category") +
    ggplot2::theme_void() +
    ggplot2::geom_text(
      ggplot2::aes(label = paste0(round(Percent, 1), "%")),
      position = ggplot2::position_stack(vjust = 0.5)
    )

  return(p)
}

