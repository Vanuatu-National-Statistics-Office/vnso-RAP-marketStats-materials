###### Reading Excel data

### Packages

# install packages
install.packages("readxl")
install.packages("purrr")
install.packages("openxlsx")

# load packages
library(readxl) #read in Excel files - begins line 41
library(purrr)  #reading in excel worksheets
library(openxlsx) #read in excel files - begins line 88
# writing Excel files begins line 106

### Folders and loading data

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


### Examples reading data using readxl package

# readxl cheatsheet - https://github.com/rstudio/cheatsheets/blob/main/data-import.pdf
# readxl guide - https://readxl.tidyverse.org/

### Importing spreadsheets

# list all the sheet names 
excel_sheets(ms1_fruittypeFile)

# two ways to read in excel sheets - individually
ms1_fruittype <- read_excel(ms1_fruittypeFile, 
                            sheet = "fruit_type" #not including this line will upload the first sheet only
                            )


# second way involves reading in all sheets at once 
# the sheet names are set by what is in the excel spreadsheet - check using excel_sheets() as above
ms1_fruit <- ms1_fruittypeFile %>%
  excel_sheets() %>%
  set_names() %>%
  map(read_excel, path = ms1_fruittypeFile)

# if you want to bring up the info on the sheets just imported
View(ms1_fruit)

# to call the fruit_measure sheet
ms1_fruit$fruit_measure

### Importing spreadsheets by column/row

# listing all the sheet names
excel_sheets(finalWorkbookFileName)

# reading in the second sheet ""1_QuantitySupplied-Q" and setting the range to remove the first two rows
# note that I kept the empty rows that separate out the different types - the data layout doesn't lend itself to 
# data manipulation in R
final_stats_table_quantity <- read_excel(finalWorkbookFileName, 
                                         range = "1_QuantitySupplied-Q!A3:X29") #where !A3:X29 refers to the excel cells

# you can also set just columns or rows when importing the excel spreadsheets with
# cell_cols("B:D") or cell_rows (1:4)


View(final_stats_table_quantity)


### Examples reading data using openxlsx package

# openxlsx guide - https://www.rdocumentation.org/packages/openxlsx/versions/4.2.5/topics/read.xlsx

# can use to load workbook and either use as file path or check worksheet names
wb <- loadWorkbook(finalWorkbookFileName)

# building dataframe using openxlsx
df1 <- read.xlsx(finalWorkbookFileName, #filepath to import
                 sheet = 2, # which sheet to import
                 cols = c(1:24), # which columns to import cols = NULL to import all
                 rows = c(3:25), # which rows to import. rows = NULL to import all
                 skipEmptyRows = TRUE # don't bring in empty rows
                 )



###### Writing Excel data

# Using 'openxlsx' library for XLSX writing functionality
install.packages("openxlsx")
library(openxlsx)

# Here are a couple of examples setting out the use of openxlsx.
# The package has a lot of functionality to control exact formatting (colours, fonts, etc.)
# https://cran.r-project.org/web/packages/openxlsx/vignettes/Introduction.html
# https://cran.r-project.org/web/packages/openxlsx/vignettes/Formatting.html

# Just for illustration purposes, we use ms2_staple_collection.csv:
staples <- read.csv("data/open/ms2/ms2_staple_collection.csv")

# To write to an Excel file and use separate sheets, we first set up a
# new Excel workbook object to write to:

wb <- createWorkbook()
# Adding a new sheet to this workbook:
addWorksheet(wb, sheetName = "Staples1")

### Simple writing of a new spreadsheet

# writeDataTable() writes data x to a given sheet. 
# Note setting tableStyle to "none" and withFilter to FALSE ensures fully plain formatting.
# More details on this (and options) are in the help file for the function:
# https://www.rdocumentation.org/packages/openxlsx/versions/4.2.5/topics/writeDataTable
writeDataTable(wb, sheet = "Staples1", 
                   x = staples, 
                   tableStyle = "none",
                   withFilter = FALSE)

# To save the file, we then use saveWorkbook()
saveWorkbook(wb, "outputs/openxlsx_demo1.xlsx", overwrite = TRUE) 


### Adding a second sheet and writing to a specific position:

# Another example, adding a further sheet:
addWorksheet(wb, sheetName = "MoreStaples")

# Write the same table into this sheet but now starting at a given row and column:

# First set some better column names so we don't have to deal with that in Excel:
colnames(staples) <- c("Type", "Week 1", "Week 2") 
# Write data to new sheet:
writeDataTable(wb, sheet = "MoreStaples", 
                   x = staples, 
                   startCol = 2, 
                   startRow = 3,
                   tableStyle = "none",
                   withFilter = FALSE)

# Save the workbook again:
# (best to close Excel and reopen while you're doing this)
saveWorkbook(wb, "outputs/openxlsx_demo1.xlsx", overwrite = TRUE) 

### Editing data in single cells & merging cells:

# Replace the value in col 3, row 2 of sheet MoreStaples with "January":
writeData(wb, sheet = "MoreStaples", 
                   x = "January", 
                   startCol = 3, 
                   startRow = 2)
saveWorkbook(wb, "outputs/openxlsx_demo1.xlsx", overwrite = TRUE) 

# merging cells - so that "January" spans both columns:
mergeCells(wb, sheet = "MoreStaples",
               cols = 3:4, rows = 2)
saveWorkbook(wb, "outputs/openxlsx_demo1.xlsx", overwrite = TRUE) 

# Replacing a range of values.
# Note that when given a vector (1,2,3,4) this writes by column (vertically) from a given starting position.
# Also note we use xy instead of startCol and startRow here:
writeData(wb, sheet = "MoreStaples", 
                   x = c(1,2,3,4), 
                   xy = c(4,4))
saveWorkbook(wb, "outputs/openxlsx_demo1.xlsx", overwrite = TRUE) 


