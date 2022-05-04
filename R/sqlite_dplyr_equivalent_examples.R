# Code taken and adapted from: https://db.rstudio.com/databases/sqlite/

library(DBI) #  handling databases
library(RQSLite) # working with sqllite: install.packages("RSQLite")

# Create an ephemeral in-memory RSQLite database
con <- dbConnect(RSQLite::SQLite(), ":memory:")

# List the tables in the database - none at this point
dbListTables(con)

# Write the exampel mtcars dataset to the SQLite database
dbWriteTable(con, "mtcars", mtcars)

# View the tables - should now include mtcars
dbListTables(con)

# View the fields within a table on SQLite database
dbListFields(con, "mtcars")

# Read in the table and store
cars_info <- dbReadTable(con, "mtcars")
View(cars_info)

# Fetch the mtcars data where cylinder field equals 4
cars_info_filtered_on_cylinder_size <- dbSendQuery(con, "SELECT * FROM mtcars WHERE cyl = 4")
dbFetch(cars_info_filtered_on_cylinder_size)

# Clear that subsetting table from SQLite database
dbClearResult(cars_info_filtered_on_cylinder_size)

# Clear the result
dbClearResult(res)

# Disconnect from the database
dbDisconnect(con)