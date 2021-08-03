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

#Load MS2 Files Data Processing

ms2_master <- read.delim("data/secure/ms2/VNSOMCS.tab")
ms2_staple_roster <- read.delim("data/secure/ms2/root_crop_roster.tab")
ms2_vegetable_roster <- read.delim("data/secure/ms2/vegis_roster.tab")
ms2_fruit_roster <- read.delim("data/secure/ms2/fruits_roster.tab")


#Remove unwanted columns

ms2_master_extract <- ms2_master[ , c(1,2,3,9,10,11,12)]
ms2_master_extract$id <- ms2_master_extract$ï..interview__key
ms2_staple_roster$id <- ms2_staple_roster$ï..interview__key
ms2_staple <- merge(ms2_master_extract, ms2_staple_roster, by = "id")


# Calculating the Average for stable
ms2_staple$averageprice <- (ms2_staple$staple_price1 + ms2_staple$staple_price2 + ms2_staple$staple_price3 + ms2_staple$staple_price4 + ms2_staple$staple_price5)/5
ms2_staple$averagewieght <- (ms2_staple$staple_wieght1 + ms2_staple$staple_wieght2 + ms2_staple$staple_wieght3 + ms2_staple$staple_wieght4 + ms2_staple$staple_wieght5)/5

#Remove unwanted columns for Fruits
ms2_master_extract <- ms2_master[ , c(1,2,3,9,10,11,12)]
ms2_master_extract$id <- ms2_master_extract$ï..interview__key
ms2_fruit_roster$id <- ms2_fruit_roster$ï..interview__key
ms2_fruit <- merge(ms2_master_extract, ms2_fruit_roster, by = "id")

# Calculating the Average for fruit
ms2_fruit$averageprice <- (ms2_fruit$fruit_price1 + ms2_fruit$fruit_price2 + ms2_fruit$fruit_price3 + ms2_fruit$fruit_price4 + ms2_fruit$fruit_price5)/5
ms2_fruit$averagewieght <- (ms2_fruit$fruit_weight1 + ms2_fruit$fruit_weight2 + ms2_fruit$fruit_weight3 + ms2_fruit$fruit_weight4 + ms2_fruit$fruit_weight5)/5

#Removing unwanted columns for Vegetables
ms2_master_extract <- ms2_master[ , c(1,2,3,9,10,11,12)]
ms2_master_extract$id <- ms2_master_extract$ï..interview__key
ms2_vegetable_roster$id <- ms2_vegetable_roster$ï..interview__key
ms2_vegetable <- merge(ms2_master_extract, ms2_vegetable_roster, by = "id")

# Calculating the Average for Vegetables
ms2_vegetable$averageprice <- (ms2_vegetable$vegetable_price1 + ms2_vegetable$vegetable_price2 + ms2_vegetable$vegetable_price3 + ms2_vegetable$vegetable_price4 + ms2_vegetable$vegetable_price5)/5
ms2_vegetable$averagewieght <- (ms2_vegetable$vegetables_weight1 + ms2_vegetable$vegetables_weight2 + ms2_vegetable$vegetables_weight3 + ms2_vegetable$vegetables_weight4 + ms2_vegetable$vegetables_weight5)/5









