#### Preparation ####

# Clear the environment
rm(list = ls())

# Load the required libraries
library(dplyr) #Data manipulation
library(readxl) #read in Excel files
library(tibble)
library(tidyverse)
library(RSQLite) #R SQLite driver package
library(DBI) #Database driver package

#Mapping of the directory path
setwd(paste0(getwd()))
getwd()

#Establish connection the the SQLite database

mydb <- dbConnect(RSQLite::SQLite(), "data/secure/ms2/sqlite/ms2.sqlite")

#### Processing of Market Survey MS2 Collection ####
#Load MS2 Files Data Processing - reading Data Tabs from MS2 v2_1 (ver. 2)

#Loading master ms2 - MS2 v2_1 (ver. 2)
ms2_master <- read.delim("data/secure/ms2/VNSOMCS.tab")
ms2_staple_roster <- read.delim("data/secure/ms2/root_crop_roster.tab")
ms2_vegetable_roster <- read.delim("data/secure/ms2/vegis_roster.tab")
ms2_fruit_roster <- read.delim("data/secure/ms2/fruits_roster.tab")
ms2_staple_measurement <- read.delim("data/secure/ms2/measurement_rootcrop.tab")
ms2_measurement_vegetable <- read.delim("data/secure/ms2/measurement_vegetable.tab")
ms2_measurement_fruits <- read.delim("data/secure/ms2/measurement_fruits.tab")


#Load Look up Tables from MS2_v2_1_Classification.xlsx (directory: data/open)
#Re-classify items and measures
#Data is read from a single spreadsheet that has multiples sheets
ms2_fruittype <- read_excel("data/open/MS2_v2_1_Classification.xlsx", sheet = "fruit")
ms2_fruitmeasure <- read_excel("data/open/MS2_v2_1_Classification.xlsx", sheet = "fruitsmeasure")
ms2_stapletype <- read_excel("data/open/MS2_v2_1_Classification.xlsx", sheet = "rootcrop")
ms2_stapletypemeasure <- read_excel("data/open/MS2_v2_1_Classification.xlsx", sheet = "rootcropmeasure")
ms2_vegetabletype <- read_excel("data/open/MS2_v2_1_Classification.xlsx", sheet = "vegetabletype")
ms2_vegetablemeasure <- read_excel("data/open/MS2_v2_1_Classification.xlsx", sheet = "vegetablemeasure")
ms2_market <- read_excel("data/open/MS2_v2_1_Classification.xlsx", sheet = "marketlocation")

# Writing in new classified tables read from excel file - MS2_v2_1_Classification.xlsx above to the database
dbWriteTable(mydb, "ms2_fruittype", ms2_fruittype, overwrite=TRUE)
dbWriteTable(mydb, "ms2_fruitmeasure", ms2_fruitmeasure, overwrite=TRUE)
dbWriteTable(mydb, "ms2_stapletype", ms2_stapletype, overwrite=TRUE)
dbWriteTable(mydb, "ms2_stapletypemeasure", ms2_stapletypemeasure, overwrite=TRUE)
dbWriteTable(mydb, "ms2_vegetabletype", ms2_vegetabletype, overwrite=TRUE)
dbWriteTable(mydb, "ms2_vegetablemeasure", ms2_vegetablemeasure, overwrite=TRUE)
dbWriteTable(mydb, "ms2_market", ms2_market, overwrite=TRUE)

# Cleaning master 
# 1. Renaming Field = ï..interview__key in data frame= ms2_master to  id
# 2. Create new Data frame(ms2_master_extract) and assigning selected fields from data frame(ms2_master) to it
# 3. Write ms2_master_extract data frame into the ms2.sqlite database
#ms2_master$id <- ms2_master$ï..interview__key
colnames(ms2_master)[1] <- "id"
ms2_master_extract <- ms2_master[ , c("id", "week","year","market","survey_date")]
dbWriteTable(mydb, "ms2_master", ms2_master_extract, overwrite=TRUE)

