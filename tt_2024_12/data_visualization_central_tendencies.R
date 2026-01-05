-- total issues summary line chart

library(readr)
library(echarts4r)
library(crosstalk)
library(dplyr)
library(htmlwidgets)

ct_total_issues <- read_csv("data/ct_total_issues.csv")

ct_total_issues |>
  e_charts(decade) |>
  e_line(
    mean, 
    name = "Mean",
    smooth = TRUE) |>
  e_line(
    median, 
    name = "Median",
    smooth = TRUE) |>
  e_line(
    mode,
    name = "Mode",
    smooth = TRUE) |>
  e_line(
    sd,
    name = "Standard Deviation",
    smooth = TRUE) |>
  e_line(
    min,
    name = "Minimum",
    smooth = TRUE) |>
  e_line(
    max,
    name = "Maximum",
    smooth = TRUE) |>
  e_line(
    p25,
    name = "25th Percentile",
    smooth = TRUE) |>
  e_line(
    p75,
    name = "75th Percentile",
    smooth = TRUE) |>

  e_x_axis(
    type = "category",
    name = "Decades",
    nameLocation = "middle",
    nameGap = 40,
    nameTextStyle = list(
      fontSize = 16,
      fontWeight = "bold"),
    fontSize = 14,
    fontWeight = "bold",
    margin = 10) |>
  e_y_axis(
    name = "Number of Issues",
    nameLocation = "middle",
    nameRotate = 90,
    nameGap = 50,
    nameTextStyle = list(
      fontSize = 16,
      fontWeight = "bold"),
    axisLabel = list(fontSize = 14)
  ) |>
  e_grid(
    bottom = "60",  
    left = "10%",    
    right = "5%",
    top = "20%"
  ) |>
  
  e_tooltip(
    trigger = "axis",
    backgroundColor = "rgba(255,255,255,0.9)",
    textStyle = list(color = "#333333")) |>
  
  e_legend(
    top = "15%",
    right = "5%") |>
  
  e_grid(
    top = "20%",
    left = "5%", 
    right = "5%", 
    bottom = "160") |>
  
  e_title("Summary Statistics: Total Issues Sold") |>
  
  e_theme(
    "grey") 


-- appearance percentages summary line chart

library(readr)
library(echarts4r)
library(crosstalk)
library(dplyr)
library(htmlwidgets)

ct_total_issues <- read_csv("data/ct_appearance_percentage.csv")

ct_total_issues |>
  e_charts(decade) |>
  e_line(
    mean, 
    name = "Mean",
    smooth = TRUE) |>
  e_line(
    median, 
    name = "Median",
    smooth = TRUE) |>
  e_line(
    mode,
    name = "Mode",
    smooth = TRUE) |>
  e_line(
    sd,
    name = "Standard Deviation",
    smooth = TRUE) |>
  e_line(
    min,
    name = "Minimum",
    smooth = TRUE) |>
  e_line(
    max,
    name = "Maximum",
    smooth = TRUE) |>
  e_line(
    p25,
    name = "25th Percentile",
    smooth = TRUE) |>
  e_line(
    p75,
    name = "75th Percentile",
    smooth = TRUE) |>

  e_x_axis(
    type = "category",
    name = "Decades",
    nameLocation = "middle",
    nameGap = 40,
    nameTextStyle = list(
      fontSize = 16,
      fontWeight = "bold"),
    fontSize = 14,
    fontWeight = "bold",
    margin = 10) |>
  e_y_axis(
    name = "Percentage",
    nameLocation = "middle",
    nameRotate = 90,
    nameGap = 50,
    nameTextStyle = list(
      fontSize = 16,
      fontWeight = "bold"),
    axisLabel = list(fontSize = 14)
  ) |>
  e_grid(
    bottom = "60",  
    left = "10%",    
    right = "5%",
    top = "20%"
  ) |>
  
  e_tooltip(
    trigger = "axis",
    backgroundColor = "rgba(255,255,255,0.9)",
    textStyle = list(color = "#333333")) |>
  
  e_legend(
    top = "10%",
    right = "5%") |>
  
  e_grid(
    top = "20%",
    left = "5%", 
    right = "5%", 
    bottom = "50") |>
  
  e_title("Summary Statistics: Appearance Percentages") |>
  
  e_theme(
    "grey") 


