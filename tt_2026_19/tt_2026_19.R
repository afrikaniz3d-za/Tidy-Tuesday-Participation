"
Questions to be answered:
  - Which industries have increased production, and which have decreased?  
  - How has the average weight per ship changed over time?

Plan:  
  I will isolate each variable, finding their max output, then create an 
  percentage column normalising to the max value, then plot all the industries 
  as line charts. The goal isn't to see which one produced the most, but 
  focusing on where their peaks were.

  Reference lines are used to mark peaks, then these charts can be looked at 
  to see if there is a relationship between one industry's rise and another's 
  fall
"  

library(dplyr)
library(tidyr)
library(echarts4r)
library(readr)

# ----
# FOOD AND BEVERAGES
food_beverages_pop <- food_beverages |>
  mutate(
    sugar_pop = round((Sugar / max(Sugar, na.rm = TRUE) * 100), 1),
    glucose_pop = round((Glucose / max(Glucose, na.rm = TRUE) * 100), 1),
    coffee_substitute_pop = round((Coffee_substitute / max(Coffee_substitute, na.rm = TRUE) * 100), 1),
    seed_oil_pop = round((Seed_oil / max(Seed_oil, na.rm = TRUE) * 100), 1),
    ethyl_alcohol_1_pop = round((Ethyl_alcohol_1 / max(Ethyl_alcohol_1, na.rm = TRUE) * 100), 1),
    ethyl_alcohol_2_pop = round((Ethyl_alcohol_2 / max(Ethyl_alcohol_2, na.rm = TRUE) * 100), 1),
    beer_pop = round((Beer / max(Beer,  na.rm = TRUE)) * 100)
    )

# visualising the percentages of peaks on a line chart
food_beverages_pop |>
  e_charts(
    Year,
    height = 950
    ) |>
  e_line(
    sugar_pop,
    emphasis = list(
      focus = "series",      
      lineStyle = list(width = 5, opacity = 1)
      ),
    symbol = "circle", 
    symbolSize = 8,
    lineStyle = list(
      width = 6
    )
    ) |>
  e_line(
    glucose_pop,
    emphasis = list(
      focus = "series",      
      lineStyle = list(width = 5, opacity = 1)
    ),
    symbol = "circle", 
    symbolSize = 8,
    lineStyle = list(
      width = 6
    )
  ) |>
  e_line(
    coffee_substitute_pop,
    emphasis = list(
      focus = "series",      
      lineStyle = list(width = 5, opacity = 1)
    ),
    symbol = "circle", 
    symbolSize = 8,
    lineStyle = list(
      width = 6
    )
  ) |>
  e_line(
    seed_oil_pop,
    emphasis = list(
      focus = "series",      
      lineStyle = list(width = 5, opacity = 1)
    ),
    symbol = "circle", 
    symbolSize = 8,
    lineStyle = list(
      width = 6
    )
  ) |>
  e_line(
    ethyl_alcohol_1_pop,
    emphasis = list(
      focus = "series",      
      lineStyle = list(width = 5, opacity = 1)
    ),
    symbol = "circle", 
    symbolSize = 8,
    lineStyle = list(
      width = 6
    )
  ) |>
  e_line(
    ethyl_alcohol_2_pop,
    emphasis = list(
      focus = "series",      
      lineStyle = list(width = 5, opacity = 1)
    ),
    symbol = "circle", 
    symbolSize = 8,
    lineStyle = list(
      width = 6
    )
  ) |>
  e_line(
    beer_pop,
    emphasis = list(
      focus = "series",      
      lineStyle = list(width = 5, opacity = 1)
    ),
    symbol = "circle", 
    symbolSize = 8,
    lineStyle = list(
      width = 6
    )
  ) |>
  
  e_x_axis(
    min = 1871,
    max = 1985,
    axisLabel = list(interval = 0)
    ) |>
  e_tooltip(
    trigger = "item"
    )

