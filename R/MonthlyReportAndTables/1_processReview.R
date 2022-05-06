#### Preparation ####

# Clear the environment
rm(list = ls())

# Load the required libraries
library(DBI) #database driver package
library(readr) #reading in files
library(readxl) #read in Excel files
library(purrr)  #reading in excel worksheets
library(dplyr) #data manipulation

#Mapping of the directory path

# Note where VNSO code/data is on current computer
repository <- getwd()
setwd(repository) # Required for file.choose() function

# Note the secure data path
secureDataFolder <- file.path(repository, "data", "secure")
# Note the open data path
openDataFolder <- file.path(repository, "data", "open")
# Note the output folder path
outputFolder <- file.path(repository, "outputs")

# Note the secure data path
ms1DataFolder <- file.path(repository, "data", "secure", "ms1")

#Import and prepare base weight table to be applied to MS1 collection
class_wgtFile <- file.path(openDataFolder, "OPN_FINAL_VNSO_WeightingClassifications_10-04-22.csv")
class_wgt <- read_csv(class_wgtFile, na = c("","NA","NULL","null"))


#Loading MS1 types and measure from CAPI
ms1_masterFile <- file.path(ms1DataFolder, "VNSOMS2019.tab")
ms1_master <- read.delim(ms1_masterFile)

ms1_staple_rosterFile <- file.path(ms1DataFolder, "staple_roster.tab")
ms1_staple_roster <- read.delim(ms1_staple_rosterFile)

#ms1_staple_sub_rosterFile <- file.path(ms1DataFolder, "stap_Nest_Roster.tab") # <- file doesn't exist
#ms1_staple_sub_roster <- read.delim(ms1_staple_sub_rosterFile)

ms1_vegetable_rosterFile <- file.path(ms1DataFolder, "vegetable_roster.tab")
ms1_vegetable_roster <- read.delim(ms1_vegetable_rosterFile)

#ms1_vegetable_sub_rosterFile <- file.path(ms1DataFolder, "veg_sub_roster.tab") # <- file doesn't exist
#ms1_vegetable_sub_roster <- read.delim(ms1_vegetable_sub_rosterFile)


ms1_fruit_rosterFile <- file.path(ms1DataFolder, "fruits_roster.tab")
ms1_fruit_roster <- read.delim(ms1_fruit_rosterFile)

# ms1_fruit_sub_rosterFile <- file.path(ms1DataFolder, "frut_sub_roster.tab") # <- file doesn't exist
# ms1_fruit_sub_roster <- read.delim(ms1_fruit_sub_rosterFile)



#Load subtables of types and measure from excel file

ms1_fruittypeFile <- file.path(openDataFolder, "MS1_Classification.xlsx")

ms1_fruittype <- read_excel(ms1_fruittypeFile, sheet = "fruit_type")
ms1_fruitmeasure <- read_excel(ms1_fruittypeFile, sheet = "fruit_measure")
ms1_stapletype <- read_excel(ms1_fruittypeFile, sheet = "staple_type")
ms1_stapletypemeasure <- read_excel(ms1_fruittypeFile, sheet = "staple_measure")
ms1_vegetabletype <- read_excel(ms1_fruittypeFile, sheet = "veg_type")
ms1_vegetablemeasure <- read_excel(ms1_fruittypeFile, sheet = "veg_measure")
ms1_market <- read_excel(ms1_fruittypeFile, sheet = "market_location")

## Condensed code to read in excel worksheets 
 ## TODO check if others agree below approach

# ms1_fruittypeFile <- file.path(openDataFolder, "MS1_Classification.xlsx")
# 
# df1 <- ms1_fruittypeFile %>% 
#   excel_sheets() %>% 
#   set_names() %>% 
#   map(read_excel, path = ms1_fruittypeFile)
# 

## Tidying up some data

# changing first column name
colnames(ms1_master)[1] <- "id"

ms1_master$sdate <- substr(ms1_master$survey_date, 1, nchar(ms1_master$survey_date)-9)
ms1_master$sdate <- as.Date(ms1_master$sdate, tryFormats = c("%Y-%m-%d", "%Y/%m/%d"), optional = FALSE)

ms1_master$sYear <- format(ms1_master$sdate, format= "%Y")
ms1_master$sMonth <- format(ms1_master$sdate, format= "%B")