-- total_value heritage summary line chart

library(readr)
library(echarts4r)
library(crosstalk)
library(dplyr)
library(htmlwidgets)

ct_total_issues <- read_csv("data/ct_total_value_heritage.csv")

ct_total_issues |>
  e_charts(decade) |>
  e_line(
    mean, 
    name = "Mean",
    smooth = TRUE) |>
  e_line(
    median, 
    name = "Median",
    smooth = TRUE) |>
  e_line(
    mode,
    name = "Mode",
    smooth = TRUE) |>
  e_line(
    sd,
    name = "Standard Deviation",
    smooth = TRUE) |>
  e_line(
    min,
    name = "Minimum",
    smooth = TRUE) |>
  e_line(
    max,
    name = "Maximum",
    smooth = TRUE) |>
  e_line(
    p25,
    name = "25th Percentile",
    smooth = TRUE) |>
  e_line(
    p75,
    name = "75th Percentile",
    smooth = TRUE) |>

  e_x_axis(
    type = "category",
    name = "Decades",
    nameLocation = "middle",
    nameGap = 40,
    nameTextStyle = list(
      fontSize = 16,
      fontWeight = "bold"),
    fontSize = 14,
    fontWeight = "bold",
    margin = 10) |>
  e_y_axis(
    name = "Revenue ($)",
    nameLocation = "middle",
    nameRotate = 90,
    nameGap = 80,
    nameTextStyle = list(
      fontSize = 16,
      fontWeight = "bold"),
    axisLabel = list(fontSize = 14)
  ) |>
  e_grid(
    bottom = "60",  
    left = "10%",    
    right = "5%",
    top = "20%"
  ) |>
  
  e_tooltip(
    trigger = "axis",
    backgroundColor = "rgba(255,255,255,0.9)",
    textStyle = list(color = "#333333")) |>
  
  e_legend(
    top = "10%",
    right = "5%") |>
  
  e_grid(
    top = "20%",
    left = "5%", 
    right = "5%", 
    bottom = "50") |>
  
  e_title("Summary Statistics: Total Value | Heritage") |>
  
  e_theme(
    "grey") 


-- ppi heritage summary line chart

library(readr)
library(echarts4r)
library(crosstalk)
library(dplyr)
library(htmlwidgets)

ct_total_issues <- read_csv("data/ct_ppi_heritage.csv")

ct_total_issues |>
  e_charts(decade) |>
  e_line(
    mean, 
    name = "Mean",
    smooth = TRUE) |>
  e_line(
    median, 
    name = "Median",
    smooth = TRUE) |>
  e_line(
    mode,
    name = "Mode",
    smooth = TRUE) |>
  e_line(
    sd,
    name = "Standard Deviation",
    smooth = TRUE) |>
  e_line(
    min,
    name = "Minimum",
    smooth = TRUE) |>
  e_line(
    max,
    name = "Maximum",
    smooth = TRUE) |>
  e_line(
    p25,
    name = "25th Percentile",
    smooth = TRUE) |>
  e_line(
    p75,
    name = "75th Percentile",
    smooth = TRUE) |>

  e_x_axis(
    type = "category",
    name = "Decades",
    nameLocation = "middle",
    nameGap = 40,
    nameTextStyle = list(
      fontSize = 16,
      fontWeight = "bold"),
    fontSize = 14,
    fontWeight = "bold",
    margin = 10) |>
  e_y_axis(
    name = "Price ($)",
    nameLocation = "middle",
    nameRotate = 90,
    nameGap = 80,
    nameTextStyle = list(
      fontSize = 16,
      fontWeight = "bold"),
    axisLabel = list(fontSize = 14)
  ) |>
  e_grid(
    bottom = "60",  
    left = "10%",    
    right = "5%",
    top = "20%"
  ) |>
  
  e_tooltip(
    trigger = "axis",
    backgroundColor = "rgba(255,255,255,0.9)",
    textStyle = list(color = "#333333")) |>
  
  e_legend(
    top = "10%",
    right = "5%") |>
  
  e_grid(
    top = "20%",
    left = "5%", 
    right = "5%", 
    bottom = "50") |>
  
  e_title("Summary Statistics: Price Per Issue | Heritage") |>
  
  e_theme(
    "grey") 


