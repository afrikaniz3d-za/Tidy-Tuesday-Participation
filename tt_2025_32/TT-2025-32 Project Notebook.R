---
title: "Climate Events in Sub-Saharan Africa"
subtitle: "Tidy Tuesday, Week 32, 2025"
date: 08-23-2025
author: Ntobeko Sosibo
toc: true
toc-location: left
toc-title: "Outline"
toc-depth: 6
format: html
embed-resources: true
self-contained: true

---
![][1]
&nbsp;  

##  1.  Project overview  
####  1.1 The Goal   
For this analysis, the goal was to focus on Sub-Saharan Africa, only exploring the recorded climate events within the region and filtering out any related studies in order to answer the question:  
&nbsp;
<p align="center">**Which were the most frequent climate events in Sub-Saharan Africa?**.</p>

####  1.2 Process  
In **MySQL** I performed data transformation on the date column to extract two new variables to represent the start and end of an event. I then created an aggregated table that was exported as a *CSV* file. This table was imported into **RStudio** and a scatter plot was generated to visualize event data over the years.

####  1.3 Insights  
- There were fewer climate event records in the region before 2010  
- Rain and flooding, as well as Drought, were the most common events  
- The frequency of Rain and flooding events has been increasing, whereas drought events have been on the decline  

&nbsp;  

## 2. Data Exploration  

The majority of the data exploration was done in **MySQL**.

#### 2.1 About the dataset  
The dataset comprises 743 rows and 14 variables. The `study_focus` column shows that the records are divided into two categories - `"Study"` and `"Event"`.The earliest record is dated *1961* and the most recent is *2024*. There are seven (7) types of recorded climate events, some of them spanning more than one year.  

#### 2.2 Data types  
Before I could do any calculations, I first needed to modify the date columns because they were recorded as `TEXT` data types.  

&nbsp;  
Query looking at the  data types:  

```sql
  DESCRIBE
		attribution_studies;
```  
&nbsp;  
Result set:  

+----------------------+---------------+
| **FIELD**            | **TYPE**      |
+----------------------+---------------+
| event_name           | TEXT          |
+----------------------+---------------+
| event_period         | TEXT          |
+----------------------+---------------+
| event_year           | TEXT          |
+----------------------+---------------+
| study_focus          | TEXT          |
+----------------------+---------------+
| iso_country_code     | TEXT          |
+----------------------+---------------+
| cb_region            | TEXT          |
+----------------------+---------------+
| event_type           | TEXT          |
+----------------------+---------------+
| classification       | TEXT          |
+----------------------+---------------+
| summary_statement    | TEXT          |
+----------------------+---------------+
| publication_year     | DOUBLE        |
+----------------------+---------------+
| citation             | TEXT          |
+----------------------+---------------+
| source               | TEXT          |
+----------------------+---------------+
| rapid_study          | TEXT          |
+----------------------+---------------+
| link                 | TEXT          |
+----------------------+---------------+

&nbsp;   

#### 2.3  Data manipulation  
I knew I wouldn't need all of them for the project, so I began filtering the dataset down, choosing to keep `event_type` and `event_year`. With `CASE` statements I created two new columns, `year_start` and `year_end`, I trimmed the strings in the rows where they spanned more than a year. I also created the new column, `year_count`, that indicated how long the recorded event was. These new columns made it possible to perform calculations.    

&nbsp;  
```sql
use tidy_tuesday_2025_32;

WITH events AS (
	SELECT
		*
	FROM
		attribution_studies
	WHERE 
		study_focus = 'Event' AND
		cb_region = 'Sub-Saharan Africa'),
    
events_start_end AS (
	SELECT
		event_type,
		CASE 
			WHEN event_year LIKE '____' THEN event_year
			WHEN event_year LIKE '____%____' THEN LEFT(event_year, 4)
			ELSE NULL 
		END AS year_start,
		CASE
			WHEN event_year LIKE '____' THEN event_year
			WHEN event_year LIKE '____%____' THEN RIGHT(event_year, 4)
			ELSE NULL 
		END AS year_end
	FROM 
		events
	ORDER BY
		year_start,
        event_type)

SELECT
	event_type,
    year_start,
    year_end,
    (year_end - year_start + 1) AS year_count,
    COUNT(*) AS event_count
FROM
	events_start_end
GROUP BY
	event_type,
    year_start,
    year_end,
    year_count
ORDER BY
	year_start,
    event_type;
```  
&nbsp;  

The result set (first 5 rows):  

+----------------------+-----------------+----------------+-----------------+-----------------+
| **event_type**       | **year_start**  | **year_end**   | **year_count**  | **event_count** | 
+----------------------+-----------------+----------------+-----------------+-----------------+
| Compound             | 1992            | 1992           | 1               | 1               |
+----------------------+-----------------+----------------+-----------------+-----------------+
| Rain & flooding      | 1999            | 2000           | 2               | 1               |
+----------------------+-----------------+----------------+-----------------+-----------------+
| Drought              | 2002            | 2003           | 2               | 1               |
+----------------------+-----------------+----------------+-----------------+-----------------+
| Compound             | 2007            | 2007           | 1               | 1               |
+----------------------+-----------------+----------------+-----------------+-----------------+
| Impact               | 2007            | 2007           | 1               | 1               |
+----------------------+-----------------+----------------+-----------------+-----------------+
&nbsp;   

