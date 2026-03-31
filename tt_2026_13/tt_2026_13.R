library(dplyr)
library(tidyr)
library(scales)
library(stringr)
library(readr)
library(tidyplots)
library(ggplot2)
library(ggtext)

# bringing in the data
ocean_temperature_deployments <- read_csv("datapack/ocean_temperature_deployments.csv")

# generating a basic gantt chart to see lengths and possible overlaps
o <- ocean_temperature_deployments |>
  tidyplot(x = start_date, y = deployment_id, color = deployment_id) |>

  add(geom_segment(aes(xend = end_date, yend = deployment_id), linewidth = 4)) |>
  add_title("Ocean Temperature Deployments Gantt Chart") |>
  adjust_size(width = 140, height = 140) |>
  theme_tidyplot() +
  theme(
    plot.title = element_text(size = 14, face = "bold", vjust = 10, margin = margin(t = 10)),
    axis.title.y = element_text(size = 12, margin = margin(r = 18)),
    axis.title.x = element_text(size = 12, margin = margin(t = 18)),
    axis.text.x  = element_text(size = 9),
    axis.text.y  = element_text(size = 9),
    plot.caption = element_markdown(size = 12, hjust = 0, margin = margin(t = 20), lineheight = 1.5)
  )

ggsave(
  "visuals/deployment_gantt.png",
  o,
  width = 8,
  height = 8,
  limitsize = FALSE
)

# deployments 02 and o4 have longer durations - does that mean they're the one with 1000+ readings? 

# adding the deployment_id column to ocean_temperature table
ocean_temperature_2_d <- 
  left_join(
    ocean_temperature_2, 
    ocean_temperature_deployments, 
    join_by(between(date, start_date, end_date, bounds = "[]"))
    )
# the join_by method left me feeling nervous about the crossover days, so I followed the data link in 
# the cleaning script where I discovered a lot of other useful columns  - like deployment_range
  # with it I could perform a more reliable case when to create a deployment column I trusted more


# double-checking deployment ranges align with data in ocean_temperature_deployments 
ocean_temperature_2_d |>
  distinct(deployment_range)

# creating column "deployment" to make it clear
ocean_temperature_2_d_depcol <- ocean_temperature_2_d |>
  mutate(
    deployment = case_when(
      str_detect(deployment_range, regex("2018-Feb-20 to 2018-Apr-25", ignore_case = FALSE)) ~ "01",
      str_detect(deployment_range, regex("2018-Apr-25 to 2019-May-02", ignore_case = FALSE)) ~ "02",
      str_detect(deployment_range, regex("2019-May-02 to 2019-Nov-22", ignore_case = FALSE)) ~ "03",
      str_detect(deployment_range, regex("2019-Nov-22 to 2020-Nov-08", ignore_case = FALSE)) ~ "04",
      str_detect(deployment_range, regex("2020-Nov-08 to 2021-May-21", ignore_case = FALSE)) ~ "05",
      str_detect(deployment_range, regex("2021-May-21 to 2021-Nov-26", ignore_case = FALSE)) ~ "06",
      str_detect(deployment_range, regex("2021-Nov-26 to 2022-May-12", ignore_case = FALSE)) ~ "07",
      str_detect(deployment_range, regex("2022-May-12 to 2022-Nov-03", ignore_case = FALSE)) ~ "08",
      str_detect(deployment_range, regex("2022-Nov-03 to 2023-May-15", ignore_case = FALSE)) ~ "09",
      str_detect(deployment_range, regex("2023-May-15 to 2023-Nov-10", ignore_case = FALSE)) ~ "10",
      str_detect(deployment_range, regex("2023-Nov-10 to 2024-May-02", ignore_case = FALSE)) ~ "11",
      str_detect(deployment_range, regex("2024-May-02 to 2024-Nov-21", ignore_case = FALSE)) ~ "12",
      str_detect(deployment_range, regex("2024-Nov-21 to 2025-May-02", ignore_case = FALSE)) ~ "13",
      str_detect(deployment_range, regex("2025-May-02 to 2025-Dec-06", ignore_case = FALSE)) ~ "14",
      TRUE ~ "Check Row"
      )
    ) |>
  select(
    date,
    deployment_range,
    deployment,
    everything()
    )

# the original ocean_temperature.csv has 19 165 rows, whereas my ocean_temperature_2 has 19 247
# need to investigate those additional 18 rows 

