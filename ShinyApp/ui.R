# Load utility functions
source("utilities/getTimeFilterChoices.R")
source("utilities/getMetricsChoices.R")
source("utilities/getExternalLink.R")

# Load constant variables
consts <- use("constants.R")

# Html template used to render UI
htmlTemplate(
  "www/index.html",
   appTitle = consts$app_title,
  appVersion = consts$app_version,
  mainLogo = img(src = "assets/logos/afrikaniz3d.png", 
                 height = "30px"),
  dashboardLogo = img(src = "assets/logos/mta.svg", 
                      height = "90px",
                      style = "position: relative; top: -15px;"),
  selectYear = selectInput(
    "selected_year", "Year",
    choices = getYearChoices(consts$data_first_day, consts$data_last_day),
    selectize = TRUE
  ),
  selectMonth = selectInput(
    "selected_month", "Month",
    choices = getMonthsChoices(year = NULL, consts$data_last_day),
    selected = month(consts$data_last_day),
    selectize = TRUE
  ),
  previousTimeRange = selectInput(
    "previous_time_range", "Compare to",
    choices = consts$prev_time_range_choices,
    selected = "prev_year",
    selectize = TRUE
 ),
  prepandemicSummary1 = metric_summary$ui("prepandemic_ridership_1"),
  prepandemicSummary2 = metric_summary$ui("prepandemic_ridership_2"),
  postpandemicSummary1 = metric_summary$ui("postpandemic_ridership_1"),
  postpandemicSummary2 = metric_summary$ui("postpandemic_ridership_2"),
  recoverySummary1 = metric_summary$ui("recovery_1"),
  recoverySummary2 = metric_summary$ui("recovery_2"),
  heatmap = heatmap$ui("heatmap"),
  timeChart = time_chart$ui("time_chart"),
  marketplace_website = consts$marketplace_website,
  blogfolio = consts$blogfolio
)
