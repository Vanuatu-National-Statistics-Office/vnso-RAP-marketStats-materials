#Processing of the Market Survey MS2 Collection

#Load library
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
mydb <- dbConnect(RSQLite::SQLite(), "data/secure/sqlite/msurvey.sqlite")

#### Processing of Market Survey MS2 Collection ####
#Load MS2 Files Data Processing - reading Data Tabs from Tablet

#Loading master ms2
ms2_master <- read.delim("data/secure/ms2/VNSOMCS.tab")
ms2_staple_roster <- read.delim("data/secure/ms2/root_crop_roster.tab")
ms2_vegetable_roster <- read.delim("data/secure/ms2/vegis_roster.tab")
ms2_fruit_roster <- read.delim("data/secure/ms2/fruits_roster.tab")

#Load Lookup Tables from ms2Classification.xlsx file
#Re-classify items and measures
ms2_fruittype <- read_excel("data/open/ms2classification.xlsx", sheet = "fruittype")
ms2_fruitmeasure <- read_excel("data/open/ms2classification.xlsx", sheet = "fruitmeasure")
ms2_stapletype <- read_excel("data/open/ms2classification.xlsx", sheet = "stapletype")
ms2_stapletypemeasure <- read_excel("data/open/ms2classification.xlsx", sheet = "staplemeasure")
ms2_vegetabletype <- read_excel("data/open/ms2classification.xlsx", sheet = "vegtype")
ms2_vegetablemeasure <- read_excel("data/open/ms2classification.xlsx", sheet = "vegmeasure")

#Writing new classified tables to the database
dbWriteTable(mydb, "ms2_fruittype", ms2_fruittype, overwrite=TRUE)
dbWriteTable(mydb, "ms2_fruitmeasure", ms2_fruitmeasure, overwrite=TRUE)
dbWriteTable(mydb, "ms2_stapletype", ms2_stapletype, overwrite=TRUE)
dbWriteTable(mydb, "ms2_stapletypemeasure", ms2_stapletypemeasure, overwrite=TRUE)
dbWriteTable(mydb, "ms2_vegetabletype", ms2_vegetabletype, overwrite=TRUE)
dbWriteTable(mydb, "ms2_vegetablemeasure", ms2_vegetablemeasure, overwrite=TRUE)


#Cleaning master
ms2_master$id <- ms2_master$ï..interview__key #Renaming field=ï..interview__key in table ms2_master to id
ms2_master_extract <- ms2_master[ , c("id","week","year","market","survey_date")]

dbWriteTable(mydb, "ms2_master", ms2_master_extract, overwrite=TRUE)

#ms2 Staple Food (root crop) 
ms2_staple_roster$id <- ms2_staple_roster$ï..interview__key # renaming ï..interview__key to id in ms2_staple_roster
ms2_staple_roster_final <- ms2_staple_roster %>% select (-ï..interview__key) # assigning to new table and dropping ï..interview__key
dbWriteTable(mydb, "ms2_staple", ms2_staple_roster_final, overwrite=TRUE) 



ms2_fruit_roster$id <- ms2_fruit_roster$ï..interview__key
ms2_fruit_roster_final <- ms2_fruit_roster %>% select (-ï..interview__key)
dbWriteTable(mydb, "ms2_fruit", ms2_fruit_roster_final, overwrite=TRUE)


ms2_vegetable_roster$id <- ms2_vegetable_roster$ï..interview__key
ms2_vegetable_roster_final <- ms2_vegetable_roster %>% select (- ï..interview__key)
dbWriteTable(mydb, "ms2_vegetable", ms2_vegetable_roster_final, overwrite=TRUE)

#Extract MS2 Staple records from the SQLite database