# looking for rows that may have doubled-up on the threshold days
threshold_doubles <- ocean_temperature_2_d_depcol |>
  count(date, sensor_depth_at_low_tide_m) |>
  filter(n > 1)

# looking at the "double" rows to see why they split
threshold_doubles_fulltable <- ocean_temperature_2_d_depcol |>
  group_by(date, sensor_depth_at_low_tide_m) |>
  filter(n() > 1) |>
  arrange(date, sensor_depth_at_low_tide_m)

# count NAs in every column
null_report <- ocean_temperature_2_d_depcol |>
  summarise(across(everything(), ~ sum(is.na(.))))
  # this found 6 rows that had NAs for deployment_id

# looking for any "ghost rows"
null_report_fulltable <- ocean_temperature_2_d_depcol |>
  filter(is.na(deployment_id))

# ---------------------
# the thermal profile
# ---------------------
library(lubridate)
library(dplyr)

# reordering the columns to keep the dates together
ocean_temperature_2_d_depcol <- ocean_temperature_2_d_depcol |>
  mutate(
     date = as.Date(date),
     year = year(date)
    ) |>
    select(
      date, year, everything()
      )  
    

daily_temps_final <- ocean_temperature_2_d_depcol |>
  tidyplot(x = date, y = mean_temperature_degree_c, color = deployment) |>
  add_line() |>
  add_title("Daily Average Temperatures") |>
  theme_tidyplot() |>
  { \(x) x + theme(
    plot.title   = element_text(size = 14, face = "bold", family = "Plus Jakarta Sans", margin = margin(b = 20)),
    axis.title.y = element_text(size = 12, family = "Plus Jakarta Sans", margin = margin(r = 18)),
    axis.title.x = element_text(size = 12, family = "Plus Jakarta Sans", margin = margin(t = 18)),
    axis.text    = element_text(size = 9, family = "Plus Jakarta Sans")
  ) }() |>
  # split and save (must be done as the last step before saving)
  split_plot(by = year, ncol = 3, nrow = 3)

# exporting plot
daily_temps_final |> 
  save_plot("visuals/daily_temps.png", width = 8, height = 16)



# facet by deployment
daily_temps_final <- ocean_temperature_2_d_depcol |>
  tidyplot(x = date, y = mean_temperature_degree_c, color = deployment) |>
  add_line() |>
  add_title("Daily Average Temperatures") |>
  theme_tidyplot() |>
  { \(x) x + theme(
    plot.title   = element_text(size = 14, face = "bold", family = "Plus Jakarta Sans", margin = margin(b = 20)),
    axis.title.y = element_text(size = 12, family = "Plus Jakarta Sans", margin = margin(r = 18)),
    axis.title.x = element_text(size = 12, family = "Plus Jakarta Sans", margin = margin(t = 18)),
    axis.text    = element_text(size = 9, family = "Plus Jakarta Sans")
  ) }() |>

  split_plot(by = deployment, ncol = 5, nrow = 3)

daily_temps_final |> 
  save_plot("visuals/daily_temps.png", width = 12, height = 20)



# group/colour by depth
daily_depths <- ocean_temperature_2_d_depcol |>
  # creating a dedicated categorical column for the legend
  mutate(depth_cat = factor(sensor_depth_at_low_tide_m)) |>
  
  tidyplot(x = date, y = mean_temperature_degree_c, color = depth_cat) |>
  add_line() |>
  add_title("Daily Average Temperatures by Depth") |>
  adjust_size(width = 70, height = 70) |>
  theme_tidyplot() |>
  { \(x) x + theme(
    plot.title   = element_text(size = 14, face = "bold", family = "Plus Jakarta Sans", margin = margin(b = 20)),
    axis.title.y = element_text(size = 12, family = "Plus Jakarta Sans", margin = margin(r = 18)),
    axis.title.x = element_text(size = 12, family = "Plus Jakarta Sans", margin = margin(t = 18)),
    axis.text    = element_text(size = 9, family = "Plus Jakarta Sans")
  ) }() |>
  split_plot(by = deployment, ncol = 5, nrow = 3)

ggsave(
  "visuals/daily_depths.png",
  daily_depths,
  width = 20,
  height = 15,
  limitsize = FALSE
)



