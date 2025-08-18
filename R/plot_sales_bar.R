#' Plot Sales as a Bar Chart
#'
#' This function takes a sales dataset and produces a clean bar chart
#' of sales by category.
#'
#' @param data A data.frame containing sales data.
#' @param category_col The column name for categories (default: "Category").
#' @param sales_col The column name for sales values (default: "Sales").
#' @param palette Optional vector of colors for the bars.
#' @return A ggplot object representing the bar chart.
#' @examples
#' sample_data <- data.frame(
#'   Category = c("Product A", "Product B", "Product C"),
#'   Sales = c(120, 80, 150)
#' )
#' plot_sales_bar(sample_data, palette = c("red", "green", "blue"))
#' @export
plot_sales_bar <- function(data, category_col = "Category", sales_col = "Sales", palette = NULL) {
  # checks required packages
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Package 'ggplot2' is required. Please install it.", call. = FALSE)
  }

  # Converts column names to symbols
  category <- rlang::sym(category_col)
  sales <- rlang::sym(sales_col)

  # Creates the plot
  p <- ggplot2::ggplot(data, ggplot2::aes(x = !!category, y = !!sales, fill = !!category)) +
    ggplot2::geom_bar(stat = "identity", width = 0.6) +
    ggplot2::labs(
      title = "Sales by Category",
      x = "Category",
      y = "Sales"
    ) +
    ggplot2::theme_minimal() +
    ggplot2::theme(
      legend.position = "none",
      plot.title = ggplot2::element_text(hjust = 0.5, face = "bold")
    )
  # Apply palette if provided
  if(!is.null(palette)){
    p <- p + ggplot2::scale_fill_manual(values = palette)
  }

  return(p)
}