ms2_staple_collection <- dbGetQuery(mydb, "SELECT ms2_master.id,
                                                  ms2_master.week,
                                                  ms2_master.year,
                                                  ms2_master.market,
                                                  marketLocation.locationdescription,
                                                  ms2_master.survey_date,
                                                  ms2_staple.root_crop_roster__id,
                                                  ms2_stapletype.stapleFoodDescription,
                                                  ms2_staple.measure_type,
                                                  ms2_stapletypemeasure.stapleFoodMeasureDescription,
                                                  ms2_staple.staple_wieght1,
                                                  ms2_staple.staple_price1,
                                                  ms2_staple.staple_wieght2,
                                                  ms2_staple.staple_price2,
                                                  ms2_staple.staple_wieght3,
                                                  ms2_staple.staple_price3,
                                                  ms2_staple.staple_wieght4,
                                                  ms2_staple.staple_price4,
                                                  ms2_staple.staple_wieght5,
                                                  ms2_staple.staple_price5
                                            FROM ms2_master
                                            INNER JOIN ms2_staple ON ms2_master.id = ms2_staple.id 
                                            INNER JOIN marketLocation ON ms2_master.market = marketLocation.market_location
                                            INNER JOIN ms2_stapletypemeasure ON ms2_staple.measure_type = ms2_stapletypemeasure.stapleFoodMeasure
                                            INNER JOIN ms2_stapletype ON ms2_staple.root_crop_roster__id = ms2_stapletype.stapleFood
                                    ")

dbWriteTable(mydb, "ms2_staple_collection", ms2_staple_collection, overwrite = TRUE)

#Extract MS2 vegetable records from the SQLite database

ms2_vegetable_collection <- dbGetQuery(mydb, "SELECT ms2_master.id,
                                                  ms2_master.week,
                                                  ms2_master.year,
                                                  ms2_master.market,
                                                  marketLocation.locationdescription,
                                                  ms2_master.survey_date,
                                                  ms2_vegetable.vegis_roster__id,
                                                  ms2_vegetabletype.vegetableDescription,
                                                  ms2_vegetable.veg_measure_type,
                                                  ms2_vegetablemeasure.vegetableMeasureDescription,
                                                  ms2_vegetable.vegetables_weight1,
                                                  ms2_vegetable.vegetable_price1,
                                                  ms2_vegetable.vegetables_weight2,
                                                  ms2_vegetable.vegetable_price2,
                                                  ms2_vegetable.vegetables_weight3,
                                                  ms2_vegetable.vegetable_price3,
                                                  ms2_vegetable.vegetables_weight4,
                                                  ms2_vegetable.vegetable_price4,
                                                  ms2_vegetable.vegetables_weight5,
                                                  ms2_vegetable.vegetable_price5
                                            FROM ms2_master
                                            INNER JOIN ms2_vegetable ON ms2_master.id = ms2_vegetable.id
                                            INNER JOIN marketLocation ON ms2_master.market = marketLocation.market_location
                                            INNER JOIN ms2_vegetablemeasure ON ms2_vegetable.veg_measure_type = ms2_vegetablemeasure.vegetableMeasure 
                                            INNER JOIN ms2_vegetabletype ON ms2_vegetable.vegis_roster__id = ms2_vegetabletype.Vegetable
                                       ")

dbWriteTable(mydb, "ms2_vegetable_collection", ms2_vegetable_collection, overwrite = TRUE)


#Extract MS2 fruit records from the SQLite database

ms2_fruit_collection <- dbGetQuery(mydb, "SELECT ms2_master.id,
                                                  ms2_master.week,
                                                  ms2_master.year,
                                                  ms2_master.market,
                                                  marketLocation.locationdescription,
                                                  ms2_master.survey_date,
                                                  ms2_fruit.fruits_roster__id,
                                                  ms2_fruittype.fruitTypeDescription,
                                                  ms2_fruit.F_measure_type,
                                                  ms2_fruitmeasure.fruitMeasureDescription,
                                                  ms2_fruit.fruit_weight1,
                                                  ms2_fruit.fruit_price1,
                                                  ms2_fruit.fruit_weight2,
                                                  ms2_fruit.fruit_price2,
                                                  ms2_fruit.fruit_weight3,
                                                  ms2_fruit.fruit_price3,
                                                  ms2_fruit.fruit_weight4,
                                                  ms2_fruit.fruit_price4,
                                                  ms2_fruit.fruit_weight5,
                                                  ms2_fruit.fruit_price5
                                            FROM ms2_master
                                            INNER JOIN ms2_fruit ON ms2_master.id = ms2_fruit.id 
                                            INNER JOIN marketLocation ON ms2_master.market = marketLocation.market_location
                                            INNER JOIN ms2_fruitmeasure ON ms2_fruit.F_measure_type = ms2_fruitMeasure.fruitMeasure
                                            INNER JOIN ms2_fruittype ON ms2_fruit.fruits_roster__id = ms2_fruitType.fruitType
                                   
                                   ")

dbWriteTable(mydb, "ms2_fruit_collection", ms2_fruit_collection, overwrite = TRUE )

#Extract all ms2 collection tables from SQLite

ms2_staple_food_collection <- dbGetQuery(mydb, "SELECT * FROM ms2_staple_collection")
ms2_vegetable_food_collection <- dbGetQuery(mydb, "SELECT * FROM ms2_vegetable_collection")
ms2_fruit_food_collection <- dbGetQuery(mydb, "SELECT * FROM ms2_fruit_collection")


#Write all extracted ms2 collections to CSV files

write.csv(ms2_staple_food_collection, "data/open/ms2_output/ms2_statple_food_collection.csv", row.names = FALSE)
write.csv(ms2_vegetable_food_collection, "data/open/ms2_output/ms2_vegetable_food_collection.csv", row.names = FALSE)
write.csv(ms2_fruit_food_collection, "data/open/ms2_output/ms2_fruit_food_collection.csv", row.names = FALSE)

dbDisconnect(mydb)