# focusing on deployment 01 
enlarged_plot_1 <- ocean_temperature_2_d_depcol |>
  # dedicated categorical column for the legend
  mutate(depth_cat = factor(sensor_depth_at_low_tide_m)) |>
  filter(deployment == "01") |> 
  tidyplot(x = date, y = mean_temperature_degree_c, color = depth_cat) |>
  add_line(linewidth = 1) |>
  adjust_colors(
    c(
      "2" = "#d55e00",
      "40" = "#0072b2"
    ), na.value = "#ffffff10"
  ) |>
  add_title("Focus: Deployment 01 Winter Inversion") |>
  adjust_size(width = 140, height = 140) |>
  theme_tidyplot() +
  theme(
    plot.title   = element_text(size = 14, face = "bold", family = "Plus Jakarta Sans", margin = margin(b = 20)),
    axis.title.y = element_text(size = 12, family = "Plus Jakarta Sans", margin = margin(r = 18)),
    axis.title.x = element_text(size = 12, family = "Plus Jakarta Sans", margin = margin(t = 18)),
    axis.text    = element_text(size = 9, family = "Plus Jakarta Sans"),
    legend.position = "top",
    legend.title = element_blank()
  )

ggsave(
  "visuals/deployment_01_zoom.png",
  enlarged_plot_1,
  width = 8,
  height = 8,
  limitsize = FALSE
)


# focusing on deployment 02 
enlarged_plot_2 <- ocean_temperature_2_d_depcol |>
  # dedicated categorical column for the legend
  mutate(depth_cat = factor(sensor_depth_at_low_tide_m)) |>
  filter(deployment == "02") |> 
  tidyplot(x = date, y = mean_temperature_degree_c, color = depth_cat) |>
  add_line(linewidth = 1) |>
  adjust_colors(
    c(
      "2" = "#d55e00",
      "40" = "#0072b2"
    ), na.value = "#ffffff10"
  ) |>
  add_title("Focus: Deployment 02 Winter Inversion") |>
  adjust_size(width = 140, height = 140) |>
  theme_tidyplot() +
  theme(
    plot.title   = element_text(size = 14, face = "bold", family = "Plus Jakarta Sans", margin = margin(b = 20)),
    axis.title.y = element_text(size = 12, family = "Plus Jakarta Sans", margin = margin(r = 18)),
    axis.title.x = element_text(size = 12, family = "Plus Jakarta Sans", margin = margin(t = 18)),
    axis.text    = element_text(size = 9, family = "Plus Jakarta Sans"),
    legend.position = "top",
    legend.title = element_blank()
  )

ggsave(
  "visuals/deployment_02_zoom.png",
  enlarged_plot_2,
  width = 8,
  height = 8,
  limitsize = FALSE
)



# focusing on deployment 03 
enlarged_plot_3 <- ocean_temperature_2_d_depcol |>
  # dedicated categorical column for the legend
  mutate(depth_cat = factor(sensor_depth_at_low_tide_m)) |>
  filter(deployment == "03") |> 
  tidyplot(x = date, y = mean_temperature_degree_c, color = depth_cat) |>
  add_line(linewidth = 1) |>
  adjust_colors(
    c(
      "2" = "#d55e00",
      "40" = "#0072b2"
    ), na.value = "#ffffff10"
  ) |>
  add_title("Focus: Deployment 03 Winter Inversion") |>
  adjust_size(width = 140, height = 140) |>
  theme_tidyplot() +
  theme(
    plot.title   = element_text(size = 14, face = "bold", family = "Plus Jakarta Sans", margin = margin(b = 20)),
    axis.title.y = element_text(size = 12, family = "Plus Jakarta Sans", margin = margin(r = 18)),
    axis.title.x = element_text(size = 12, family = "Plus Jakarta Sans", margin = margin(t = 18)),
    axis.text    = element_text(size = 9, family = "Plus Jakarta Sans"),
    legend.position = "top",
    legend.title = element_blank()
  )

ggsave(
  "visuals/deployment_03_zoom.png",
  enlarged_plot_3,
  width = 8,
  height = 8,
  limitsize = FALSE
)


