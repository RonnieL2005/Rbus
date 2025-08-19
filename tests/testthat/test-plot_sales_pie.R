test_that("plot_sales_pie() works correctly", {
  # Example dataset
  df <- data.frame(
    Category = c("A", "B", "A", "C"),
    Sales = c(100, 200, 150, 50)
  )

  # Call the function
  p <- plot_sales_pie(df, "Category", "Sales")

  # 1. Check that the output is a ggplot object
  expect_s3_class(p, "ggplot")

  # 2. Check that required columns exist in the processed data
  processed <- df %>%
    dplyr::group_by(Category) %>%
    dplyr::summarise(TotalSales = sum(Sales), .groups = "drop") %>%
    dplyr::mutate(
      Percent = TotalSales / sum(TotalSales) * 100,
      Label = paste0(Category, " (", round(Percent, 1), "%)")
    )

  expect_true(all(processed$TotalSales > 0))
  expect_equal(round(sum(processed$Percent), 0), 100) # percentages sum to ~100

  # 3. vdiffr to test the visual regression
  vdiffr::expect_doppelganger("Pie chart of sales by category", p)
})
