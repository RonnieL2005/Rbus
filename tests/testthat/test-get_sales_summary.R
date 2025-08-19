test_that("get_sales_summary works with default parameters", {
  sample_data <- data.frame(
    Category = c("Product A", "Product B", "Product A", "Product B"),
    Sales = c(300, 500, 200, 400)
  )

  result <- get_sales_summary(sample_data)
  result <- result[order(result$Category), ]  # enforce order

  expect_s3_class(result, "data.frame")
  expect_true(all(c("Total_Sales", "Average_Sales", "Min_Sales", "Max_Sales") %in% names(result)))
  expect_equal(result$Total_Sales[result$Category == "Product A"], 500)  # A has 300+200
  expect_equal(result$Total_Sales[result$Category == "Product B"], 900)  # B has 500+400
})

test_that("get_sales_summary includes percentages when requested", {
  sample_data <- data.frame(
    Category = c("X", "Y"),
    Sales = c(100, 300)
  )

  result <- get_sales_summary(sample_data, include_percent = TRUE)
  result <- result[order(result$Category), ]  # enforce order

  expect_true("Percent_of_Total" %in% names(result))
  expect_equal(result$Percent_of_Total[result$Category == "Y"], 75) # Y has 300 / 400
  expect_equal(result$Percent_of_Total[result$Category == "X"], 25) # X has 100 / 400
})

test_that("get_sales_summary errors on invalid column names", {
  bad_data <- data.frame(Product = c("A", "B"), Amount = c(10, 20))

  expect_error(get_sales_summary(bad_data, group_col = "Category"))
  expect_error(get_sales_summary(bad_data, sales_col = "Sales"))
})

test_that("get_sales_summary handles NA values correctly", {
  sample_data <- data.frame(
    Category = c("A", "A", "B"),
    Sales = c(100, NA, 200)
  )

  result <- get_sales_summary(sample_data)
  result <- result[order(result$Category), ]  # enforce order

  expect_equal(result$Total_Sales[result$Category == "A"], 100)
  expect_equal(result$Total_Sales[result$Category == "B"], 200)
})

test_that("get_sales_summary snapshot basic summary", {
  sample_data <- data.frame(
    Category = c("Product A", "Product B", "Product A", "Product B"),
    Sales = c(300, 500, 200, 400)
  )

  result <- get_sales_summary(sample_data)
  result <- result[order(result$Category), ]  # enforce order

  # Snapshots the data frame output
  expect_snapshot(result)
})

test_that("get_sales_summary snapshot with percentages", {
  sample_data <- data.frame(
    Category = c("X", "Y"),
    Sales = c(100, 300)
  )

  result <- get_sales_summary(sample_data, include_percent = TRUE)
  result <- result[order(result$Category), ]  # enforce order

  expect_snapshot(result)
})

