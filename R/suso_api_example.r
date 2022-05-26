# There are a couple of R packages providing API access to SurveySolutions servers: `susoapi` and `SurveySolutionsAPI`
# As neither of these packages are on CRAN, they will need to be installed from their respective GitHub repos.

# You can find more info on susoapi here:
# https://arthur-shaw.github.io/susoapi/index.html

# Creating environmental variables is required for storing your Survey Solutions credentials (line 31 onwards)
# See useful guidance on how to create these variables
# - https://stackoverflow.com/questions/49738564/r-set-environment-variable-permanently
# - https://stat.ethz.ch/R-manual/R-devel/library/base/html/Sys.setenv.html
# NOTE it isn't advisable to store any SurveySolutions API credentials in this or any R scripts
# in case you accidentally share through or git or other means.


### `susoapi` example code

# Make sure package is installed (from Github)

# install.packages("devtools")
install.packages("devtools")
devtools::install_github("arthur-shaw/susoapi")

# load package
library(susoapi)

# Set server name, user and password - note this assumes you have environment variables set as per links above
server_name <- Sys.getenv("SUSO_SERVER")
server_user <- Sys.getenv("SUSO_USER")
server_password <- Sys.getenv("SUSO_PWORD")


# before executing an action, users need to provide credentials for server authentication
set_credentials(server = server_name, 
                user = server_user, 
                password = server_password)


# shows the credentials that have been set
show_credentials()

# checks that the credentials work for set server/workspace:
check_credentials(
   #workspace = 'jan22' #- optional. default is primary. this is the demo server workspace
  )


# creates a dataframe of questionnaires and their attributes
get_questionnaires()


# to export data
# STEP1: START AN EXPORT JOB
# specifying same same options as in user interface
# optionally specifying other options--including some not available in the UI
start_export(
  qnr_id = NULL,
  export_type = NULL,
  interview_status = NULL,
  include_meta = TRUE
) -> started_job_id

# STEP 2: CHECK EXPORT JOB PROGESS, UNTIL COMPLETE
# specifying ID of job started in prior step
get_export_job_details(job_id = started_job_id)

# STEP 3: DOWNLOAD THE EXPORT FILE, ONCE THE JOB IS COMPLETE
# specifying:
# - job ID
# - where to download the file
get_export_file(
  job_id = started_job_id,
  path = "C:/your/file/path/"
)
