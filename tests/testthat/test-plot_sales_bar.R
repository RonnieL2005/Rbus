test_that("plot_sales_bar works with sample data", {
  sample_data <- data.frame(
    Category = c("Product A", "Product B"),
    Sales = c(100, 200)
  )

  p <- plot_sales_bar(sample_data)

  # Expectations
  expect_s3_class(p, "ggplot")       # It should return a ggplot
  expect_true("GeomBar" %in% sapply(p$layers, function(l) class(l$geom)[1]))
})

