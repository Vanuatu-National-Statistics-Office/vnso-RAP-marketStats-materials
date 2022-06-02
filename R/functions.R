prettyTable <- function(table, full_width=FALSE, position="left", bootstrap_options="striped", ...){
  
  # Use the kable function to create a nicer formatted table
  knitr::kable(table) %>%
    
    # Set the format
    kableExtra::kable_styling(bootstrap_options=bootstrap_options, # Set the colour of rows
                              full_width=full_width, # Make the table not stretch to fit the page
                              position=position, 
                              ...) %>% # Position the table on the left
    
    # Make the table scrollable
    scroll_box(height = "400px")
}

