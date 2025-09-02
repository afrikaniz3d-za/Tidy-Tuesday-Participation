```{r}
library(readr)
library(ggplot2)
library(ggthemes)

ggplot(ssa, aes(
  x = year_mid,
  y = event_type,
  color = event_type,
  size = event_count
)) +
  geom_point() +
  scale_color_manual(
    values = c(
      "Wildfire" = "#B21500",
      "Storm" = "#366899",
      "Rain & flooding" = "#6395EE",
      "Impact" = "#ADCCED",
      "Heat" = "#FF8C00",
      "Drought" = "#DCCF53",
      "Compound" = "#6D8196"
    )
  ) +
  scale_size_continuous(range = c(5, 12)) +
  scale_x_continuous(breaks = seq(1990, 2025, 5)) +
  scale_y_discrete(expand = expansion(add = 2)) +
  coord_cartesian(ylim = c(0.5, length(unique(ssa$event_type)) - 1)) +
  labs(
    x = "Year",
    y = "Climate Event",
    title = "Tidy Tuesday - 2025, Week 32",
    subtitle = "Climate Events in Sub-Saharan Africa (1992-2024)",
    caption = "Droughts are the most frequent and prolonged events, with rain and flooding occurring regularly but typically shorter. 
    Multiple event types increasingly overlap in recent years, highlighting periods of compounded climate stress."
  ) +
  theme_fivethirtyeight() +
  theme(
    axis.text.x = element_text(size = 12),
    axis.text.y = element_text(size = 12, face = "bold"),
    axis.title.x = element_text(size = 16, face = "bold", margin = margin(t = 35)), 
    axis.title.y = element_text(size = 16, face = "bold", margin = margin(r = 35)), 
    plot.title = element_text(size = 22, face = "bold"),
    plot.subtitle = element_text(size = 16, margin = margin(b = 20)),
    plot.caption = element_text(size = 16, face = "italic", hjust = 0.5, vjust = -2),
    legend.position = "none"
  )
```
