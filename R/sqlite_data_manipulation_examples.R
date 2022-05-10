# Illustrative SQL code to demonstrate some simple data manipulation
# Code taken and adapted from: https://db.rstudio.com/databases/sqlite/

#### Preparation ####

# loading required libraries
library(DBI) #  handling databases
library(RSQLite) # working with sqllite: install.packages("RSQLite")
library(dplyr) # for creating dataframes

# loadinfg mtcars example dataframe
data(mtcars)

# adding row names as column to include car model in database
mtcars$car_model <- rownames(mtcars)

# creating two dataframes to demonstrate joining dateframes further down
df_mtcars_one <- mtcars %>%
  select(car_model, mpg, cyl, disp, hp, drat)

df_mtcars_two <- mtcars %>%
  select(car_model, wt, qsec, vs, am, gear, carb)

#### Store data in local sqlite database ####

# creating an temporary in-memory RSQLite database
connection <- dbConnect(RSQLite::SQLite(), ":memory:")

# listing the tables in the database - none at this point
dbListTables(connection)

# writing the 1st example mtcars dataframe to the SQLite database
dbWriteTable(connection, "df_mtcars_one", df_mtcars_one)

# viewing the tables - should now include mtcars
dbListTables(connection)

# viewing the fields within a table on SQLite database
dbListFields(connection, "df_mtcars_one")

# writing the 2nd example mtcars dataframe to the SQLite database
dbWriteTable(connection, "df_mtcars_two", df_mtcars_two)

# writing the whole mtcars into database
dbWriteTable(connection, "mtcars", mtcars, overwrite = TRUE)

#### Simple SQL based data manipulation ####

# subsetting: select subset of columns
subset <- dbGetQuery(connection, "SELECT car_model, mpg FROM mtcars")
head(subset)

# filtering: fetch the mtcars data where cylinder field equals 4
filtering <- dbGetQuery(connection, "SELECT * FROM mtcars WHERE cyl = 4")
head(filtering)

# text processing: reformat car_model column to extract car brand
#      SUBSTR(string, start, n_char): returns subset of string based on start index and number characters
#      TRIM(string): removes spaces from string by default
#      INSTR(ori_str, sub_str): notes position of sub_str within ori_str
dbExecute(connection, "ALTER TABLE mtcars ADD COLUMN car TEXT")
dbExecute(connection, "UPDATE mtcars SET car = SUBSTR(TRIM(car_model), 1, INSTR(TRIM(car_model)||' ', ' ')-1)")
head(dbReadTable(connection, "mtcars"))

# grouping: group by cars to get the average weight of car models and the count of cars being used in calcs
grouping <- dbGetQuery(connection, "SELECT car,
                             AVG(wt) AS weight,
                             COUNT(car_model) AS number
                             FROM mtcars
                             GROUP BY car")
head(grouping)

# joining - joining to tables in database
joined <- dbGetQuery(connection, "SELECT *
                                 
                                 FROM df_mtcars_one
                                 JOIN df_mtcars_two
                                 
                                 ON df_mtcars_two.car_model = df_mtcars_one.car_model")
head(joined)

# stacked - subseting, filtering, and grouping
filtered_grouped_subset <- dbGetQuery(connection, "SELECT gear,
                                 AVG(mpg), 
                                 SUM(wt), 
                                 AVG(disp)
                                 FROM mtcars WHERE wt > 2 AND wt < 5
                                 GROUP BY gear")
head(filtered_grouped_subset)

# stacked - subsetting and joining
joined_subset <- dbGetQuery(connection, "SELECT
                                 df_mtcars_one.car_model,
                                 df_mtcars_one.mpg,
                                 df_mtcars_one.cyl,
                                 
                                 df_mtcars_two.wt,
                                 df_mtcars_two.gear
                                 
                                 FROM df_mtcars_one
                                 JOIN df_mtcars_two
                                 
                                 ON df_mtcars_two.car_model = df_mtcars_one.car_model")
head(joined_subset)
