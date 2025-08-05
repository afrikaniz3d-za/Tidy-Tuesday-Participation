# common variables for generating sample data and shiny app (ui & server)
import("dplyr")
import("htmltools")


app_title <- "MTA Pre and Post-COVID-19 (C19) Ridership Dashboard"
app_version <- "v 1.2"
data_last_day <- "2024-10-31" %>% as.Date()
data_first_day <- "2020-03-01" %>% as.Date()
marketplace_website <- "https://appsilon.com/"
blogfolio <- "https://afrikaniz3d.netlify.app/portfolio"

metrics_list <- list(
  buses_prepandemic = list(
    id = "buses_prepandemic",
    title = "Buses (Pre-COVID)",
    category= "prepandemic_ridership_1",
    legend = "Buses (Pre-COVID)"
  ),
  buses_postpandemic = list(
    id = "buses_postpandemic",
    title = "Buses (Post-COVID)",
    category= "postpandemic_ridership_1",
    legend = "Buses (Post-COVID)"
  ),
  buses_recover_rate = list(
    id = "buses_recover_rate",
    title = "Buses (Recovery)",
    category= "recovery_1",
    legend = "Buses (Recovery)"
  ),
  subways_prepandemic = list(
    id = "subways_prepandemic",
    title = "Subways (Pre-COVID)",
    category= "prepandemic_ridership_1",
    legend = "Subways (Pre-COVID)"
  ),
  subways_postpandemic = list(
    id = "subways_postpandemic",
    title = "Subways (Post-COVID)",
    category= "postpandemic_ridership_1",
    legend = "Subways (Post-COVID)"
  ),
  subways_recover_rate = list(
    id = "subways_recover_rate",
    title = "Subways (Recovery)",
    category= "recovery_1",
    legend = "Subways (Recovery)"
  ),
  lirr_prepandemic = list(
    id = "lirr_prepandemic",
    title = "Long Island Rail Road (Pre-COVID)",
    category= "prepandemic_ridership_1",
    legend = "Long Island Rail Road (Pre-COVID)"
  ),
  lirr_postpandemic = list(
    id = "lirr_postpandemic",
    title = "Long Island Rail Road (Post-COVID)",
    category= "postpandemic_ridership_1",
    legend = "Long Island Rail Road (Post-COVID)"
  ),
  lirr_recover_rate = list(
    id = "lirr_recover_rate",
    title = "Long Island Rail Road (Recovery)",
    category= "recovery_1",
    legend = "Long Island Rail Road (Recovery)"
  ),
  metro_north_prepandemic = list(
    id = "metro_north_prepandemic",
    title = "Metro-North (Pre-COVID)",
    category= "prepandemic_ridership_1",
    legend = "Metro-North (Pre-COVID)"
  ),
  metro_north_postpandemic = list(
    id = "metro_north_postpandemic",
    title = "Metro-North (Post-COVID)",
    category= "postpandemic_ridership_1",
    legend = "Metro-North (Post-COVID)"
  ),
  metro_north_recover_rate = list(
    id = "metro_north_recover_rate",
    title = "Metro-North (Recovery)",
    category= "recovery_1",
    legend = "Metro-North (Recovery)"
  ),
  aar_prepandemic = list(
    id = "aar_prepandemic",
    title = "Access-A-Ride (Pre-COVID)",
    category= "prepandemic_ridership_1",
    legend = "Access-A-Ride (Pre-COVID)"
  ),
  aar_postpandemic = list(
    id = "aar_postpandemic",
    title = "Access-A-Ride (Post-COVID)",
    category= "postpandemic_ridership_1",
    legend = "Access-A-Ride (Post-COVID)"
  ),
  aar_recover_rate = list(
    id = "aar_recover_rate",
    title = "Access-A-Ride (Recovery)",
    category= "recovery_1",
    legend = "Access-A-Ride (Recovery)"
  ),
  bnt_prepandemic = list(
    id = "bnt_prepandemic",
    title = "Bridges and Tunnels (Pre-COVID)",
    category= "prepandemic_ridership_1",
    legend = "Bridges and Tunnels (Pre-COVID)"
  ),
  bnt_postpandemic = list(
    id = "bnt_postpandemic",
    title = "Bridges and Tunnels (Post-COVID)",
    category= "postpandemic_ridership_1",
    legend = "Bridges and Tunnels (Post-COVID)"
  ),
  bnt_recover_rate = list(
    id = "bnt_recover_rate",
    title = "Bridges and Tunnels (Recovery)",
    category= "recovery_1",
    legend = "Bridges and Tunnels (Recovery)"
  ),
  sir_prepandemic = list(
    id = "sir_prepandemic",
    title = "Staten Island Railway (Pre-COVID)",
    category= "prepandemic_ridership_1",
    legend = "Staten Island Railway (Pre-COVID)"
  ),
  sir_postpandemic = list(
    id = "sir_postpandemic",
    title = "Staten Island Railway (Post-COVID)",
    category= "postpandemic_ridership_1",
    legend = "Staten Island Railway (Post-COVID)"
  ),
  sir_recover_rate = list(
    id = "sir_recover_rate",
    title = "Staten Island Railway (Recovery)",
    category= "recovery_1",
    legend = "Staten Island Railway (Recovery)"
  ),
  buses_prepandemic = list(
    id = "buses_prepandemic",
    title = "Buses (Pre-COVID)",
    category= "prepandemic_ridership_2",
    legend = "Bus (Pre-COVID)"
  ),
  buses_postpandemic = list(
    id = "buses_postpandemic",
    title = "Buses (Post-COVID)",
    category= "postpandemic_ridership_2",
    legend = "Bus Ridership(post-COVID)"
  ),
  buses_recover_rate = list(
    id = "buses_recover_rate",
    title = "Buses (Recovery)",
    category= "recovery_2",
    legend = "Buses (Recovery)"
  ),
  subways_prepandemic = list(
    id = "subways_prepandemic",
    title = "Subways (Pre-COVID)",
    category= "prepandemic_ridership_2",
    legend = "Subways (Pre-COVID)"
  ),
  subways_postpandemic = list(
    id = "subways_postpandemic",
    title = "Subways (Post-COVID)",
    category= "postpandemic_ridership_2",
    legend = "Subways (Post-COVID)"
  ),
  subways_recover_rate = list(
    id = "subways_recover_rate",
    title = "Subways (Recovery)",
    category= "recovery_2",
    legend = "Subways (Recovery)"
  ),
  lirr_prepandemic = list(
    id = "lirr_prepandemic",
    title = "Long Island Rail Road (Pre-COVID)",
    category= "prepandemic_ridership_2",
    legend = "Long Island Rail Road (Pre-COVID)"
  ),
  lirr_postpandemic = list(
    id = "lirr_postpandemic",
    title = "Long Island Rail Road (Post-COVID)",
    category= "postpandemic_ridership_2",
    legend = "Long Island Rail Road (Post-COVID)"
  ),
  lirr_recover_rate = list(
    id = "lirr_recover_rate",
    title = "Long Island Rail Road (Recovery)",
    category= "recovery_2",
    legend = "Long Island Rail Road (Recovery)"
  ),
  metro_north_prepandemic = list(
    id = "metro_north_prepandemic",
    title = "Metro-North (Pre-COVID)",
    category= "prepandemic_ridership_2",
    legend = "Metro-North (Pre-COVID)"
  ),
  metro_north_postpandemic = list(
    id = "metro_north_postpandemic",
    title = "Metro-North (Post-COVID)",
    category= "postpandemic_ridership_2",
    legend = "Metro-North (Post-COVID)"
  ),
  metro_north_recover_rate = list(
    id = "metro_north_recover_rate",
    title = "Metro-North (Recovery)",
    category= "recovery_2",
    legend = "Metro-North (Recovery)"
  ),
  aar_prepandemic = list(
    id = "aar_prepandemic",
    title = "Access-A-Ride (Pre-COVID)",
    category= "prepandemic_ridership_2",
    legend = "Access-A-Ride (Pre-COVID)"
  ),
  aar_postpandemic = list(
    id = "aar_postpandemic",
    title = "Access-A-Ride (Post-COVID)",
    category= "postpandemic_ridership_2",
    legend = "Access-A-Ride (Post-COVID)"
  ),
  aar_recover_rate = list(
    id = "aar_recover_rate",
    title = "Access-A-Ride (Recovery)",
    category= "recovery_2",
    legend = "Access-A-Ride (Recovery)"
  ),
  bnt_prepandemic = list(
    id = "bnt_prepandemic",
    title = "Bridges and Tunnels (Pre-COVID)",
    category= "prepandemic_ridership_2",
    legend = "Bridges and Tunnels (Pre-COVID)"
  ),
  bnt_postpandemic = list(
    id = "bnt_postpandemic",
    title = "Bridges and Tunnels (Post-COVID)",
    category= "postpandemic_ridership_2",
    legend = "Bridges and Tunnels (Post-COVID)"
  ),
  bnt_recover_rate = list(
    id = "bnt_recover_rate",
    title = "Bridges and Tunnels (Recovery)",
    category= "recovery_2",
    legend = "Bridges and Tunnels (Recovery)"
  ),
  sir_prepandemic = list(
    id = "sir_prepandemic",
    title = "Staten Island Railway (Pre-COVID)",
    category= "prepandemic_ridership_2",
    legend = "Staten Island Railway (Pre-COVID)"
  ),
  sir_postpandemic = list(
    id = "sir_postpandemic",
    title = "Staten Island Railway (Post-COVID)",
    category= "postpandemic_ridership_2",
    legend = "Staten Island Railway (Post-COVID)"
  ),
  sir_recover_rate = list(
    id = "sir_recover_rate",
    title = "Staten Island Railway (Recovery)",
    category= "recovery_2",
    legend = "Staten Island Railway (Recovery)"
  )
)

map_metrics <- c(
  "subways_prepandemic",
  "subways_postpandemic",
  "buses_prepandemic",
  "buses_postpandemic",
  "lirr_prepandemic",
  "lirr_postpandemic",
  "metro_north_prepandemic",
  "metro_north_postpandemic",
  "aar_prepandemic",
  "aar_postpandemic",
  "bnt_prepandemic",
  "bnt_postpandemic",
  "sir_prepandemic",
  "sir_postpandemic"
)

prev_time_range_choices <- list("Previous Year" = "prev_year", "Previous Month" = "prev_month")

appsilonLogo <- HTML("
  <svg class='logo-svg' viewBox='0 0 660.52 262.96'>
    <use href='./www/assets/icons/icons-sprite-map.svg#appsilon-logo'></use>
  </svg>
")

shinyLogo <- HTML("
  <svg class='logo-svg' viewBox='0 0 100 68'>
    <use href='./www/assets/icons/icons-sprite-map.svg#shiny-logo'></use>
  </svg>
")

colors <- list(
  white = "#FFF",
  black = "#0a1e2b",
  primary = "#083fa9",
  secondary = "#083fa9",
  ash = "#B3B8BA",
  ash_light = "#e3e7e9"
)

