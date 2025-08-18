test_that("plot_sales_trend works with and without category", {
  sample_data <- data.frame(
    Date = as.Date(c("2023-01-01","2023-02-01","2023-03-01")),
    Sales = c(200, 250, 300),
    Category = c("Product A", "Product B", "Product A")
  )

  # test without category
  p1 <- plot_sales_trend(sample_data, color = "red")
  expect_s3_class(p1, "ggplot")
  # check fixed color
  expect_equal(p1$layers[[1]]$aes_params$colour, "red")

  # test with category and custom palette
  palette <- c("Product A" = "blue", "Product B" = "green")
  p2 <- plot_sales_trend(sample_data, category_col = "Category", palette = palette)
  expect_s3_class(p2, "ggplot")
  # check if discrete scale is applied
  scales <- sapply(p2$scales$scales, function(s) class(s)[1])
  expect_true("ScaleDiscrete" %in% scales)
})
