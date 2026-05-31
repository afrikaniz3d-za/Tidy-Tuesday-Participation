# ----
# initial look at the dataset

library(dplyr)

# identifying an removing regions
unique(energy$country_name)

# to be excluded in aggregations
'[37] "Caucasus and Central Asia"' #?
'[60] "Eastern Asia (including Japan)"'
'[61] "Eastern Asia (not including Japan)"'
'[62] "Eastern Europe"'
'[70] "Europe"'
'[94] "High income"'
'[95] "High income: nonOECD"'
'[96] "High income: OECD"'
'[121] "Latin America and Caribbean"'
'[129] "Low & middle income"'
'[130] "Low income"'
'[131] "Lower middle income"'
'[148] "Middle income"'
'[166] "Northern Africa"'
'[169] "Nothern America"'
'[170] "Oceania"'
'[171] "Oceania (not including Australia and New Zealand)"'
'[204] "South Eastern Asia"'
'[206] "Southern Asia"'
'[213] "Sub-Saharan Africa"'
'[248] "World"'

# removing regions and economic classifications
energy_countries <- energy |>
  filter_out(
    energy$`country_name`%in% c(
      "Caucasus and Central Asia",
      "Eastern Asia (including Japan)",
      "Eastern Asia (not including Japan)",
      "Eastern Europe",
      "Europe",
      "High income",
      "High income: nonOECD",
      "High income: OECD",
      "Latin America and Caribbean",
      "Low & middle income",
      "Low income",
      "Lower middle income",
      "Middle income",
      "Northern Africa",
      "Northern America",
      "Nothern America",
      "Oceania",
      "Oceania (not including Australia and New Zealand)",
      "South Eastern Asia",
      "Southern Asia",
      "Sub-Saharan Africa",
      "Upper middle income",
      "Western Asia",
      "Western Sahara",
      "World"
      )
    )

# focusing in on marine energy
marine_energy <- energy_countries |>
  select(
    country_name,
    yr,
    marine_energy_consumption_tfec_pct,
    marine_consumption_terajoules,
    renewable_energy_consumption_terajoules,
    renewable_energy_consumption_tfec_pct,
    renewable_energy_electricity_output_gigawatt_hours,
    renewable_energy_installed_capacity_gigawatts,
    share_of_renewable_capacity_in_total_capacity_pct
    )
  
library(dplyr)

marine_energy |> 
  summarise(mean_consumption_pct = mean(marine_energy_consumption_tfec_pct), .by = country_name)
# France and Canada are the only nations that registered values for this column
# Checking terajoule consumption next

marine_energy |> 
  summarise(mean_consumption_terajoule = mean(marine_consumption_terajoules), .by = country_name)
# Again, France and Canada are the only two nations with values.

# creating the final filtered table with only France and Canada
marine_energy <- marine_energy |>
  filter(
    marine_consumption_terajoules > 0
    ) |>
  mutate(
    yr = factor(yr)
    )

library(tidyplots)
library(ggplot2)

# generating the chart
marine_energy_plot <- marine_energy |> 
  tidyplot(x = yr, y = marine_consumption_terajoules, color = country_name) |> 
  add_sum_bar() |>
  adjust_y_axis_title("Marine Energy Consumption (Terajoules)") |>
  adjust_size(width = 360, height = 120) |>
  theme_tidyplot() +
  theme(
    plot.title = element_text(family = "Plus Jakarta Sans", size = 26, face = "bold", margin = margin(b = 20)),
    axis.title.y = element_text(size = 16, margin = margin(r = 18)),
    axis.title.x = element_blank(),
    axis.text.x  = element_text(size = 11),
    axis.text.y  = element_text(size = 11),
    plot.caption = ggtext::element_markdown(size = 14, hjust = 0, margin = margin(t = 40), lineheight = 1.6),
    legend.position = "top",
    legend.title = element_blank(),
    legend.text = element_text(size = 14)
  ) +
  scale_fill_manual(values = c("#4f5858", "#fab817")) +
  scale_color_manual(values = c("#4f5858", "#fab817"))

# saving/exporting the plot
ggsave(
  "marine_energy_plot.png",
  plot = marine_energy_plot,
  width = 16,
  height = 8,
  dpi = 300
)

# The resulting table was nothing interesting on its own past France dwarfing
# Canada's consumption. It also occurred to me that some nations might be
# recording their marine energy data under hydro energy, so I'm extending the
# table to include that source too

# creating the hydro_marine_energy table
hydro_marine_energy <- energy_countries |>
  select(
    country_name,
    yr,
    marine_consumption_terajoules,
    hydro_energy_consumption_terajoules
    ) |>
  mutate(
    yr = factor(yr)
    )