# focusing on deployment 04 
enlarged_plot_4 <- ocean_temperature_2_d_depcol |>
  # dedicated categorical column for the legend
  mutate(depth_cat = factor(sensor_depth_at_low_tide_m)) |>
  filter(deployment == "04") |> 
  tidyplot(x = date, y = mean_temperature_degree_c, color = depth_cat) |>
  add_line(linewidth = 1) |>
  adjust_colors(
    c(
      "2" = "#d55e00",
      "40" = "#0072b2"
    ), na.value = "#ffffff10"
  ) |>
  add_title("Focus: Deployment 04 Winter Inversion") |>
  adjust_size(width = 140, height = 140) |>
  theme_tidyplot() +
  theme(
    plot.title   = element_text(size = 14, face = "bold", family = "Plus Jakarta Sans", margin = margin(b = 20)),
    axis.title.y = element_text(size = 12, family = "Plus Jakarta Sans", margin = margin(r = 18)),
    axis.title.x = element_text(size = 12, family = "Plus Jakarta Sans", margin = margin(t = 18)),
    axis.text    = element_text(size = 9, family = "Plus Jakarta Sans"),
    legend.position = "top",
    legend.title = element_blank()
  )

ggsave(
  "visuals/deployment_04_zoom.png",
  enlarged_plot_4,
  width = 8,
  height = 8,
  limitsize = FALSE
)



# focusing on deployment 05 
enlarged_plot_5 <- ocean_temperature_2_d_depcol |>
  # dedicated categorical column for the legend
  mutate(depth_cat = factor(sensor_depth_at_low_tide_m)) |>
  filter(deployment == "05") |> 
  tidyplot(x = date, y = mean_temperature_degree_c, color = depth_cat) |>
  add_line(linewidth = 1) |>
  adjust_colors(
    c(
      "2" = "#d55e00",
      "40" = "#0072b2"
    ), na.value = "#ffffff10"
  ) |>
  add_title("Focus: Deployment 05 Winter Inversion") |>
  adjust_size(width = 140, height = 140) |>
  theme_tidyplot() +
  theme(
    plot.title   = element_text(size = 14, face = "bold", family = "Plus Jakarta Sans", margin = margin(b = 20)),
    axis.title.y = element_text(size = 12, family = "Plus Jakarta Sans", margin = margin(r = 18)),
    axis.title.x = element_text(size = 12, family = "Plus Jakarta Sans", margin = margin(t = 18)),
    axis.text    = element_text(size = 9, family = "Plus Jakarta Sans"),
    legend.position = "top",
    legend.title = element_blank()
  )

ggsave(
  "visuals/deployment_05_zoom.png",
  enlarged_plot_5,
  width = 8,
  height = 8,
  limitsize = FALSE
)



# focusing on deployment 06 
enlarged_plot_6 <- ocean_temperature_2_d_depcol |>
  # dedicated categorical column for the legend
  mutate(depth_cat = factor(sensor_depth_at_low_tide_m)) |>
  filter(deployment == "06") |> 
  tidyplot(x = date, y = mean_temperature_degree_c, color = depth_cat) |>
  add_line(linewidth = 1) |>
  adjust_colors(
    c(
      "2" = "#d55e00",
      "40" = "#0072b2"
    ), na.value = "#ffffff10"
  ) |>
  add_title("Focus: Deployment 06 Winter Inversion") |>
  adjust_size(width = 140, height = 140) |>
  theme_tidyplot() +
  theme(
    plot.title   = element_text(size = 14, face = "bold", family = "Plus Jakarta Sans", margin = margin(b = 20)),
    axis.title.y = element_text(size = 12, family = "Plus Jakarta Sans", margin = margin(r = 18)),
    axis.title.x = element_text(size = 12, family = "Plus Jakarta Sans", margin = margin(t = 18)),
    axis.text    = element_text(size = 9, family = "Plus Jakarta Sans"),
    legend.position = "top",
    legend.title = element_blank()
  )

ggsave(
  "visuals/deployment_06_zoom.png",
  enlarged_plot_6,
  width = 8,
  height = 8,
  limitsize = FALSE
)



# focusing on deployment 07 
enlarged_plot_7 <- ocean_temperature_2_d_depcol |>
  # dedicated categorical column for the legend
  mutate(depth_cat = factor(sensor_depth_at_low_tide_m)) |>
  filter(deployment == "07") |> 
  tidyplot(x = date, y = mean_temperature_degree_c, color = depth_cat) |>
  add_line(linewidth = 1) |>
  adjust_colors(
    c(
      "2" = "#d55e00",
      "40" = "#0072b2"
      ), na.value = "#ffffff10"
    ) |>
  add_title("Focus: Deployment 07 Winter Inversion") |>
  adjust_size(width = 140, height = 140) |>
  theme_tidyplot() +
  theme(
    plot.title   = element_text(size = 14, face = "bold", family = "Plus Jakarta Sans", margin = margin(b = 20)),
    axis.title.y = element_text(size = 12, family = "Plus Jakarta Sans", margin = margin(r = 18)),
    axis.title.x = element_text(size = 12, family = "Plus Jakarta Sans", margin = margin(t = 18)),
    axis.text    = element_text(size = 9, family = "Plus Jakarta Sans"),
    legend.position = "top",
    legend.title = element_blank()
  )