#  Cleaning Staple Food (root crop)
# 1. Renaming ï..interview__key to id in ms2_staple_roster data frame
# 2. Assigning to new table (ms2_staple_roster_final) and dropping ï..interview__key
# 3. Add new table (ms2_staple) to database
# 4. Add root crop measurements (ms2_staple_measurement) to database
#ms2_staple_roster$id <- ms2_staple_roster$ï..interview__key 
colnames(ms2_staple_roster)[1] <- "id"
ms2_staple_roster_final <- ms2_staple_roster 
dbWriteTable(mydb, "ms2_staple", ms2_staple_roster_final, overwrite=TRUE) 

#ms2_staple_measurement$id <- ms2_staple_measurement$ï..interview__key
colnames(ms2_staple_measurement)[1] <- "id"
ms2_staple_measurement_final <- ms2_staple_measurement 
dbWriteTable(mydb, "ms2_staple_measurement", ms2_staple_measurement_final, overwrite=TRUE)

#  Cleaning Fruits
#ms2_fruit_roster$id <- ms2_fruit_roster$ï..interview__key
colnames(ms2_fruit_roster)[1] <- "id"
ms2_fruit_roster_final <- ms2_fruit_roster 
dbWriteTable(mydb, "ms2_fruit", ms2_fruit_roster_final, overwrite=TRUE)

#ms2_measurement_fruits$id <- ms2_measurement_fruits$ï..interview__key
colnames(ms2_measurement_fruits)[1] <- "id"
ms2_measurement_fruits_final <- ms2_measurement_fruits 
dbWriteTable(mydb, "ms2_measurement_fruits", ms2_measurement_fruits_final, overwrite=TRUE)


#  Cleaning Vegetable
#ms2_vegetable_roster$id <- ms2_vegetable_roster$ï..interview__key
colnames(ms2_vegetable_roster)[1] <- "id"
ms2_vegetable_roster_final <- ms2_vegetable_roster 
dbWriteTable(mydb, "ms2_vegetable", ms2_vegetable_roster_final, overwrite=TRUE)

#ms2_measurement_vegetable$id <- ms2_measurement_vegetable$ï..interview__key
colnames(ms2_measurement_vegetable)[1] <- "id"
ms2_measurement_vegetable_final <- ms2_measurement_vegetable
dbWriteTable(mydb, "ms2_measurement_vegetable", ms2_measurement_vegetable_final, overwrite=TRUE)

