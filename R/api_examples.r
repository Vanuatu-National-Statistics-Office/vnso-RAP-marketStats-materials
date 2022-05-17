# There are a couple of R packages providing API access to SurveySolutions servers: `susoapi` and `SurveySolutionsAPI`
# As neither of these packages are on CRAN, they will need to be installed from their respective GitHub repos.

# You can find more info on both of these here:
# https://arthur-shaw.github.io/susoapi/index.html
# https://github.com/michael-cw/SurveySolutionsAPI

### `susoapi` example code

# I will use `susoapi` here in the first instance as an example:
install.packages("devtools")
devtools::install_github("arthur-shaw/susoapi")

library(susoapi) # load survey solutions R package for connecting to API

# You will need to set up values securely holding the address for the server, and the username and password.
# It is very important to NOT include these explicitly in any R scripts as these would then become
# publicly visible once files are pushed to Github.
# We will share some information on how best to do this, but in a nutshell you want to store these
# as "environment variables" on your local machine. They can then be recalled by an R script by using 
# the Sys.getenv() function. In the example below, we load the environment variables `SUSO_SERVER`, 
# `SUSO_USER` and `SUSO_PASSWORD`.
# For instructions for creating environmental variables, see:
# - windows: https://kb.wisc.edu/cae/page.php?id=24500
# - mac: https://medium.com/@himanshuagarwal1395/setting-up-environment-variables-in-macos-sierra-f5978369b255
# - linux: https://askubuntu.com/questions/58814/how-do-i-add-environment-variables

suso_server <- Sys.getenv("SUSO_SERVER")
suso_user <- Sys.getenv("SUSO_USER")
suso_password <- Sys.getenv("SUSO_PWORD")
# You can use `Sys.gentenv()` directly in the set_credentials() call below, but doing this separately
# allows you to double check the server name, user and password have been loaded correctly when running 
# the script:
suso_server
suso_user
suso_password

# Set credentials for survey solutions API
set_credentials(
  server = suso_server,
  user = suso_user,
  password = suso_password
)

# Once you're used `set_credentials()` the following should return them and test the server connection:
show_credentials()
check_credentials()

# From here on, the precise process would depend on the VNSO CAPI SurveySolutions server itself (re. names 
# of the data tables to be accessed and downloaded, but the general process is as follows):
# - "Export" data by selecting what "questionnaire" you want to download - this would be the names of tables 
# you want to download
# - Download the exported data once the export has finished.
# This page: https://arthur-shaw.github.io/susoapi/articles/exporting.html
# on the package docs has some suggestions for this, and
# https://arthur-shaw.github.io/susoapi/reference/start_export.html
# Is the reference for the `start_export()` function (which tells you which options are available for the export)

# Set the name of the table to download.
# We don't know what this should be as it depends on the naming in the VNSO server, so this would need to be 
# changed as appropriate.
table_name <- "NAME OF THE TABLE TO DOWNLOAD" 

# It might be that
get_questionnaires()
# Will return some useful information including the reference name for tables of interest?

# This should start an "export job" much as you would do in the web-based interface for the server.
# Note you have to make sure you specify the "export type" to whatever data type you want - "Tabular" should 
#  generate tab-delimited text. More info on the Reference page for start_export:
# https://arthur-shaw.github.io/susoapi/reference/start_export.html
export_job_id <- start_export(
  qnr_id = table_name,
  export_type = "Tabular",
  interview_status = "All"
)

# Once this is ready, you should be able to do download the exported data:
get_export_file(
    job_id = export_job_id,
    path = "C:/your/file/path/" # Note this is the path on your computer where the data will be saved
)
# Note you want to change the folder above to whereever you want to store the downloaded data.

# The following steps would then depend on the exact format of the downloaded data, but it may be best to 
#  trial/test the above steps first.

### `SurveySolutionsAPI` example code

# Make sure package is installed (from Github)
install.packages("devtools")
devtools::install_github("michael-cw/SurveySolutionsAPI", build_vignettes = T)

# Load package
library(SurveySolutionsAPI)

# Set server name, user and password as above - note this assumes you have environment variables set as per links above
server_name <- Sys.getenv("SUSO_DEMOSERVER")
server_user <- Sys.getenv("SUSO_DEMOUSER")
server_password <- Sys.getenv("SUSO_DEMOPASSWORD")

# Use `suso_set_key()` function to set up the authentication for the server
suso_set_key(suso_server = server_name, suso_user = server_user, suso_password = server_password)
# Check whether set correctly:
suso_keys()

# This checks the authentication. Note that this function allows the specification of a 
# "workspace" which I think may be essential.

suso_PwCheck(workspace = "jan22")

# The above should return a status code of 200 if authenticated correctly.

# The following should allow exporting of data, similar as above for `susoapi` package, but note use of 
# `workspace` argument. 
# Unfortunately I have not yet been able to make this work with the demo server but you will have to 
#  tweak the names of what you want to export from the VNSO server anyway, so may be worth an intial go.

# This questionnaire name appears in the demo server:
table_name <- "VR_LFS 2022"

# Example export call:
suso_export(server = server_name, apiUser = server_user, apiPass = server_password, 
            workspace = "jan22", questID = table_name)



