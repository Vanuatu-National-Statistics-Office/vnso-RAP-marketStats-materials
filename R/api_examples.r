# There are a couple of R packages providing API access to SurveySolutions servers: `susoapi` and `SurveySolutionsAPI`
# As neither of these packages are on CRAN, they will need to be installed from their respective GitHub repos.

# You can find more info on both of these here:
# https://arthur-shaw.github.io/susoapi/index.html
# https://github.com/michael-cw/SurveySolutionsAPI

# Useful resources:
# - https://docs.mysurvey.solutions/headquarters/api/api-r-package/
# - swagger api: https://demo.mysurvey.solutions/jan22/apidocs/index.html#/

# Demo server and credentials???

### `SurveySolutionsAPI` example code

# Make sure package is installed (from Github)
install.packages("devtools")
devtools::install_github("michael-cw/SurveySolutionsAPI", build_vignettes = T)

# Load package
library(SurveySolutionsAPI)

# Set server name, user and password as above - note this assumes you have environment variables set as per links above
server_name <- Sys.getenv("SUSO_SERVER")
server_user <- Sys.getenv("SUSO_USER")
server_password <- Sys.getenv("SUSO_PWORD")

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

# Look at the users in the workspace
workspace <- "jan22"
suso_getSV(workspace = workspace)

# NOTE functions below aren't working with the with test server

# Example export call:
suso_export(server = server_name, apiUser = server_user, apiPass = server_password, 
            workspace = "jan22", questID = table_name)

suso_getSV(workspace = "jan22")

suso_getQuestDetails(
  server = server_name,
  usr = server_user,
  pass = server_password,
  workspace = "jan22",
  operation = "list"
)

suso_getWorkspace(
  server = server_name,
  apiUser = server_user,
  apiPass = server_password,
  workspace = "jan22"
)