ggsave(
  "visuals/deployment_07_zoom.png",
  enlarged_plot_7,
  width = 8,
  height = 8,
  limitsize = FALSE
)


# ----------------
# the thermal gap
# ----------------

# 1. preparing the data
thermal_gap_prep <- ocean_temperature_2_d_depcol |>
  filter(sensor_depth_at_low_tide_m %in% c(2, 40)) |>
  group_by(date, sensor_depth_at_low_tide_m) |>
  slice_max(n_obs, n = 1, with_ties = FALSE) |> 
  ungroup() |>
  select(date, sensor_depth_at_low_tide_m, mean_temperature_degree_c, deployment) |>
  pivot_wider(
    names_from = sensor_depth_at_low_tide_m, 
    values_from = mean_temperature_degree_c,
    names_prefix = "depth_",
    values_fill = NA # ensures NAs if one depth is missing for a specific date
  )

# 2. only runs the math if BOTH columns exist
if("depth_2" %in% colnames(thermal_gap_prep) && "depth_40" %in% colnames(thermal_gap_prep)) {
  thermal_gap_data <- thermal_gap_prep |>
    mutate(temp_diff = depth_2 - depth_40)
  print("Success! Gap calculated.")
} else {
  print("Warning: One of the depths (2m or 40m) is completely missing from this data slice.")
}

# plotting the gap
gap_plot <- thermal_gap_data |>
  tidyplot(x = date, y = temp_diff, color = deployment) |>
  add_line(linewidth = 1) |>
  add_reference_lines(y = 0, linetype = "dashed", linewidth = 1) |> # the "inversion point"
  add_title("Surface vs. Deep: Thermal Difference (2m - 40m)") |>
  { \(x) x + scale_x_date(
    date_breaks = "3 months", 
    date_labels = "%b %Y",
    expand = expansion(mult = 0.02) # keeps the edges clean
  ) }() |>
  adjust_size(width = 660, height = 140) |>
  theme_tidyplot() +
  theme(
    plot.title   = element_text(size = 14, face = "bold", family = "Plus Jakarta Sans", margin = margin(b = 20)),
    axis.title.y = element_text(size = 12, family = "Plus Jakarta Sans", margin = margin(r = 18)),
    axis.title.x = element_text(size = 12, family = "Plus Jakarta Sans", margin = margin(t = 18)),
    axis.text    = element_text(size = 9, family = "Plus Jakarta Sans"),
    legend.position = "top"
    )

ggsave(
  "visuals/thermal_gap_plot.png",
  gap_plot,
  width = 28,
  height = 10,
  limitsize = FALSE
)

# the chart has huge gaps between deployments - which I didn't expect, given that the earlier line charts
# look connected, this suggested that there may have been days where sensors had no readings or the 
# readings did not pass QA for some reason

# below is the modified chunk where I was still inspecting the 2m and 40m depths, but expanded it to all
# the sensors too - where I found more

check_availability <- ocean_temperature_2_d_depcol |>
#  filter(sensor_depth_at_low_tide_m %in% c(2, 40)) |>
  group_by(date, deployment) |>
  summarise(sensors_present = n_distinct(sensor_depth_at_low_tide_m)) #|>
  # filter(sensors_present < 2)

# see exactly which dates are causing the 'gaps'
head(check_availability)



# -------------------------------------------------------------------
# creating the final heatmap to illustrate the thermal gap inversion
# -------------------------------------------------------------------

library(tidyplots)
library(dplyr)
library(tidyr)
library(forcats)

# 1. preparing the heatmap data (reversing year here)
heatmap_data <- thermal_gap_data |>
  mutate(
    year_raw = format(date, "%Y"),
    # reversing the levels here so the most recent year is at the top
    year = fct_rev(factor(year_raw)),
    month = factor(format(date, "%m"), 
                   levels = sprintf("%02d", 1:12), 
                   labels = month.abb)
  ) |>
  group_by(year, month) |>
  summarise(avg_gap = mean(temp_diff, na.rm = TRUE), .groups = "drop")

