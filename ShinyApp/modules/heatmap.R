# Calendar heatmap module

import("shiny")
import("calendR")
import("stats")
import("utils")
import("dplyr")
import("lubridate")
import("showtext")

export("ui")
export("init_server")

expose("utilities/getMetricsChoices.R")
expose("utilities/getFormatFigures.R")
expose("utilities/getTimeFilterChoices.R")
expose("utilities/getDataByTimeRange.R")
expose("utilities/getPercentChangeSpan.R")

consts <- use("constants.R")

# UI function
ui <- function(id) {
  ns <- NS(id)
  
  choices <- getMetricsChoices(names(consts$metrics_list), consts$metrics_list)
  
  tagList(
    div(
      class = "panel-header heatmap-header",
      selectInput(
        ns("metric"), "Metric",
        choices,
        width = NULL,
        selectize = TRUE,
        selected = choices[[1]]
      )
    ),
    div(
      class = "chart-heatmap-container",
      plotOutput(ns("calendar_plot"), width = "100%", height = "412px")
    )
  )
}

# Helper function to prepare named numeric vector for calendR
prepare_special_days <- function(daily_stats, year, metric_id) {
  all_days <- seq.Date(as.Date(paste0(year, "-01-01")),
                       as.Date(paste0(year, "-12-31")),
                       by = "day")
  
  daily_filtered <- daily_stats %>%
    filter(lubridate::year(as.Date(date)) == year) %>%
    select(date, all_of(metric_id))
  
  daily_filtered$date <- as.Date(daily_filtered$date)
  
  full_year_df <- data.frame(date = all_days) %>%
    left_join(daily_filtered, by = "date") %>%
    mutate(!!metric_id := ifelse(is.na(.data[[metric_id]]), 0, .data[[metric_id]]))
  
  day_vals <- full_year_df[[metric_id]]
  names(day_vals) <- as.character(full_year_df$date)
  
  return(day_vals)
}

# Server function
server <- function(input, output, session, df, y, m, previous_time_range) {
  
  metric <- reactive({ 
    req(input$metric)
    consts$metrics_list[[input$metric]] })
  
  output$calendar_plot <- renderPlot({
    req(metric(), metric()$id, y())
    
    daily_stats <- read.csv("data/daily_stats.csv")
    
    metric_id <- metric()$id
    
    day_vals <- prepare_special_days(daily_stats, y(), metric_id)
    
    is_recovery_metric <- grepl("recover_rate", metric_id)
    
    calendR(
      year = y(),
      special.days = day_vals,
      subtitle = if (is_recovery_metric) {
        "Ridership Recovery Rate Mapped to Days of The Week"
      } else {
        "Traveler Count Mapped to Days of The Week"
      },
      legend.pos = "right",
      legend.title = if (is_recovery_metric) {
        "Ridership Recovery Rate (%)
        "
      } else {
        "      Traveler Count
        "
      },
      low.col = "#B3B8BA",
      special.col = "#c27832",
      gradient = TRUE,
      orientation = "portrait",
      font.family = "Maven Pro"
      )
  })
}

# Initialization function to be called from app
init_server <- function(id, df, y, m, previous_time_range) {
  callModule(server, id, df, y, m, previous_time_range)
}
