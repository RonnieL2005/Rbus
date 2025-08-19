test_that("predict_sales works with mean3 method", {
  data <- data.frame(
    Month = c("Jan", "Feb", "Mar", "Apr"),
    Sales = c(100, 200, 300, 400)
  )
  result <- predict_sales(data, method = "mean3")
  expect_equal(result, mean(c(200, 300, 400)))
})

test_that("predict_sales works with moving average method", {
  data <- data.frame(
    Month = c("Jan", "Feb", "Mar", "Apr", "May"),
    Sales = c(10, 20, 30, 40, 50)
  )
  result <- predict_sales(data, method = "moving_avg", window =2)
  expect_equal(result, mean(c(40, 50)))
})

test_that("predict_sales works with linear regression method", {
  data <- data.frame(
    Month = c("Jan", "Feb", "Mar", "Apr"),
    Sales = c(100, 200, 300, 400)
  )
  result <- predict_sales(data, method = "lm")
  expect_true(is.numeric(result))
  expect_length(result, 1)
})

test_that("predict_sales works with ETS method (tolerance check)", {
  data <- data.frame(
    Month = 1:12,
    Sales = c(100, 120, 130, 150, 160, 170, 180, 200, 210, 220, 230, 240)
  )
  result <- predict_sales(data, method = "ets")
  expect_true(is.numeric(result))
  expect_length(result, 1)
  expect_true(result > 0) # sanity check
})

test_that("predict_sales handles missing Sales column", {
  data <- data.frame(Month = c("Jan", "Feb"))
  expect_error(predict_sales(data), "Input data must contain a 'Sales' column.")
})

test_that("predict_sales handles non-numeric Sales", {
  data <- data.frame(Month = c("Jan", "Feb"), Sales = c("A", "B"))
  expect_error(predict_sales(data), "'Sales' column must be numeric.")
})

test_that("predict_sales handles too few rows", {
  data <- data.frame(Month = "Jan", Sales = 100)
  expect_error(predict_sales(data), "Not enough data to make a prediction")
})