# the below won't work for ONS people as we don't have the _roster sheets
colnames(ms1_fruit_sub_roster)[1] <- "id"

colnames(ms1_staple_sub_roster)[1] <- "id"

colnames(ms1_vegetable_sub_roster)[1] <- "id"


# renaming fruit type column for merging
df_ms1_fruittype <- 
  ms1_fruittype %>%
  rename('des_type' = description,
         'fruits_roster__id' = id)

# selecting the columns of interest from fruit_sub_roster <- can't run to check
df_ms1_fruit_sub_roster <-
  ms1_fruit_sub_roster %>%
  select(id, interview_id, fruits_roster__id, 
         fruit_sub_roster__id, fruit_quantity) %>%
  left_join(df_ms1_fruittype, by= 'fruits_roster__id') %>%
  left_join(ms1_fruitmeasure, by= c('fruit_sub_roster__id' = 'id'))

# renaming columns to merge data with ms1_master
df_ms1_market <-
  ms1_market %>% 
  rename('market_location' = id,
         'market_location_description' = description)

# selecting the columns of interest from ms1_master
df_ms1_master <-
  ms1_master %>%
  select(week, day, month, year, market_location, 
         survey_date, farmer_number, supply_location) %>%
  left_join(df_ms1_market, by= 'market_location') # merging with ms1_market to add market_location_description


# final dataframe
df_ms1_fruit_collection <- 
  df_ms1_master %>%
  left_join(df_ms1_fruit_sub_roster, by= 'id')



df_ms1_fruit_composition <- 
df_ms1_fruit_collection %>%
  mutate(period = paste0(sYear, "-", sMonth, "-", "wk", week),
         produce = paste0(des_type, "-", measure_type)) %>%
  group_by(period, produce) %>%
  summarise(mycount = sum(fruit_quantity, na.rm = TRUE))

# converting Produce and Units into produce to merge with fruit composition
class_wgt_app <- 
  class_wgt %>%
  mutate(produce = paste0(Produce, "-", Unit)) %>%
  select(-Produce, -Unit)

# merging fruit composition and weights
ms1_fruit_composition_wgt <- 
  merge(ms1_fruit_composition, 
        class_wgt_app, 
        by="produce") 


# calculating the total weight, grouping and summarise the total
ms1_fruit_composition_wgt_pv <- 
  ms1_fruit_composition_wgt %>%
  mutate(totalWeight = mycount * Weight) %>%
  group_by(period, Major) %>%
  summarise(total = sum(totalWeight))


#ms1_staple_collection cross tabulation
ms1_fruit_pivot <- ms1_fruit_composition_wgt_pv %>%
  pivot_wider(names_from = period, Major, values_from = total, values_fill = 0) %>%
  ungroup()


##### original RSQLite code
ms1_fruit_collection <- dbGetQuery(mydb, "SELECT ms1_fruit_sub_roster.id, 
                                                 ms1_fruit_sub_roster.interview__id,
                                                 ms1_fruit_sub_roster.fruits_roster__id,
                                                 ms1_fruit_sub_roster.frut_sub_roster__id,
                                                 ms1_fruit_sub_roster.fruit_quantity
                                                 
                                                 ms1_master.week,
                                                 ms1_master.day,
                                                 ms1_master.month,
                                                 ms1_master.year,
                                                 ms1_master.market_location,
                                            
                                                 ms1_market_location.description AS market_location_description,
                                                 ms1_master.survey_date,
                                                 ms1_master.farmer_number,
                                                 ms1_master.supply_location,
                                                 
 
                                                 ms1_fruittype.description AS des_type,
                                                 ms1_fruitmeasure.description AS measure_type
          
                                   
                                          FROM ms1_fruit_sub_roster
                                          INNER JOIN ms1_fruittype ON ms1_fruit_sub_roster.fruits_roster__id = ms1_fruittype.id
                                          INNER JOIN ms1_fruitmeasure ON ms1_fruit_sub_roster.frut_sub_roster__id = ms1_fruitmeasure.id
                                          INNER JOIN ms1_master ON ms1_fruit_sub_roster.id = ms1_master.id
                                          
                                          INNER JOIN ms1_market_location ON ms1_fruit_sub_roster.id = ms1_master.id AND ms1_master.market_location = ms1_market_location.id
                                   ")



## NICCI- I didn't include this as I don't think it's necessary as already set date format?
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