# 2. plotting the heatmap
gap_heatmap <- heatmap_data |>
  tidyplot(x = month, y = year, color = avg_gap) |>
  add_heatmap() |>
  add_title("The Inversion Fingerprint: Surface vs. Deep (2m vs. 40m)") |>
  adjust_size(width = 140, height = 140) |>
  theme_tidyplot() |>
  { \(x) x + theme(
    plot.title        = element_text(size = 14, face = "bold", family = "Plus Jakarta Sans", margin = margin(b = 30)),
    axis.text.x       = element_text(size = 10, family = "Plus Jakarta Sans", margin = margin(t = 20)),
    axis.text.y       = element_text(size = 10, family = "Plus Jakarta Sans", margin = margin(r = 20)),
    axis.title.y      = element_blank(),
    axis.title.x      = element_blank(),
    axis.line.x       = element_blank(),
    axis.ticks.x      = element_blank(),
    axis.line.y       = element_blank(),
    axis.ticks.y      = element_blank(),
    legend.title      = element_text(size = 12, family = "Plus Jakarta Sans", margin = margin(r = 18)),
    legend.position   = "top",
    legend.margin     = margin(b = 20),
    legend.key.size   = unit(6, "mm"),
    legend.text       = element_text(size = 10, family = "Plus Jakarta Sans") 
    ) + 
    scale_fill_gradient2(
    low = "#236bb3", mid = "#f6ce63", high = "#d7191c", # colours from the nova scotia .. flag (?) :P
    na.value = "#ffffff",
    midpoint = 6.5, name = "Difference in Average Temperature (°C)" 
    ) +
    geom_tile(color = "white", linewidth = 1)
    }()

ggsave("visuals/inversion_heatmap.svg", gap_heatmap, width = 10, height = 10)


heatmap_data <- heatmap_data |>
  mutate(
    avg_gap = round(avg_gap, 2)
    )

# exporting table for quarto
write.csv(heatmap_data, file = "data/heatmap_data.csv", row.names = FALSE)


# the secondary visual showing an example of the thermal inversion
thermal_gap_profile_prep <- ocean_temperature_2_d_depcol |>
  group_by(date, sensor_depth_at_low_tide_m) |>
  slice_max(n_obs, n = 1, with_ties = FALSE) |> 
  ungroup() |>
  select(date, sensor_depth_at_low_tide_m, mean_temperature_degree_c, deployment) |>
  pivot_wider(
    names_from = sensor_depth_at_low_tide_m, 
    values_from = mean_temperature_degree_c,
    names_prefix = "depth_",
    values_fill = NA # ensures NAs if one depth is missing for a specific date
  )

# only runs the math if ALL columns exist (expanded this to all the depths)
#required_depths <- c("depth_2", "depth_5", "depth_10", "depth_15", "depth_20", "depth_30", "depth_40")
#
#if(all(required_depths %in% colnames(thermal_gap_profile_prep))) {
#  thermal_gap_profile_data <- thermal_gap_profile_prep |>
#    mutate(
#      temp_diff_1 = depth_2 - depth_5,
#      temp_diff_2 = depth_5 - depth_10,
#      temp_diff_3 = depth_10 - depth_15,
#      temp_diff_4 = depth_15 - depth_20,
#      temp_diff_5 = depth_20 - depth_30,
#      temp_diff_6 = depth_30 - depth_40,)
#  print("Success! Gaps calculated.")
#} else {
#  print("Warning: One of the depths (2m, 5m, 10m, 15m, 20m, 30m or 40m) is completely missing from this data slice.")
#}


profile_viz_data <- ocean_temperature_2_d_depcol |>
  # comparing the 'inversion' (jan) to the 'recovery' (apr)
  # these share a temperature range between 1°C and 4°C, forcing the "x" (intersection)
  filter(date %in% as.Date(c("2022-01-15", "2022-04-15"))) |> 
  select(date, depth = sensor_depth_at_low_tide_m, temp = mean_temperature_degree_c) |>
  mutate(month_label = format(date, "%b"))

# exporting table for quarto
write.csv(profile_viz_data, file = "data/profile_viz_data.csv", row.names = FALSE)