# Extract MS2 Staple records from the SQLite database
ms2_staple_collection <- dbGetQuery(mydb, "SELECT ms2_master.id,
                                                  ms2_master.week,
                                                  ms2_master.year,
                                                  ms2_market.market_desc,
                                                  ms2_master.survey_date,
                                                  
                                                  ms2_staple_measurement.root_crop_roster__id,
                                                  
                                                  ms2_stapletype.rootcrop_desc,
                                                  
                                                  ms2_stapletypemeasure.rootcropmeasure_desc,
                                                  
                                                  ms2_staple_measurement.staple_wieght1,
                                                  ms2_staple_measurement.staple_price1,
                                                  ms2_staple_measurement.staple_wieght2,
                                                  ms2_staple_measurement.staple_price2,
                                                  ms2_staple_measurement.staple_wieght3,
                                                  ms2_staple_measurement.staple_price3,
                                                  ms2_staple_measurement.staple_wieght4,
                                                  ms2_staple_measurement.staple_price4,
                                                  ms2_staple_measurement.staple_wieght5,
                                                  ms2_staple_measurement.staple_price5
                                            FROM ms2_master
                                            
                                            INNER JOIN ms2_market ON ms2_master.market = ms2_market.market_id
                                            INNER JOIN  ms2_staple_measurement ON ms2_master.id =  ms2_staple_measurement.id
                                            INNER JOIN ms2_stapletype ON ms2_staple_measurement.root_crop_roster__id = ms2_stapletype.rootcrop
                                            INNER JOIN ms2_stapletypemeasure ON ms2_staple_measurement.measurement_rootcrop__id = ms2_stapletypemeasure.rootcropmeasure
                                    ")

dbWriteTable(mydb, "ms2_staple_collection", ms2_staple_collection, overwrite = TRUE)


#Extract MS2 vegetable records from the SQLite database
ms2_vegetable_collection <- dbGetQuery(mydb, "SELECT ms2_master.id,
                                                  ms2_master.week,
                                                  ms2_master.year,
                                                  ms2_market.market_desc,
                                                  ms2_master.survey_date,
                                                  ms2_measurement_vegetable.vegis_roster__id,
                                                  ms2_vegetabletype.vegetabletype_desc,
                                                  ms2_vegetablemeasure.vegetablemeasure_desc,
                                                  ms2_measurement_vegetable.vegetable_price1,
                                                  ms2_measurement_vegetable.vegetables_weight1,
                                                  ms2_measurement_vegetable.vegetable_price2,
                                                  ms2_measurement_vegetable.vegetables_weight2,
                                                  ms2_measurement_vegetable.vegetable_price3,
                                                  ms2_measurement_vegetable.vegetables_weight3,
                                                  ms2_measurement_vegetable.vegetable_price4,
                                                  ms2_measurement_vegetable.vegetables_weight4,
                                                  ms2_measurement_vegetable.vegetable_price5,
                                                  ms2_measurement_vegetable.vegetables_weight5
                                                  
                                            FROM ms2_master
                                            
                                            INNER JOIN ms2_market ON ms2_master.market = ms2_market.market_id
                                            INNER JOIN ms2_measurement_vegetable ON ms2_master.id =  ms2_measurement_vegetable.id
                                            INNER JOIN ms2_vegetabletype ON ms2_measurement_vegetable.vegis_roster__id = ms2_vegetabletype.vegetabletype
                                            INNER JOIN  ms2_vegetablemeasure ON ms2_measurement_vegetable.measurement_vegetable__id = ms2_vegetablemeasure.vegetablemeasure
                                       ")

dbWriteTable(mydb, "ms2_vegetable_collection", ms2_vegetable_collection, overwrite = TRUE)

#Extract MS2 fruit records from the SQLite database
ms2_fruits_collection <- dbGetQuery(mydb, "SELECT ms2_master.id,
                                                  ms2_master.week,
                                                  ms2_master.year,
                                                  ms2_market.market_desc,
                                                  ms2_master.survey_date,
                                                  ms2_measurement_fruits.fruits_roster__id,
                                                  ms2_fruittype.fruit_type_desc,
                                                  ms2_fruitmeasure.measurement_fruits_desc,
                                                  ms2_measurement_fruits.fruit_price1,
                                                  ms2_measurement_fruits.fruit_weight1,
                                                  ms2_measurement_fruits.fruit_price2,
                                                  ms2_measurement_fruits.fruit_weight2,
                                                  ms2_measurement_fruits.fruit_price3,
                                                  ms2_measurement_fruits.fruit_weight3,
                                                  ms2_measurement_fruits.fruit_price4,
                                                  ms2_measurement_fruits.fruit_weight4,
                                                  ms2_measurement_fruits.fruit_price5,
                                                  ms2_measurement_fruits.fruit_weight5
                                                  
                                            FROM ms2_master
                                            
                                            INNER JOIN ms2_market ON ms2_master.market = ms2_market.market_id
                                            INNER JOIN ms2_measurement_fruits ON ms2_master.id =  ms2_measurement_fruits.id
                                            INNER JOIN ms2_fruittype ON ms2_measurement_fruits.fruits_roster__id = ms2_fruittype.fruit_type
                                            INNER JOIN  ms2_fruitmeasure ON ms2_measurement_fruits.measurement_fruits__id = ms2_fruitmeasure.measurement_fruits
                                       ")

dbWriteTable(mydb, "ms2_fruits_collection", ms2_fruits_collection, overwrite = TRUE)


#Extract all ms2 collection tables f0rom SQLite
ms2_staple_food_collection <- dbGetQuery(mydb, "SELECT * FROM ms2_staple_collection")
ms2_vegetable_food_collection <- dbGetQuery(mydb, "SELECT * FROM ms2_vegetable_collection")
ms2_fruit_food_collection <- dbGetQuery(mydb, "SELECT * FROM ms2_fruits_collection")


#Write all extracted ms2 collections to CSV files
write.csv(ms2_staple_collection, "data/secure/ms2/ms2_staple_collection.csv", row.names = FALSE)
write.csv(ms2_vegetable_collection, "data/secure/ms2/ms2_vegetable_collection.csv", row.names = FALSE)
write.csv(ms2_fruits_collection, "data/secure/ms2/ms2_fruits_collection.csv", row.names = FALSE)


#### Calculations - MS2 ####

#sumFiji_Taro <- ms2_staple_collection %>% group_by(rootcrop_desc) %>% count(id)
#Fiji_Taro_Weights <- ms2_staple_collection %>%
  #dplyr::filter(rootcrop_desc == "Fiji Taro") %>%
  #dplyr::select(id, rootcrop_desc, rootcropmeasure_desc, staple_wieght1, staple_price1, staple_wieght2, staple_price2, staple_wieght3, staple_price3, staple_wieght4, staple_price4, staple_wieght5, staple_price5) %>%
  #dplyr::mutate(avg_weight = ((staple_wieght1+staple_wieght2+staple_wieght3+staple_wieght4+staple_wieght5)/5)) %>%
  #dplyr::mutate(avg_price = ((staple_price1+staple_price2+staple_price3+staple_price4+staple_price5)/5))


# Note: keep both forms of analysis outlined here by UK for fruits, staple and vegetables

# Find all columns with product weights: (grep() returns the indexes of a given
# vector - here column names - that contain a given string):
weight_cols_idx <- grep("weight",names(ms2_staple_collection))

# Same for prices:
price_cols_idx <- grep("price",names(ms2_staple_collection))

# Subset the df by these indexes to just get a table of either the weights or
# prices, and calculate the row-sums using apply():
total_weight <- apply(ms2_staple_collection[,weight_cols_idx], 1, sum)
total_price <- apply(ms2_staple_collection[,price_cols_idx], 1, sum)

# To get total price per kilo, just divide the resulting vectors, and add this
# as new col 'price per kilo' to the df.
ms2_staple_collection$price_per_kilo <- total_price/total_weight

# You might want to "wrap" the above operations in a function (and put that in
# an external function you can source) to keep the script tidier.

#melt(ms2_fruits_collection, id.vars = c("fruit_type_desc","measurement_fruits_desc"))
# Get the names of the weight and price cols:
# weight_cols <- names(ms2_fruits_collection)[weight_cols_idx]
# price_cols <- names(ms2_fruits_collection)[price_cols_idx]

# Alternatively if you want to aggregate fruits/measurement types across years
# and markets (where applicable), it's easier to first create a "long" format of
# the df - so we have single column with prices and weights with fruit type and
# measurement repeated.
# We need a unique index per row so we can use the reshape() function:
ms2_staple_collection$idx <- row.names(ms2_staple_collection)

# Then reshape using columsn 9-18 and split this by weight and price:
ms2_staple_long <- 
  reshape(ms2_staple_collection, 
          idvar = "idx", 
          varying = c(9:18), v.names = c("weight", "price"), direction = "long")

# We don't need the idx var any more so remove this to keep things tidy:
ms2_staple_long$idx <- NULL
ms2_staple_collection$idx <- NULL

# We can now summarise (sum weights and prices) per fruit-measurement type:
ms2_staple_totals <- aggregate(cbind(weight, price) ~ 
                                 rootcrop_desc + 
                                 rootcropmeasure_desc, 
                               data = ms2_staple_long, sum)
ms2_staple_totals

# Price per kilo in these:
ms2_staple_totals$price_per_kilo <- ms2_staple_totals$price/ms2_staple_totals$weight
ms2_staple_totals



