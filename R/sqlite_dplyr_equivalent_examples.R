# Code taken and adapted from: https://db.rstudio.com/databases/sqlite/

library(DBI) #  handling databases
library(RSQLite) # working with sqllite: install.packages("RSQLite")
library(dplyr) # for creating dataframes

# converting rownames to column to include car model in database
mtcars <- sqlRownamesToColumn(mtcars)

# creating two dataframes to demonstrate joining dateframes further down
df_mtcars_one <- mtcars %>%
  select(row_names, mpg, cyl, disp, hp, drat)

df_mtcars_two <- mtcars %>%
  select(row_names, wt, qsec, vs, am, gear, carb)


## start of RSQL code

# Create an ephemeral in-memory RSQLite database
con <- dbConnect(RSQLite::SQLite(), ":memory:")

# List the tables in the database - none at this point
dbListTables(con)

# Write the 1st example mtcars dataframe to the SQLite database
dbWriteTable(con, "df_mtcars_one", df_mtcars_one)

# View the tables - should now include mtcars
dbListTables(con)

# View the fields within a table on SQLite database
dbListFields(con, "df_mtcars_one")

# Write the 2nd example mtcars dataframe to the SQLite database
dbWriteTable(con, "df_mtcars_two", df_mtcars_two)


## subsetting columns and joining two dataframes
subsetting_columns <- dbGetQuery(con, "SELECT
                                 df_mtcars_one.row_names,
                                 df_mtcars_one.mpg,
                                 df_mtcars_one.cyl,
                                 
       
                                 df_mtcars_two.wt,
                                 df_mtcars_two.gear
                                 
                                 FROM df_mtcars_one
                                 JOIN df_mtcars_two
                                 
                                 ON df_mtcars_two.row_names = df_mtcars_one.row_names")


# Writing the whole mtcars into database
dbWriteTable(con, "mtcars", mtcars, overwrite = TRUE)

# Fetch all of the table
all_mtcars <- dbGetQuery(con, "SELECT * FROM mtcars")
# For illustration, this includes all `cyl` values:
head(all_mtcars)

# Subsetting - fetch the mtcars data where cylinder field equals 4
filtering <- dbGetQuery(con, "SELECT * FROM mtcars WHERE cyl = 4")
head(filtering)

# Group by cars to get the average weight of car models, total number of gears, and the count of cars being used in calcs
grouping <- dbGetQuery(con, "SELECT substr(trim(row_names),1,instr(trim(row_names)||' ',' ')-1) AS car,
                             AVG(wt) AS weight,
                             COUNT(row_names) AS number,
                             SUM(gear) AS gears
                             FROM mtcars
                             GROUP BY car")
head(grouping)

