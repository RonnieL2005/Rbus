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
import_sales_data <- function(file, sheet = 1, range = NULL) {
  # Load the data based on file extension
  if (grepl("\\.csv$", file, ignore.case = TRUE)) {
    data <- read.csv(file, stringsAsFactors = FALSE)
  } else if (grepl("\\.xlsx?$", file, ignore.case = TRUE)) {
    data <- readxl::read_excel(file, sheet = sheet, range = range)
  } else {
    stop("Unsupported file format: please provide .csv, .xls, or .xlsx")
  }

  # Clean column names
  data <- janitor::clean_names(data)

  # Convert numeric-like columns to numeric
  for (col in names(data)) {
    # Only check character or factor columns
    if (is.character(data[[col]]) || is.factor(data[[col]])) {
      # Remove whitespace
      data[[col]] <- trimws(as.character(data[[col]]))
      # Check if all values are numeric-looking
      if (all(grepl("^[-+]?[0-9]*\\.?[0-9]+$", data[[col]]))) {
        data[[col]] <- as.numeric(data[[col]])
      }
    }
  }

  return(data)
}