# getting an idea of what the beeswarm looks like
hydro_energy_plot <- hydro_marine_energy |>
  tidyplot(
    x = yr, y = hydro_energy_consumption_terajoules
    ) |>
  add_data_points_beeswarm() |>
  adjust_y_axis_title("Hydro Energy Consumption (Terajoules)") |>
  adjust_size(width = 360, height = 120) |>
  theme_tidyplot() +
  
  geom_smooth(
    data = dplyr::filter(hydro_marine_energy, country_name == "France"),
    aes(x = yr, y = marine_consumption_terajoules),
    method = "loess",
    se = FALSE,
    color = "#fab817", 
    linewidth = 1.5,
    inherit.aes = FALSE
    ) +
  
  theme(
    plot.title = element_text(family = "Plus Jakarta Sans", size = 26, face = "bold", margin = margin(b = 20)),
    axis.title.y = element_text(size = 16, margin = margin(r = 18)),
    axis.title.x = element_blank(),
    axis.text.x  = element_text(size = 11),
    axis.text.y  = element_text(size = 11),
    plot.caption = ggtext::element_markdown(size = 14, hjust = 0, margin = margin(t = 40), lineheight = 1.6),
    legend.position = "top",
    legend.title = element_blank(),
    legend.text = element_text(size = 14)
  ) +
  scale_fill_manual(values = c("#4f5858", "#fab817")) +
  scale_color_manual(values = c("#4f5858", "#fab817"))

# saving/exporting the plot
ggsave(
  "hydro_energy_plot.png",
  plot = hydro_energy_plot,
  width = 16,
  height = 8,
  dpi = 300
)

# ended up not being able to see the France marine energy line, so I'm
# pivoting back to looking at just the two nations (France and Canada) 
# in their own chart that now looks at both the energy types - marine
# and hydro

library(tidyplots)
library(ggplot2)

# generating the chart
hydro_marine_plot <- hydro_marine_energy |>
  dplyr::filter(country_name %in% c("France", "Canada")) |>
  tidyplot(x = yr) |>
  adjust_size(width = 360, height = 120) |>
  add_title("France is leagues above Canada's Marine Energy Consumption*") |>
  add_caption("An initial look into each nation's Marine Energy consumption revealed that Canada and France were the only two nations to record readings for  
  the energy type, with France consuming nearly 10 times more than Canada on average. Expanding the exploration to include Hydro Energy almost  
  flips this relationship, ***suggesting many nations might either consider Marine energy as an extension of Hydro, or it's still an avenue  
  that remains untapped**.") |>
  adjust_x_axis_title("Year") |>
  theme_tidyplot() +
  
  # hydro energy bars
  geom_col(
    aes(y = hydro_energy_consumption_terajoules, fill = country_name),
    position = "dodge", 
    alpha = 0.33,
    na.rm = FALSE
  ) +
  
  # marine consumption lines
  geom_line(
    aes(x = yr, y = marine_consumption_terajoules * scaling_factor, color = country_name, group = country_name),
    linewidth = 2.5,
    na.rm = FALSE,
    inherit.aes = FALSE
  ) +
  
  # marine consumption points
  geom_point(
    aes(x = yr, y = marine_consumption_terajoules * scaling_factor, color = country_name),
    size = 5,
    na.rm = FALSE,
    inherit.aes = FALSE
  ) +
  
  # axis scaling
  scale_y_continuous(
    name = "Hydro Energy Consumption (Terajoules)", # left y-axis title
    labels = scales::label_comma(),
    sec.axis = sec_axis(
      trans = ~ . / scaling_factor, 
      name = "Marine Energy Consumption (Terajoules)", # right y-axis title
      labels = scales::label_comma()
    )
  ) +
  
  theme(
    plot.title = element_text(family = "Plus Jakarta Sans", size = 26, face = "bold", margin = margin(b = 20)),
    # left y-axis title
    axis.title.y.left  = element_text(family = "Roboto", size = 14, margin = margin(r = 18), color = "#4f5858", face = "bold"),
    # right y-axis title
    axis.title.y.right = element_text(family = "Roboto", size = 14, margin = margin(l = 18), color = "#fab817", face = "bold", angle = 90),
    axis.title.x       = element_text(family = "Roboto", size = 14, margin = margin(r = 18), face = "bold"),
    axis.text.x        = element_text(size = 11),
    axis.text.y        = element_text(size = 11),
    plot.caption       = ggtext::element_markdown(size = 14, hjust = 0, margin = margin(t = 40), lineheight = 1.6),
    legend.position    = "top",
    legend.title       = element_blank(),
    legend.text        = element_text(size = 14)
  ) +
  
  # forcing the legend's visibility
  guides(
    fill = guide_legend(order = 1),
    color = guide_legend(order = 2)
  ) +
  scale_fill_manual(values = c("Canada" = "#0e3a53", "France" = "#fab817")) + 
  scale_color_manual(values = c("Canada" = "#0e3a53", "France" = "#fab817"))

# saving/exporting the plot
ggsave(
  "hydro_marine_plot.png",
  plot = hydro_marine_plot,
  width = 18,
  height = 9,
  dpi = 300
)


# ---- 
# creating a table for the quarto doc

# filtering for just Canada and France
selected_countries <- c("Canada", "France")

# creating the table
hydro_marine_energy_quarto <- energy_countries |>
  filter(
    country_name %in% selected_countries
    ) |>
  select(
    country_name,
    yr,
    marine_consumption_terajoules,
    hydro_energy_consumption_terajoules
  ) |>
  mutate(
    yr = factor(yr)
    )

# exporting the table to csv
write.csv(hydro_marine_energy_quarto, file = "data/hydro_marine_energy_quarto.csv", row.names = FALSE)
