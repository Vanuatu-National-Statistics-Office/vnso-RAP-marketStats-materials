# Illustrative dplyr code to demonstrate some simple data manipulation
# For more information on using dpluyr see the following resources:
# - https://dplyr.tidyverse.org/
# - https://r4ds.had.co.nz/wrangle-intro.html

#### Preparation ####

# loading required libraries
library(dplyr) # working with data

# loading mtcars example dataframe
data(mtcars)

# adding row names as column to include car model in database
mtcars$car_model <- rownames(mtcars)

# creating two dataframes to demonstrate joining dateframes further down
df_mtcars_one <- mtcars %>%
  select(car_model, mpg, cyl, disp, hp, drat)

df_mtcars_two <- mtcars %>%
  select(car_model, wt, qsec, vs, am, gear, carb)

#### Store data for processing - NOT required for dplyr since data handled within R environment ####

# List all variables currently stored in R environment
ls()

#### Simple SQL based data manipulation ####
#### This mirrors the operations in `sqlite_data_manipulation_examples.R`
#### from line 50

# subsetting: select subset of columns
subset <- mtcars %>% select(car_model, mpg)
head(subset)

# filtering: fetch the mtcars data where cylinder field equals 4
filtered <- mtcars %>% filter(cyl == 4)
head(filtered)

# text processing: reformat car_model column to extract car brand
#      regexpr(pattern, string): returns index of start of match or -1
#      substr(string, start, end): removes spaces from string by default
mtcars <- mtcars %>%
  mutate(
    car = sub(" .*", "", car_model))
head(mtcars)

# grouping: group by cars to get the average weight of car models and the count of cars being used in calcs
grouped <- mtcars %>%
  group_by(car) %>%
  summarise(
    weight = mean(wt),
    number = length(car_model), .groups = "drop")
head(grouped)

# joining - joining to tables in database
joined <- left_join(df_mtcars_one, df_mtcars_two, by = "car_model")
head(joined)

# stacked - subseting, filtering, and grouping
filtered_grouped_subset <- mtcars %>%
  filter(wt > 2 && wt < 5) %>%
  group_by(gear) %>%
  summarise(
    mean(mpg),
    sum(wt),
    mean(disp), .groups = "drop")
head(filtered_grouped_subset)

# stacked - subsetting and joining
joined_subset <- left_join(df_mtcars_one, df_mtcars_two, by = "car_model") %>%
  select(mpg, cyl, wt, gear)
head(joined_subset)
