#' Import Sales Data from Excel
#'
#' Reads business/sales data from an Excel file into a tidy dataframe.
#'
#' @param file Path to the Excel file.
#' @param sheet Sheet name or index (default = 1).
#' @param range Optional cell range (e.g., "A1:D20").
#' @return A tibble with cleaned column names.
#' @examples
#' # data <- import_sales_data("sales.xlsx", sheet = "Q1")
import_sales_data <- function(file, sheet = 1, range = NULL){
  data <- readxl::read_excel(file, sheet = sheet, range = range)
  data <- janitor::clean_names(data)
  return(data)
}
