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
library(lubridate) #Data manipulation

#Mapping of the directory path
setwd(paste0(getwd()))
getwd()

#Establish connection the the SQLite database
mydb <- dbConnect(RSQLite::SQLite(), "data/secure/sqlite/ms.sqlite")

#Import and prepare base weight table to be applied to MS1 collection
class_wgt <- read.csv("data/open/OPN_FINAL_VNSO_WeightingClassifications_10-04-22.csv")
dbWriteTable(mydb, "class_wgt", class_wgt, overwrite = TRUE)
class_wgt_app <- dbGetQuery(mydb, "SELECT Major, (Produce||'-'||Unit) AS produce, Weight FROM class_wgt")

dbWriteTable(mydb, "class_wgt_app", class_wgt_app, overwrite = TRUE)


#*************************************************** MS2 Processing ***********************************************************

#Loading master ms2 - MS2 v2_1 (ver. 2)
ms2_master <- read.delim("data/secure/ms2/VNSOMCS_1.tab")
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

ms2_staple_collection$sdate <- substr(ms2_staple_collection$survey_date, 1, nchar(ms2_staple_collection$survey_date)-9)
ms2_staple_collection$sdate <- as.Date(ms2_staple_collection$sdate, tryFormats = c("%Y-%m-%d", "%Y/%m/%d"), optional = FALSE)

ms2_staple_collection$sYear <- format(ms2_staple_collection$sdate, format= "%Y")
ms2_staple_collection$sMonth <- format(ms2_staple_collection$sdate, format= "%B")


dbWriteTable(mydb, "ms2_staple_collection", ms2_staple_collection, overwrite = TRUE)