"
  The line chart looks and feels really dense, prompting 'squinting' to find 
  points, so I'm pivoting to the heatmap so I can at least flatten one 
  dimension to simplify the vieweing
"

# pivoting the data to create a long format suitable for the chart type
food_beverages_pop_longer <-
  food_beverages_pop |> 
  pivot_longer(
    cols = -c(
      Year, 
      Sugar,
      Seed_oil, 
      Glucose, 
      Ethyl_alcohol_1, 
      Ethyl_alcohol_2, 
      Coffee_substitute, 
      Beer),
    names_to = "product",
    values_to = "pop"
    )

# including padding years to ensure all three charts end up lining up
food_beverages_padded <- food_beverages_pop_longer |>
  group_by(product) |>
  complete(Year = 1861:1985) |> # This adds the dummy years at both ends
  ungroup()

# exporting the table to use in quarto
write.csv(food_beverages_padded, file = "data/food_beverages_padded.csv", row.names = FALSE)

# visualising the food and beverages percentages of peaks on a heatmap
food_beverages_padded |>
  e_charts(
    Year,
    height = 280
    ) |>
  e_heatmap(
    product,
    pop,
    itemStyle = list(
      borderColor = "#ffffff", 
      borderWidth = 3         
      )
    ) |>
  e_visual_map(
    show = FALSE,
    pop,
    orient = "horizontal",
    calculable = TRUE,
    inRange = list(
      color = c("#fff", "#ff1000ff")
      ),
  min = min(food_beverages_padded$pop, na.rm = TRUE),
  max = max(food_beverages_padded$pop, na.rm = TRUE),
  outOfRange = list(
    color = "#fff"
    )
  ) |>
  e_grid(
    left = 250,
    right = 5,
    top = 5,
    bottom = 5
  ) |>
  e_tooltip(
    trigger = "axis"
    )

# ----
# TEXTILES
textiles_pop <- textiles |>
  mutate(
    cotton_yarn_pop = round((Cotton_yarn / max(Cotton_yarn, na.rm = TRUE) * 100), 1),
    flock_yarn_pop = round((Flock_yarn / max(Flock_yarn, na.rm = TRUE) * 100), 1),
    other_yarn_pop = round((Other_yarn / max(Other_yarn, na.rm = TRUE) * 100), 1),
    total_yarn_pop = round((Total_yarn / max(Total_yarn, na.rm = TRUE) * 100), 1),
    cotton_textiles_pop = round((Cotton_textiles / max(Cotton_textiles, na.rm = TRUE) * 100), 1),
    flock_textiles_pop = round((Flock_textiles / max(Flock_textiles, na.rm = TRUE) * 100), 1),
    other_textiles_pop = round((Other_textiles / max(Other_textiles, na.rm = TRUE) * 100), 1),
    total_textiles_pop = round((Total_textiles / max(Total_textiles, na.rm = TRUE) * 100), 1),
    raw_silk_pop =  round((Raw_silk / max(Raw_silk, na.rm = TRUE) * 100), 1)
  )

# pivoting the data to create a long format suitable for the chart type
textiles_pop_longer <-
  textiles_pop |> 
  pivot_longer(
    cols = -c(
      Year, 
      Cotton_yarn,
      Flock_yarn, 
      Other_yarn, 
      Total_yarn, 
      Cotton_textiles, 
      Flock_textiles, 
      Other_textiles,
      Total_textiles,
      Raw_silk
      ),
    names_to = "product",
    values_to = "pop"
    )

# including padding years to ensure all three charts end up lining up
textiles_padded <- textiles_pop_longer |>
  group_by(product) |>
  complete(Year = 1861:1985) |> 
  ungroup()

# exporting the table to use in quarto
write.csv(textiles_padded, file = "data/textiles_padded.csv", row.names = FALSE)

