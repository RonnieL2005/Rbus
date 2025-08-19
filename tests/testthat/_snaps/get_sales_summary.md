# get_sales_summary snapshot basic summary

    Code
      result
    Output
      # A tibble: 2 x 5
        Category  Total_Sales Average_Sales Min_Sales Max_Sales
        <chr>           <dbl>         <dbl>     <dbl>     <dbl>
      1 Product A         500           250       200       300
      2 Product B         900           450       400       500

# get_sales_summary snapshot with percentages

    Code
      result
    Output
      # A tibble: 2 x 6
        Category Total_Sales Average_Sales Min_Sales Max_Sales Percent_of_Total
        <chr>          <dbl>         <dbl>     <dbl>     <dbl>            <dbl>
      1 X                100           100       100       100               25
      2 Y                300           300       300       300               75