-- total_value ebay summary line chart

library(readr)
library(echarts4r)
library(crosstalk)
(library(dplyr)
library(htmlwidgets)

ct_total_issues <- read_csv("data/ct_total_value_ebay.csv")

ct_total_issues |>
  e_charts(decade) |>
  e_line(
    mean, 
    name = "Mean",
    smooth = TRUE) |>
  e_line(
    median, 
    name = "Median",
    smooth = TRUE) |>
  e_line(
    mode,
    name = "Mode",
    smooth = TRUE) |>
  e_line(
    sd,
    name = "Standard Deviation",
    smooth = TRUE) |>
  e_line(
    min,
    name = "Minimum",
    smooth = TRUE) |>
  e_line(
    max,
    name = "Maximum",
    smooth = TRUE) |>
  e_line(
    p25,
    name = "25th Percentile",
    smooth = TRUE) |>
  e_line(
    p75,
    name = "75th Percentile",
    smooth = TRUE) |>

  e_x_axis(
    type = "category",
    name = "Decades",
    nameLocation = "middle",
    nameGap = 40,
    nameTextStyle = list(
      fontSize = 16,
      fontWeight = "bold"),
    fontSize = 14,
    fontWeight = "bold",
    margin = 10) |>
  e_y_axis(
    name = "Revenue ($)",
    nameLocation = "middle",
    nameRotate = 90,
    nameGap = 80,
    nameTextStyle = list(
      fontSize = 16,
      fontWeight = "bold"),
    axisLabel = list(fontSize = 14)
  ) |>
  e_grid(
    bottom = "60",  
    left = "10%",    
    right = "5%",
    top = "20%"
  ) |>
  
  e_tooltip(
    trigger = "axis",
    backgroundColor = "rgba(255,255,255,0.9)",
    textStyle = list(color = "#333333")) |>
  
  e_legend(
    top = "10%",
    right = "5%") |>
  
  e_grid(
    top = "20%",
    left = "5%", 
    right = "5%", 
    bottom = "50") |>
  
  e_title("Summary Statistics: Total Value | Ebay") |>
  
  e_theme(
    "grey") 


-- ppi ebay summary line chart

library(readr)
library(echarts4r)
library(crosstalk)
library(dplyr)
library(htmlwidgets)

ct_total_issues <- read_csv("data/ct_ppi_ebay.csv")

ct_total_issues |>
  e_charts(decade) |>
  e_line(
    mean, 
    name = "Mean",
    smooth = TRUE) |>
  e_line(
    median, 
    name = "Median",
    smooth = TRUE) |>
  e_line(
    mode,
    name = "Mode",
    smooth = TRUE) |>
  e_line(
    sd,
    name = "Standard Deviation",
    smooth = TRUE) |>
  e_line(
    min,
    name = "Minimum",
    smooth = TRUE) |>
  e_line(
    max,
    name = "Maximum",
    smooth = TRUE) |>
  e_line(
    p25,
    name = "25th Percentile",
    smooth = TRUE) |>
  e_line(
    p75,
    name = "75th Percentile",
    smooth = TRUE) |>

  e_x_axis(
    type = "category",
    name = "Decades",
    nameLocation = "middle",
    nameGap = 40,
    nameTextStyle = list(
      fontSize = 16,
      fontWeight = "bold"),
    fontSize = 14,
    fontWeight = "bold",
    margin = 10) |>
  e_y_axis(
    name = "Price ($)",
    nameLocation = "middle",
    nameRotate = 90,
    nameGap = 80,
    nameTextStyle = list(
      fontSize = 16,
      fontWeight = "bold"),
    axisLabel = list(fontSize = 14)
  ) |>
  e_grid(
    bottom = "60",  
    left = "10%",    
    right = "5%",
    top = "20%"
  ) |>
  
  e_tooltip(
    trigger = "axis",
    backgroundColor = "rgba(255,255,255,0.9)",
    textStyle = list(color = "#333333")) |>
  
  e_legend(
    top = "10%",
    right = "5%") |>
  
  e_grid(
    top = "20%",
    left = "5%", 
    right = "5%", 
    bottom = "50") |>
  
  e_title("Summary Statistics: Price Per Issue | Ebay") |>
  
  e_theme(
    "grey") 


 -- total_value wizard summary line chart

library(readr)
library(echarts4r)
library(crosstalk)
library(dplyr)
library(htmlwidgets)

ct_total_issues <- read_csv("data/ct_total_value_wizard.csv")

ct_total_issues |>
  e_charts(decade) |>
  e_line(
    mean, 
    name = "Mean",
    smooth = TRUE) |>
  e_line(
    median, 
    name = "Median",
    smooth = TRUE) |>
  e_line(
    mode,
    name = "Mode",
    smooth = TRUE) |>
  e_line(
    sd,
    name = "Standard Deviation",
    smooth = TRUE) |>
  e_line(
    min,
    name = "Minimum",
    smooth = TRUE) |>
  e_line(
    max,
    name = "Maximum",
    smooth = TRUE) |>
  e_line(
    p25,
    name = "25th Percentile",
    smooth = TRUE) |>
  e_line(
    p75,
    name = "75th Percentile",
    smooth = TRUE) |>

  e_x_axis(
    type = "category",
    name = "Decades",
    nameLocation = "middle",
    nameGap = 40,
    nameTextStyle = list(
      fontSize = 16,
      fontWeight = "bold"),
    fontSize = 14,
    fontWeight = "bold",
    margin = 10) |>
  e_y_axis(
    name = "Revenue ($)",
    nameLocation = "middle",
    nameRotate = 90,
    nameGap = 80,
    nameTextStyle = list(
      fontSize = 16,
      fontWeight = "bold"),
    axisLabel = list(fontSize = 14)
  ) |>
  e_grid(
    bottom = "60",  
    left = "10%",    
    right = "5%",
    top = "20%"
  ) |>
  
  e_tooltip(
    trigger = "axis",
    backgroundColor = "rgba(255,255,255,0.9)",
    textStyle = list(color = "#333333")) |>
  
  e_legend(
    top = "10%",
    right = "5%") |>
  
  e_grid(
    top = "20%",
    left = "5%", 
    right = "5%", 
    bottom = "50") |>
  
  e_title("Summary Statistics: Total Value | Wizard") |>
  
  e_theme(
    "grey") 


 -- ppi wizard summary line chart

library(readr)
library(echarts4r)
library(crosstalk)
library(dplyr)
library(htmlwidgets)

ct_total_issues <- read_csv("data/ct_ppi_wizard.csv")

ct_total_issues |>
  e_charts(decade) |>
  e_line(
    mean, 
    name = "Mean",
    smooth = TRUE) |>
  e_line(
    median, 
    name = "Median",
    smooth = TRUE) |>
  e_line(
    mode,
    name = "Mode",
    smooth = TRUE) |>
  e_line(
    sd,
    name = "Standard Deviation",
    smooth = TRUE) |>
  e_line(
    min,
    name = "Minimum",
    smooth = TRUE) |>
  e_line(
    max,
    name = "Maximum",
    smooth = TRUE) |>
  e_line(
    p25,
    name = "25th Percentile",
    smooth = TRUE) |>
  e_line(
    p75,
    name = "75th Percentile",
    smooth = TRUE) |>

  e_x_axis(
    type = "category",
    name = "Decades",
    nameLocation = "middle",
    nameGap = 40,
    nameTextStyle = list(
      fontSize = 16,
      fontWeight = "bold"),
    fontSize = 14,
    fontWeight = "bold",
    margin = 10) |>
  e_y_axis(
    name = "Price ($)",
    nameLocation = "middle",
    nameRotate = 90,
    nameGap = 80,
    nameTextStyle = list(
      fontSize = 16,
      fontWeight = "bold"),
    axisLabel = list(fontSize = 14)
  ) |>
  e_grid(
    bottom = "60",  
    left = "10%",    
    right = "5%",
    top = "20%"
  ) |>
  
  e_tooltip(
    trigger = "axis",
    backgroundColor = "rgba(255,255,255,0.9)",
    textStyle = list(color = "#333333")) |>
  
  e_legend(
    top = "10%",
    right = "5%") |>
  
  e_grid(
    top = "20%",
    left = "5%", 
    right = "5%", 
    bottom = "50") |>
  
  e_title("Summary Statistics: Price Per Issue | Wizard") |>
  
  e_theme(
    "grey") 


 -- total_value overstreet summary line chart

library(readr)
library(echarts4r)
library(crosstalk)
library(dplyr)
library(htmlwidgets)

ct_total_issues <- read_csv("data/ct_total_value_overstreet.csv")

ct_total_issues |>
  e_charts(decade) |>
  e_line(
    mean, 
    name = "Mean",
    smooth = TRUE) |>
  e_line(
    median, 
    name = "Median",
    smooth = TRUE) |>
  e_line(
    mode,
    name = "Mode",
    smooth = TRUE) |>
  e_line(
    sd,
    name = "Standard Deviation",
    smooth = TRUE) |>
  e_line(
    min,
    name = "Minimum",
    smooth = TRUE) |>
  e_line(
    max,
    name = "Maximum",
    smooth = TRUE) |>
  e_line(
    p25,
    name = "25th Percentile",
    smooth = TRUE) |>
  e_line(
    p75,
    name = "75th Percentile",
    smooth = TRUE) |>

  e_x_axis(
    type = "category",
    name = "Decades",
    nameLocation = "middle",
    nameGap = 40,
    nameTextStyle = list(
      fontSize = 16,
      fontWeight = "bold"),
    fontSize = 14,
    fontWeight = "bold",
    margin = 10) |>
  e_y_axis(
    name = "Revenue ($)",
    nameLocation = "middle",
    nameRotate = 90,
    nameGap = 80,
    nameTextStyle = list(
      fontSize = 16,
      fontWeight = "bold"),
    axisLabel = list(fontSize = 14)
  ) |>
  e_grid(
    bottom = "60",  
    left = "10%",    
    right = "5%",
    top = "20%"
  ) |>
  
  e_tooltip(
    trigger = "axis",
    backgroundColor = "rgba(255,255,255,0.9)",
    textStyle = list(color = "#333333")) |>
  
  e_legend(
    top = "10%",
    right = "5%") |>
  
  e_grid(
    top = "20%",
    left = "5%", 
    right = "5%", 
    bottom = "50") |>
  
  e_title("Summary Statistics: Total Value | Overstreet") |>
  
  e_theme(
    "grey") 


 -- ppi overstreet summary line chart

library(readr)
library(echarts4r)
library(crosstalk)
library(dplyr)
library(htmlwidgets)

ct_total_issues <- read_csv("data/ct_ppi_overstreet.csv")

ct_total_issues |>
  e_charts(decade) |>
  e_line(
    mean, 
    name = "Mean",
    smooth = TRUE) |>
  e_line(
    median, 
    name = "Median",
    smooth = TRUE) |>
  e_line(
    mode,
    name = "Mode",
    smooth = TRUE) |>
  e_line(
    sd,
    name = "Standard Deviation",
    smooth = TRUE) |>
  e_line(
    min,
    name = "Minimum",
    smooth = TRUE) |>
  e_line(
    max,
    name = "Maximum",
    smooth = TRUE) |>
  e_line(
    p25,
    name = "25th Percentile",
    smooth = TRUE) |>
  e_line(
    p75,
    name = "75th Percentile",
    smooth = TRUE) |>

  e_x_axis(
    type = "category",
    name = "Decades",
    nameLocation = "middle",
    nameGap = 40,
    nameTextStyle = list(
      fontSize = 16,
      fontWeight = "bold"),
    fontSize = 14,
    fontWeight = "bold",
    margin = 10) |>
  e_y_axis(
    name = "Price ($)",
    nameLocation = "middle",
    nameRotate = 90,
    nameGap = 80,
    nameTextStyle = list(
      fontSize = 16,
      fontWeight = "bold"),
    axisLabel = list(fontSize = 14)
  ) |>
  e_grid(
    bottom = "60",  
    left = "10%",    
    right = "5%",
    top = "20%"
  ) |>
  
  e_tooltip(
    trigger = "axis",
    backgroundColor = "rgba(255,255,255,0.9)",
    textStyle = list(color = "#333333")) |>
  
  e_legend(
    top = "10%",
    right = "5%") |>
  
  e_grid(
    top = "20%",
    left = "5%", 
    right = "5%", 
    bottom = "50") |>
  
  e_title("Summary Statistics: Price Per Issue | Overstreet") |>
  
  e_theme(
    "grey") 