# visualising the textiles percentages of peaks on a heatmap
textiles_padded |>
  e_charts(
    Year,
    height = 360
  ) |>
  e_heatmap(
    product,
    pop,
    itemStyle = list(
      borderColor = "#ffffff", 
      borderWidth = 3         
    )
  ) |>
  e_visual_map(
    show = FALSE,
    pop,
    orient = "horizontal",
    calculable = TRUE,
    inRange = list(
      color = c("#fff", "#ab263cff")
    ),
    min = min(textiles_padded$pop, na.rm = TRUE),
    max = max(textiles_padded$pop, na.rm = TRUE),
    outOfRange = list(
      color = "#fff"
    )
  ) |>
  e_grid(
    left = 250,
    right = 5,
    top = 5,
    bottom = 5
    ) |>
  e_tooltip(
    trigger = "axis"
  )

# ----
# TRANSPORT
transport_pop <- transport |>
  mutate(
    ships_launched_pop = round((Ships_launched / max(Ships_launched, na.rm = TRUE) * 100), 1),
    ships_weight_pop = round((Ships_weight / max(Ships_weight, na.rm = TRUE) * 100), 1),
    avg_ship_weight = round((Ships_weight / Ships_launched * 100), 1),
    avg_ship_weight_pop = round(((Ships_weight / Ships_launched * 100) / max((Ships_weight / Ships_launched * 100), na.rm = TRUE) * 100), 1),
    steam_and_electric_engine_pop = round((Steam_and_electric_engine / max(Steam_and_electric_engine, na.rm = TRUE) * 100), 1),
    rail_cars_and_electric_locomotives_pop = round((Rail_cars_and_electric_locomotives / max(Rail_cars_and_electric_locomotives, na.rm = TRUE) * 100), 1),
    carriages_and_trailers_pop = round((Carriages_and_trailers / max(Carriages_and_trailers, na.rm = TRUE) * 100), 1),
    mail_luggage_vans_and_carriages_pop = round((Mail_luggage_vans_and_carriages / max(Mail_luggage_vans_and_carriages, na.rm = TRUE) * 100), 1),
    passenger_cars_pop = round((Passenger_cars / max(Passenger_cars, na.rm = TRUE) * 100), 1),
    other_pop =  round((Other / max(Other, na.rm = TRUE) * 100), 1)
    )

# pivoting the data to create a long format suitable for the chart type
transport_pop_longer <-
  transport_pop |> 
  pivot_longer(
    cols = -c(
      Year, 
      Ships_launched,
      Ships_weight, 
      Steam_and_electric_engine, 
      Rail_cars_and_electric_locomotives, 
      Carriages_and_trailers, 
      Mail_luggage_vans_and_carriages, 
      Passenger_cars,
      Other,
      avg_ship_weight
      ),
    names_to = "product",
    values_to = "pop"
    )

# including padding years to ensure all three charts end up lining up
transport_padded <- transport_pop_longer |>
  group_by(product) |>
  complete(Year = 1861:1985) |> 
  ungroup()

# exporting the table to use in quarto
write.csv(transport_padded, file = "data/transport_padded.csv", row.names = FALSE)

# visualising the transport percentages of peaks on a heatmap
transport_padded |>
  e_charts(
    Year,
    height = 360
  ) |>
  e_heatmap(
    product,
    pop,
    itemStyle = list(
      borderColor = "#ffffff", 
      borderWidth = 3         
    )
  ) |>
  e_visual_map(
    show = FALSE,
    pop,
    orient = "horizontal",
    calculable = TRUE,
    inRange = list(
      color = c("#fff", "#E3735E")
    ),
    min = min(textiles_padded$pop, na.rm = TRUE),
    max = max(textiles_padded$pop, na.rm = TRUE),
    outOfRange = list(
      color = "#fff"
    )
  ) |>
  e_grid(
    left = 250,
    right = 5,
    top = 5,
    bottom = 5
  ) |>
  e_tooltip(
    trigger = "axis"
  )
