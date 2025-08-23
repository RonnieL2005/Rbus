test_that("forecast_sales works with real API", {
  sales_data <- c(200, 250, 300, 400)

  result <- forecast_sales(
    sales = sales_data,
    months_ahead = 6,
    method = "ets",
    api_url = "https://rbus-api.onrender.com/forecast_sales"
  )

  expect_type(result, "double")
  expect_true(length(result) > 0)
})
