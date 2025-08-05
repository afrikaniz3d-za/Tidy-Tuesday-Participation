daily_stats <- read.csv("data/daily_stats.csv", header = TRUE, stringsAsFactors = TRUE) %>%
  mutate(date = ymd(date))

monthly_stats <- read.csv("data/monthly_stats.csv", header = TRUE) %>%
  mutate(date = ymd(date))

yearly_stats <- read.csv("data/yearly_stats.csv", header = TRUE) %>%
  mutate(date = ymd(date))


server <- function(input, output, session) {
  observeEvent(c(input$selected_year), {
    months_choices <-
      getMonthsChoices(input$selected_year, consts$data_last_day)
    selected_month <-
      ifelse(input$selected_month %in% months_choices,
        input$selected_month,
        "0"
      )
    updateSelectInput(session,
      "selected_month", 
      selected = selected_month,
      choices = months_choices
    )
  })
  
  observeEvent(c(input$selected_month), {
    if (input$selected_month == "0") {
      updateSelectInput(
        session,
        "previous_time_range",
        choices = consts$prev_time_range_choices["Previous Year"],
        selected = consts$prev_time_range_choices[["Previous Year"]]
      )
    } else {
      updateSelectInput(
        session,
        "previous_time_range",
        choices = consts$prev_time_range_choices,
        selected = input$previous_time_range
      )
    }
  })

  selected_year <- reactive({ input$selected_year })
  selected_month <- reactive({ input$selected_month })
  previous_time_range <- reactive({ input$previous_time_range })

  # Inititalize all modules
  metric_summary$init_server("prepandemic_ridership_1",
                             monthly_df = monthly_stats,
                             yearly_df = yearly_stats,
                             y = selected_year,
                             m = selected_month,
                             previous_time_range = previous_time_range)
  metric_summary$init_server("prepandemic_ridership_2",
                             monthly_df = monthly_stats,
                             yearly_df = yearly_stats,
                             y = selected_year,
                             m = selected_month,
                             previous_time_range = previous_time_range)
  metric_summary$init_server("postpandemic_ridership_1",
                             monthly_df = monthly_stats,
                             yearly_df = yearly_stats,
                             y = selected_year,
                             m = selected_month,
                             previous_time_range = previous_time_range)
  metric_summary$init_server("postpandemic_ridership_2",
                             monthly_df = monthly_stats,
                             yearly_df = yearly_stats,
                             y = selected_year,
                             m = selected_month,
                             previous_time_range = previous_time_range)
  metric_summary$init_server("recovery_1",
                             monthly_df = monthly_stats,
                             yearly_df = yearly_stats,
                             y = selected_year,
                             m = selected_month,
                             previous_time_range = previous_time_range)
  metric_summary$init_server("recovery_2",
                             monthly_df = monthly_stats,
                             yearly_df = yearly_stats,
                             y = selected_year,
                             m = selected_month,
                             previous_time_range = previous_time_range)
  time_chart$init_server("time_chart",
                            df = daily_stats,
                            y = selected_year,
                            m = selected_month,
                            previous_time_range = previous_time_range)
  heatmap$init_server("heatmap",
                      df = daily_stats,
                      y = selected_year,
                      m = selected_month,
                      previous_time_range = previous_time_range)
}