source("server_ui/pages/DataExplore.R")
source("server_ui/pages/Home.R")
source("server_ui/pages/About.R")

ui <- fluidPage(
  
  # Include JS
  shinyjs::useShinyjs(),
  
  # Include the CSS
  tags$head(
    tags$link(rel  = "stylesheet",
              type = "text/css",
              href = "custom.css")
  ),

  navbarPage(
    "Wildcat Squad",
    tabPanel(
      "Home",
      home()
    ),
    tabPanel(
      "Explore the data",
      data_explore()
    ),
    tabPanel(
      "About",
      about()
    )
  )
)