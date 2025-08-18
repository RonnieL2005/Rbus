test_that("import_sales_data reads CSV correctly", {
  # Create a small CSV file
  tmp <- tempfile(fileext = ".csv")
  write.csv(data.frame(Category = c("A", "B"), Sales = c(10, 20)),
            tmp, row.names = FALSE)

  # Import using your function
  df <- import_sales_data(tmp)
  colnames(df)

  # Expectations
  expect_s3_class(df, "data.frame")
  expect_equal(ncol(df), 2)
  expect_equal(sum(df$sales), 30)
})
