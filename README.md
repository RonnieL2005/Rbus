# Rbus

Rbus is an R package for analyzing, visualizing, forecasting, and explaining retail sales data. It combines native R forecasting methods with Python FastAPI integration for advanced forecasting and natural-language explanations.

---

## Features

Data Import & Cleaning: Load and preprocess sales data.
Sales Summaries: Total and average sales, best/worst products, monthly trends.
Visualizations: Bar charts, pie charts, and line charts for sales analysis.

Forecasting:
R-based: `mean3`, `moving_avg`, `linear`/`lm`, `ets`
Python API-based: `ets` or `linear`, multiple months ahead
Explanations: Human-readable sales forecast insights via Python API.

---

## Installation

# Install devtools if needed
install.packages("devtools")

# Install Rbus from GitHub
devtools::install_github("RonnieL2005/Rbus")

---

## Usage

### Import Sales Data

```r
library(Rbus)

sales_data <- data.frame(
  Month = c("Jan", "Feb", "Mar", "Apr", "May", "Jun"),
  Sales = c(100, 200, 250, 300, 400, 420),
  Product = c("A", "B", "A", "C", "B", "A")
)
```

### Generate Sales Summary

```r
summary <- get_sales_summary(sales_data)
print(summary)
```

### Visualizations

```r
plot_sales_bar(sales_data)    # Bar chart
plot_sales_pie(sales_data)    # Pie chart
plot_sales_trend(sales_data)  # Line chart
```

### R-based Forecasting

predict_sales(sales_data, method = "mean3")   # Last 3 months average
predict_sales(sales_data, method = "linear")  # Linear regression
predict_sales(sales_data, method = "ets")     # Exponential smoothing

### Python API-based Forecasting

forecast_sales(
  sales = c(100, 200, 250, 300),
  method = "ets",
  months_ahead = 6,
  api_url = "https://rbus-api.onrender.com/forecast_sales"
)

### Generate Forecast Explanations

explain_sales(
  sales = c(100, 200, 250, 300),
  method = "ets",
  months_ahead = 6,
  api_url = "https://rbus-api.onrender.com/explain_sales"
)

---

## Example Workflow

# Load data
sales_data <- data.frame(
  Month = c("Jan", "Feb", "Mar", "Apr"),
  Sales = c(100, 200, 150, 300),
  Product = c("A", "B", "A", "C")
)

# Summarize sales
summary <- get_sales_summary(sales_data)

# Plot trend
plot_sales_trend(sales_data)

# R-based forecast
r_forecast <- predict_sales(sales_data, method = "linear")

# Python API-based forecast
api_forecast <- forecast_sales(sales_data$Sales, method = "ets", months_ahead = 3)

# Get explanation
explanation <- explain_sales(sales_data$Sales, method = "ets", months_ahead = 3)


---

## Dependencies

R packages**: `httr`, `jsonlite`, `forecast`, `ggplot2`, `dplyr`, `stats`, `scales`
Python FastAPI backend (optional) for advanced forecasting and explanations

---

## License

MIT License

---
