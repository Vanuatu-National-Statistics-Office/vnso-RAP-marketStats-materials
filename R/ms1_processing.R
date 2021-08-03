#Processing of the Market Survey MS1 Collection

#Load library
library(dplyr)




#Load MS1 Files Data Processing

ms1_master <- read.delim("data/secure/ms1/VNSOMS2019.tab")
staple_roster <- ms1 <- read.delim("data/secure/ms1/staple_roster.tab")
vegetable_roster <- ms1 <- read.delim("data/secure/ms1/Vegetable_roster.tab")
fruit_roster <- ms1 <- read.delim("data/secure/ms1/fruits_roster.tab")

#Remove unwanted columns

ms1_master_extract <- ms1_master[ , c(1,2,3,4,5,6,17,28)]
ms1_master_extract$id <- ms1_master_extract$ï..interview__key
staple_roster$id <- staple_roster$ï..interview__key
ms1_staple <- merge(ms1_master_extract, staple_roster, by = "id")






#Merge Master with Roster



#Processing of Market Survey MS2 Collection

#Load MS1 Files Data Processing

ms2_master <- read.delim("data/secure/ms2/VNSOMCS.tab")
ms2_staple_roster <- read.delim("data/secure/ms2/root_crop_roster.tab")
ms2_vegetable_roster <- read.delim("data/secure/ms2/vegis_roster.tab")
ms2_fruit_roster <- read.delim("data/secure/ms2/fruits_roster.tab")


#Remove unwanted columns

ms2_master_extract <- ms2_master[ , c(1,2,3,4,5,6,17,28)]
ms2_master_extract$id <- ms2_master_extract$ï..interview__key
ms2_staple_roster$id <- ms2_staple_roster$ï..interview__key
ms2_staple <- merge(ms2_master_extract, ms2_staple_roster, by = "id")










