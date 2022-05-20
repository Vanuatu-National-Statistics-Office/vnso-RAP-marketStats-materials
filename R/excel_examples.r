

# install packages
install.packages("readxl")
install.packages("purrr")


# load packages
library(readxl) #read in Excel files
library(purrr)  #reading in excel worksheets


#Mapping of the directory path

# Note where VNSO code/data is on current computer
repository <- getwd()
setwd(repository) # Required for file.choose() function

## setting folder paths

# Note the secure data path
secureDataFolder <- file.path(repository, "data", "secure")
# Note the open data path
openDataFolder <- file.path(repository, "data", "open")
# Note the output folder path
outputFolder <- file.path(repository, "outputs")
# Note the secure data path
ms1DataFolder <- file.path(repository, "data", "secure", "ms1")

# open fruit classification excel sheet
ms1_fruittypeFile <- file.path(openDataFolder, "MS1_Classification.xlsx")

# secure final output sheet - that is slightly more complex structure
finalWorkbookFileName <- file.path(outputFolder, "SEC_FINAL_MAN_FinalMarketSurveyStatisticsTables_31-12-21_WORKING.xlsx")


## readxl package

# readxl cheatsheet - https://github.com/rstudio/cheatsheets/blob/main/data-import.pdf
# readxl guide - https://readxl.tidyverse.org/

# list all the sheet names 
excel_sheets(ms1_fruittypeFile)


# two ways to read in excel sheets - not including `sheet = ` will import the first sheet only
# individually

ms1_fruittype <- read_excel(ms1_fruittypeFile, sheet = "fruit_type")


# second way involves reading in all sheets at once 
# the sheet names are set by what is in the excel spreadsheet - check using excel_sheets()
ms1_fruit <- ms1_fruittypeFile %>%
  excel_sheets() %>%
  set_names() %>%
  map(read_excel, path = ms1_fruittypeFile)

# will bring up only the fruit_measure sheet
ms1_fruit$fruit_measure

# working with a workbook that doesn't start with column names on the first row

# listing all the sheet names
excel_sheets(finalWorkbookFileName)

# reading in the second sheet ""1_QuantitySupplied-Q" and setting the range to remove the first two rows
# note that I kept the empty rows that separate out the different types - the data layout doesn't lend itself to 
# data manipulation in R
final_stats_table_quantity <- read_excel(finalWorkbookFileName, range = "1_QuantitySupplied-Q!A3:X29")