#### 2.4  Exporting aggregated table  
I generated an aggregated table using the query below to count the number of climate events grouped by event type and the year they occured in:  

&nbsp; 
```sql
use tidy_tuesday_2025_32;

SELECT
	CASE 
		WHEN LENGTH(`event_year`) = 4 THEN `event_year`
		WHEN `event_year` LIKE '____-____' THEN SUBSTR(`event_year`, 1, 4)
		ELSE 'investigate'
	END AS `year`,
    event_type,
    COUNT(*) AS `events`
FROM
	attribution_studies
WHERE
	study_focus = 'Event'
GROUP BY
	`year`,
    event_type
ORDER BY 
	`year`;
```  

+------------+-------------------+-------------+
| **year**   | **event_type**    | **events**  |
+------------+-------------------+-------------+
| 1961       | Compound          | 1           |
+------------+-------------------+-------------+
| 1976       | Compound          | 1           |
+------------+-------------------+-------------+
| 1976       | Drought           | 1           |
+------------+-------------------+-------------+
| 1976       | Heat              | 1           |
+------------+-------------------+-------------+
| 1992       | Compound          | 1           |
+------------+-------------------+-------------+
| 1993       | Storm             | 1           |
+------------+-------------------+-------------+
| 1999       | Rain & flooding   | 1           |
+------------+-------------------+-------------+
| 2000       | Impact            | 1           |
+------------+-------------------+-------------+
| 2000       | Rain & flooding   | 2           |
+------------+-------------------+-------------+
| 2000       | River flow        | 2           |
+------------+-------------------+-------------+
  
##  3.  Visualization  
I initially chose to use a [range bar graph](https://docs.anychart.com/Basic_Charts/Range_Bar_Chart#:~:text=Point%20Size-,Overview,Modules) to depict the climate events on a timeline, but ran into legibility issues around areas where there was some overlap - even if I took advantage of using alpha values to emphasis intensity. The better option ended up being a simple scatter plot graph.  

####  3.1 Preparing data for visualization   
Additional data manipulation was needed to generate the table for GGPlot map out, namely the time component. Although the beginning and the end of the climate events was present, I needed a new column, `year_mid`, that could map to the relative positions of events that occurred over multiple years. I already had `year_start` and `year_end` generated in *MySQL*. Rather than going back and updating the table I defined the new variable in R:  

&nbsp;  
```{r}
#| label: fig-ssa
#| fig-cap: "Climate Events in Sub-Saharan Africa."
#| fig-width: 16
#| fig-height: 8
#| fig-align: "center"
#| warning: false

library(ggplot2)
library(readr)
library(ggthemes)
library(stringr)

ssa <- read.csv("/home/ntobeko/tt_2025_32/data/event_count_length_bytype.csv")
ssa$year_start <- as.integer(ssa$year_start)
ssa$year_end   <- as.integer(ssa$year_end)
ssa$year_mid <- (ssa$year_start + ssa$year_end) / 2

trend_text <- "Droughts are the most frequent and prolonged events, with rain and flooding occurring regularly but typically shorter. Multiple event types increasingly overlap in recent years, highlighting periods of compounded climate stress."

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
  scale_size_continuous(range = c(3, 8)) +
  scale_x_continuous(breaks = seq(1990, 2025, 5)) +
  scale_y_discrete(expand = expansion(add = 2)) +
  coord_cartesian(ylim = c(0.5, length(unique(ssa$event_type)) - 1)) +
  labs(
    x = "Year",
    y = "Climate Event",
    title = "Tidy Tuesday - 2025, Week 32",
    subtitle = "Climate Events in Sub-Saharan Africa (1992-2024)" ,
    caption = str_wrap(trend_text, width = 80) 
  ) +
  theme_fivethirtyeight() +
  theme(
    axis.text.x = element_text(size = 12),
    axis.text.y = element_text(size = 12, face = "bold"),
    axis.title.x = element_text(size = 16, face = "bold", margin = margin(t = 55)), 
    axis.title.y = element_text(size = 16, face = "bold", margin = margin(r = 55)), 
    plot.title = element_text(size = 22, face = "bold"),
    plot.subtitle = element_text(size = 16, margin = margin(b = 10)),
    plot.caption = element_text(size = 16, face = "italic", hjust = 0.5, vjust = -2),
    legend.position = "none"
  )

```

##  4. Conclusion  
- the chart makes it easier to visually identify the most turbulent periods for each event
- project could be taken further to incorporate the studies conducted around these events, including data from linked articles in the form of an interactive Shiny app that could provide even more context without being initially visually overbearing.

[1]: /content/images/tt_2025_32.png
