# Metric module with summary

import("shiny")
import("dplyr")
import("htmltools")
import("glue")

export("ui")
export("init_server")

expose("constants.R")
expose("utilities/getFormatFigures.R")
expose("utilities/getMetricsChoices.R")
expose("utilities/getTimeFilterChoices.R")
expose("utilities/getDataByTimeRange.R")
expose("utilities/getPercentChangeSpan.R")

ui <- function(id) {
  ns <- NS(id)
  choices <- getMetricsChoicesByCategory(id)
  
  tagList(
    selectInput(
      ns("summary_metric"), "Metric",
      choices,
      width = NULL,
      selectize = TRUE,
      selected = choices[[1]]
    ),
    uiOutput(ns("summary"))
  )
}

init_server <- function(id, monthly_df, yearly_df,
                        y, m, previous_time_range) {
  callModule(server, id, monthly_df, yearly_df,
             y, m, previous_time_range)
}

server <- function(input, output, session, monthly_df, yearly_df,
                   y, m, previous_time_range) {
  
  metric <- reactive({ consts$metrics_list[[input$summary_metric]] })
  
  output$summary <- renderUI({
    if (m() == 0) {
      df <- yearly_df
      prev_timerange_suffix <- "prev_year"
    } else {
      df <- monthly_df
      prev_timerange_suffix <- previous_time_range()
    }
    
    selected_date <-
      paste(y(), ifelse(m() == "0", "1", m()), "01", "sep" = "-") %>% as.Date()
    row <- df[df$date == selected_date, ]
    
    is_recovery_metric <- grepl("recover_rate", metric()$id)
    
    metric_total_value <- 
      if (is_recovery_metric) {
        glue('<span class="metric">{format_percentage(row[, metric()$id])}</span>')
      }
      else {
        glue('<span class="metric">{format_number(row[, metric()$id])} <span class = "metric-label">travelers</span></span>')
      }
    
    invert_colors <- consts$metrics_list[[metric()$id]]$invert_colors
    metric_change_span <-
      row[, paste0(metric()$id, ".perc_", prev_timerange_suffix)] %>% 
      getPercentChangeSpan(invert_colors)
    

    # SVG graphics NOW selected from the custom icons
    HTML(glue::glue('
                  <img class="icon" src="assets/icons/{input$summary_metric}.svg" 
                    style="width: 44px; height: 44px; margin-right: 3px;"/>
                  {metric_total_value}
                  {metric_change_span}
                  '))
  })
}