#Extract ms1_staple_collection from sqlite database for tabulation by computing the period of collection
ms2_staple_composition <- dbGetQuery(mydb, "SELECT (sYear||'-'||sMonth||'-'||'wk'||week) AS period,
                                                  rootcrop_desc,
                                                  (rootcrop_desc||'-'||rootcropmeasure_desc) AS produce, 
                                                  SUM(staple_wieght1+staple_wieght2+staple_wieght3+staple_wieght4+staple_wieght5) AS totalWeight,
                                                  SUM(staple_price1+staple_price2+staple_price3+staple_price4+staple_price5) AS totalPrice
                                           FROM ms2_staple_collection
                                           GROUP BY period, produce")

dbWriteTable(mydb, "ms2_staple_composition", ms2_staple_composition, overwrite = TRUE)


#Generate a table by linking staple food with classification to collect major groupings
ms2_staple_composition_mjr <- dbGetQuery(mydb, "SELECT ms2_staple_composition.period, 
                                                       ms2_staple_composition.rootcrop_desc,
                                                       SUM(ms2_staple_composition.totalWeight) AS tWeight,
                                                       SUM(ms2_staple_composition.totalprice) AS tPrice
                                                       
                                                FROM ms2_staple_composition
                                                GROUP BY ms2_staple_composition.period, ms2_staple_composition.rootcrop_desc
                                         ")

#Claculate average price per kilo for each staple food category
ms2_staple_composition_mjr$avgPricePerKilo <- ms2_staple_composition_mjr$tPrice / ms2_staple_composition_mjr$tWeight

#Produce ms2 staple pivot table
ms2_staple_pivot <- ms2_staple_composition_mjr %>%
  pivot_wider(names_from = period, rootcrop_desc, values_from = avgPricePerKilo, values_fill = 0) %>%
  ungroup()
  
write.csv(ms2_staple_pivot, "data/open/ms2/ms2_staple_collection.csv", row.names = FALSE)


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

ms2_vegetable_collection$sdate <- substr(ms2_vegetable_collection$survey_date, 1, nchar(ms2_vegetable_collection$survey_date)-9)
ms2_vegetable_collection$sdate <- as.Date(ms2_vegetable_collection$sdate, tryFormats = c("%Y-%m-%d", "%Y/%m/%d"), optional = FALSE)

ms2_vegetable_collection$sYear <- format(ms2_vegetable_collection$sdate, format= "%Y")
ms2_vegetable_collection$sMonth <- format(ms2_vegetable_collection$sdate, format= "%B")

dbWriteTable(mydb, "ms2_vegetable_collection", ms2_vegetable_collection, overwrite = TRUE)

#Extract ms1_vegetable_collection from sqlite database for tabulation by computing the period of collection
ms2_vegetable_composition <- dbGetQuery(mydb, "SELECT (sYear||'-'||sMonth||'-'||'wk'||week) AS period,
                                                  vegetabletype_desc,
                                                  (vegetabletype_desc||'-'||vegetablemeasure_desc) AS produce, 
                                                  SUM(vegetables_weight1+vegetables_weight2+vegetables_weight3+vegetables_weight4+vegetables_weight5) AS totalWeight,
                                                  SUM(vegetable_price1+vegetable_price2+vegetable_price3+vegetable_price4+vegetable_price5) AS totalPrice
                                           FROM ms2_vegetable_collection
                                           GROUP BY period, produce")

dbWriteTable(mydb, "ms2_vegetable_composition", ms2_vegetable_composition, overwrite = TRUE)


#Generate a table by linking vegetable food with classification to collect major groupings
ms2_vegetable_composition_mjr <- dbGetQuery(mydb, "SELECT ms2_vegetable_composition.period, 
                                                       ms2_vegetable_composition.vegetabletype_desc, 
                                                       SUM(ms2_vegetable_composition.totalWeight) AS tWeight,
                                                       SUM(ms2_vegetable_composition.totalprice) AS tPrice
                                                       
                                                FROM ms2_vegetable_composition
                                                GROUP BY ms2_vegetable_composition.period, ms2_vegetable_composition.vegetabletype_desc
                                         ")

#Claculate average price per kilo for each vegetable food category
ms2_vegetable_composition_mjr$avgPricePerKilo <- ms2_vegetable_composition_mjr$tPrice / ms2_vegetable_composition_mjr$tWeight

#Produce ms2 vegetable pivot table
ms2_vegetable_pivot <- ms2_vegetable_composition_mjr %>%
  pivot_wider(names_from = period, vegetabletype_desc, values_from = avgPricePerKilo, values_fill = 0) %>%
  ungroup()


write.csv(ms2_vegetable_pivot, "data/open/ms2/ms2_vegetable_collection.csv", row.names = FALSE)


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

ms2_fruits_collection$sdate <- substr(ms2_fruits_collection$survey_date, 1, nchar(ms2_fruits_collection$survey_date)-9)
ms2_fruits_collection$sdate <- as.Date(ms2_fruits_collection$sdate, tryFormats = c("%Y-%m-%d", "%Y/%m/%d"), optional = FALSE)

ms2_fruits_collection$sYear <- format(ms2_fruits_collection$sdate, format= "%Y")
ms2_fruits_collection$sMonth <- format(ms2_fruits_collection$sdate, format= "%B")

dbWriteTable(mydb, "ms2_fruits_collection", ms2_fruits_collection, overwrite = TRUE)

#Extract ms1_vegetable_collection from sqlite database for tabulation by computing the period of collection
ms2_fruits_composition <- dbGetQuery(mydb, "SELECT (sYear||'-'||sMonth||'-'||'wk'||week) AS period,
                                                  fruit_type_desc,
                                                  (fruit_type_desc||'-'||measurement_fruits_desc) AS produce, 
                                                  SUM(fruit_weight1+fruit_weight2+fruit_weight3+fruit_weight4+fruit_weight5) AS totalWeight,
                                                  SUM(fruit_price1+fruit_price2+fruit_price3+fruit_price4+fruit_price5) AS totalPrice
                                           FROM ms2_fruits_collection
                                           GROUP BY period, produce")

dbWriteTable(mydb, "ms2_fruits_composition", ms2_fruits_composition, overwrite = TRUE)


#Generate a table by linking vegetable food with classification to collect major groupings
ms2_fruits_composition_mjr <- dbGetQuery(mydb, "SELECT ms2_fruits_composition.period, 
                                                       fruit_type_desc, 
                                                       SUM(ms2_fruits_composition.totalWeight) AS tWeight,
                                                       SUM(ms2_fruits_composition.totalprice) AS tPrice
                                                       
                                                FROM ms2_fruits_composition
                                                GROUP BY ms2_fruits_composition.period, ms2_fruits_composition.fruit_type_desc
                                         ")

#Claculate average price per kilo for each vegetable food category
ms2_fruits_composition_mjr$avgPricePerKilo <- ms2_fruits_composition_mjr$tPrice / ms2_fruits_composition_mjr$tWeight

#Produce ms2 vegetable pivot table
ms2_fruits_pivot <- ms2_fruits_composition_mjr %>%
  pivot_wider(names_from = period, fruit_type_desc, values_from = avgPricePerKilo, values_fill = 0) %>%
  ungroup()


write.csv(ms2_fruits_pivot, "data/open/ms2/ms2_fruits_collection.csv", row.names = FALSE)



#********************************************** Processing MS1 data *******************************************************************

#Loading MS1 types and measure from CAPI
ms1_master <- read.delim("data/secure/ms1/VNSOMS2019.tab")
ms1_staple_roster <- read.delim("data/secure/ms1/staple_roster.tab")
ms1_staple_sub_roster <- read.delim("data/secure/ms1/stap_Nest_Roster.tab")
ms1_vegetable_roster <- read.delim("data/secure/ms1/vegetable_roster.tab")
ms1_vegetable_sub_roster <- read.delim("data/secure/ms1/veg_sub_roster.tab")
ms1_fruit_roster <- read.delim("data/secure/ms1/fruits_roster.tab")
ms1_fruit_sub_roster <- read.delim("data/secure/ms1/frut_sub_roster.tab")


#Load subtables of types and measure from excel file
ms1_fruittype <- read_excel("data/open/MS1_Classification.xlsx", sheet = "fruit_type")
ms1_fruitmeasure <- read_excel("data/open/MS1_Classification.xlsx", sheet = "fruit_measure")
ms1_stapletype <- read_excel("data/open/MS1_Classification.xlsx", sheet = "staple_type")
ms1_stapletypemeasure <- read_excel("data/open/MS1_Classification.xlsx", sheet = "staple_measure")
ms1_vegetabletype <- read_excel("data/open/MS1_Classification.xlsx", sheet = "veg_type")
ms1_vegetablemeasure <- read_excel("data/open/MS1_Classification.xlsx", sheet = "veg_measure")
ms1_market <- read_excel("data/open/MS1_Classification.xlsx", sheet = "market_location")


# Writing in new classified tables read from excel file - MS1_Classification.xlsx above to the database
dbWriteTable(mydb, "ms1_fruittype", ms1_fruittype, overwrite=TRUE)
dbWriteTable(mydb, "ms1_fruitmeasure", ms1_fruitmeasure, overwrite=TRUE)
dbWriteTable(mydb, "ms1_stapletype", ms1_stapletype, overwrite=TRUE)
dbWriteTable(mydb, "ms1_stapletypemeasure", ms1_stapletypemeasure, overwrite=TRUE)
dbWriteTable(mydb, "ms1_vegetabletype", ms1_vegetabletype, overwrite=TRUE)
dbWriteTable(mydb, "ms1_vegetablemeasure", ms1_vegetablemeasure, overwrite=TRUE)
dbWriteTable(mydb, "ms1_market_location", ms1_market, overwrite=TRUE)


colnames(ms1_master)[1] <- "id"
ms1_master$sdate <- substr(ms1_master$survey_date, 1, nchar(ms1_master$survey_date)-9)
ms1_master$sdate <- as.Date(ms1_master$sdate, tryFormats = c("%Y-%m-%d", "%Y/%m/%d"), optional = FALSE)

ms1_master$sYear <- format(ms1_master$sdate, format= "%Y")
ms1_master$sMonth <- format(ms1_master$sdate, format= "%B")


dbWriteTable(mydb, "ms1_master", ms1_master, overwrite=TRUE)

colnames(ms1_fruit_sub_roster)[1] <- "id"
dbWriteTable(mydb, "ms1_fruit_sub_roster", ms1_fruit_sub_roster, overwrite=TRUE)

colnames(ms1_staple_sub_roster)[1] <- "id"
dbWriteTable(mydb, "ms1_staple_sub_roster", ms1_staple_sub_roster, overwrite=TRUE)

colnames(ms1_vegetable_sub_roster)[1] <- "id"
dbWriteTable(mydb, "ms1_vegetable_sub_roster", ms1_vegetable_sub_roster, overwrite = TRUE)

ms1_fruit_collection <- dbGetQuery(mydb, "SELECT ms1_fruit_sub_roster.id, 
                                                 ms1_fruit_sub_roster.interview__id,
                                                 ms1_master.week,
                                                 ms1_master.day,
                                                 ms1_master.month,
                                                 ms1_master.year,
                                                 ms1_master.market_location,
                                                 ms1_market_location.description AS market_location_description,
                                                 ms1_master.survey_date,
                                                 ms1_master.farmer_number,
                                                 ms1_master.supply_location,
                                                 ms1_fruit_sub_roster.fruits_roster__id,
                                                 ms1_fruittype.description AS des_type,
                                                 ms1_fruit_sub_roster.frut_sub_roster__id,
                                                 ms1_fruitmeasure.description AS measure_type,
                                                 ms1_fruit_sub_roster.fruit_quantity
                                   
                                          FROM ms1_fruit_sub_roster
                                          INNER JOIN ms1_fruittype ON ms1_fruit_sub_roster.fruits_roster__id = ms1_fruittype.id
                                          INNER JOIN ms1_fruitmeasure ON ms1_fruit_sub_roster.frut_sub_roster__id = ms1_fruitmeasure.id
                                          INNER JOIN ms1_master ON ms1_fruit_sub_roster.id = ms1_master.id
                                          INNER JOIN ms1_market_location ON ms1_fruit_sub_roster.id = ms1_master.id AND ms1_master.market_location = ms1_market_location.id
                                   ")


ms1_fruit_collection$sdate <- substr(ms1_fruit_collection$survey_date, 1, nchar(ms1_fruit_collection$survey_date)-9)
ms1_fruit_collection$sdate <- as.Date(ms1_fruit_collection$sdate, tryFormats = c("%Y-%m-%d", "%Y/%m/%d"), optional = FALSE)

ms1_fruit_collection$sYear <- format(ms1_fruit_collection$sdate, format= "%Y")
ms1_fruit_collection$sMonth <- format(ms1_fruit_collection$sdate, format= "%B")


dbWriteTable(mydb, "ms1_fruit_collection", ms1_fruit_collection, overwrite = TRUE)

#Extract ms1_staple_collection from sqlite database for tabulation
ms1_fruit_composition <- dbGetQuery(mydb, "SELECT (sYear||'-'||sMonth||'-'||'wk'||week) AS period,
                                                  (des_type||'-'||measure_type) AS produce, 
                                                  SUM(fruit_quantity) AS mycount 
                                           FROM ms1_fruit_collection 
                                           GROUP BY period, produce")


ms1_fruit_composition_wgt <- merge(ms1_fruit_composition, class_wgt_app, by="produce")

#Calculate tbe total weight by multiplying the nuber of units with the base weight
ms1_fruit_composition_wgt$totalWeight <- ms1_fruit_composition_wgt$mycount*ms1_fruit_composition_wgt$Weight

#Creating grouping and summarise the total
ms1_fruit_composition_wgt_pv <- ms1_fruit_composition_wgt %>%
  group_by(period, Major) %>%
  summarise(total = sum(totalWeight))


#ms1_staple_collection cross tabulation
ms1_fruit_pivot <- ms1_fruit_composition_wgt_pv %>%
  pivot_wider(names_from = period, Major, values_from = total, values_fill = 0) %>%
  ungroup()


write.csv(ms1_fruit_pivot, "data/open/ms1/ms1_fruit_pivot.csv", row.names = FALSE)


ms1_staple_collection <- dbGetQuery(mydb, "SELECT ms1_staple_sub_roster.id,  
                                                 ms1_staple_sub_roster.interview__id,
                                                 ms1_master.week,
                                                 ms1_master.day,
                                                 ms1_master.month,
                                                 ms1_master.year,
                                                 ms1_master.market_location,
                                                 ms1_market_location.description AS market_location_description,
                                                 ms1_master.survey_date,
                                                 ms1_master.farmer_number,
                                                 ms1_master.supply_location,
                                                 ms1_staple_sub_roster.staple_roster__id,
                                                 ms1_stapletype.description AS des_type,
                                                 ms1_staple_sub_roster.stap_Nest_Roster__id,
                                                 ms1_stapletypemeasure.descripion AS measure_type,
                                                 ms1_staple_sub_roster.staple_quantity
                                   
                                          FROM ms1_staple_sub_roster
                                          INNER JOIN ms1_stapletype ON ms1_staple_sub_roster.staple_roster__id = ms1_stapletype.id
                                          INNER JOIN ms1_stapletypemeasure ON ms1_staple_sub_roster.stap_Nest_Roster__id = ms1_stapletypemeasure.id
                                          INNER JOIN ms1_master ON ms1_staple_sub_roster.id = ms1_master.id
                                          INNER JOIN ms1_market_location ON ms1_staple_sub_roster.id = ms1_master.id AND ms1_master.market_location = ms1_market_location.id
                                   ")


ms1_staple_collection$sdate <- substr(ms1_staple_collection$survey_date, 1, nchar(ms1_staple_collection$survey_date)-9)
ms1_staple_collection$sdate <- as.Date(ms1_staple_collection$sdate, tryFormats = c("%Y-%m-%d", "%Y/%m/%d"), optional = FALSE)

ms1_staple_collection$sYear <- format(ms1_staple_collection$sdate, format= "%Y")
ms1_staple_collection$sMonth <- format(ms1_staple_collection$sdate, format= "%B")


dbWriteTable(mydb, "ms1_staple_collection", ms1_staple_collection, overwrite = TRUE)

#Extract ms1_staple_collection from sqlite database for tabulation
ms1_staple_composition <- dbGetQuery(mydb, "SELECT (sYear||'-'||sMonth||'-'||'wk'||week) AS period, 
                                                  (des_type||'-'||measure_type) AS produce, 
                                                  SUM(staple_quantity) AS mycount 
                                           FROM ms1_staple_collection 
                                           GROUP BY period, produce")

ms1_staple_composition_wgt <- merge(ms1_staple_composition, class_wgt_app, by="produce")

#Calculate tbe total weight by multiplying the nuber of units with the base weight
ms1_staple_composition_wgt$totalWeight <- ms1_staple_composition_wgt$mycount*ms1_staple_composition_wgt$Weight

#Regrouping and summaring the total weights
ms1_staple_composition_wgt_pv <- ms1_staple_composition_wgt %>%
  group_by(period, Major) %>%
  summarise(total = sum(totalWeight))


#ms1_staple_collection cross tabulation
ms1_staple_pivot <- ms1_staple_composition_wgt_pv %>%
  pivot_wider(names_from = period, Major, values_from = total, values_fill = 0) %>%
  ungroup()


write.csv(ms1_staple_pivot, "data/open/ms1/ms1_staple_pivot.csv", row.names = FALSE)


ms1_vegetable_collection <- dbGetQuery(mydb, "SELECT ms1_vegetable_sub_roster.id,  
                                                 ms1_vegetable_sub_roster.interview__id,
                                                 ms1_master.week,
                                                 ms1_master.day,
                                                 ms1_master.month,
                                                 ms1_master.year,
                                                 ms1_master.market_location,
                                                 ms1_market_location.description AS market_location_description,
                                                 ms1_master.survey_date,
                                                 ms1_master.farmer_number,
                                                 ms1_master.supply_location,
                                                 ms1_vegetable_sub_roster.vegetable_roster__id,
                                                 ms1_vegetabletype.description AS des_type,
                                                 ms1_vegetable_sub_roster.veg_sub_roster__id,
                                                 ms1_vegetablemeasure.description AS measure_type,
                                                 ms1_vegetable_sub_roster.vegetable_quantity
                                   
                                          FROM ms1_vegetable_sub_roster
                                          INNER JOIN ms1_vegetabletype ON ms1_vegetable_sub_roster.vegetable_roster__id = ms1_vegetabletype.id
                                          INNER JOIN ms1_vegetablemeasure ON ms1_vegetable_sub_roster.veg_sub_roster__id = ms1_vegetablemeasure.id
                                          INNER JOIN ms1_master ON ms1_vegetable_sub_roster.id = ms1_master.id
                                          INNER JOIN ms1_market_location ON ms1_vegetable_sub_roster.id = ms1_master.id AND ms1_master.market_location = ms1_market_location.id
                                   ")
#Date reformatting

ms1_vegetable_collection$sdate <- substr(ms1_vegetable_collection$survey_date, 1, nchar(ms1_vegetable_collection$survey_date)-9)
ms1_vegetable_collection$sdate <- as.Date(ms1_vegetable_collection$sdate, tryFormats = c("%Y-%m-%d", "%Y/%m/%d"), optional = FALSE)

ms1_vegetable_collection$sYear <- format(ms1_vegetable_collection$sdate, format= "%Y")
ms1_vegetable_collection$sMonth <- format(ms1_vegetable_collection$sdate, format= "%B")


#Write final ms1_vegetable_collection to the sqlite database
dbWriteTable(mydb, "ms1_vegetable_collection", ms1_vegetable_collection, overwrite = TRUE)

#Extract ms1_vegetable_collection from sqlite database for tabulation
ms1_vegetable_composition <- dbGetQuery(mydb, "SELECT (sYear||'-'||sMonth||'-'||'wk'||week) AS period, 
                                                  (des_type||'-'||measure_type) AS produce, 
                                                  SUM(vegetable_quantity) AS mycount 
                                           FROM ms1_vegetable_collection 
                                           GROUP BY period, produce")


ms1_vegetable_composition_wgt <- merge(ms1_vegetable_composition, class_wgt_app, by="produce")

#Calculate tbe total weight by multiplying the nuber of units with the base weight
ms1_vegetable_composition_wgt$totalWeight <- ms1_vegetable_composition_wgt$mycount*ms1_vegetable_composition_wgt$Weight


#Regrouping and summaring the total weights
ms1_vegetable_composition_wgt_pv <- ms1_vegetable_composition_wgt %>%
  group_by(period, Major) %>%
  summarise(total = sum(totalWeight))



#ms1_vegetable_collection cross tabulation
ms1_vegetable_pivot <- ms1_vegetable_composition_wgt_pv %>%
  pivot_wider(names_from = period, Major, values_from = total, values_fill = 0) %>%
  ungroup()


write.csv(ms1_vegetable_pivot, "data/open/ms1/ms1_vegetable_pivot.csv", row.names = FALSE)

#Disconnect from the SQLite database
dbDisconnect(mydb)
