source("server_ui/pages/DataExplore.R")

ui <- fluidPage(
  
  # Include JS
  shinyjs::useShinyjs(),
  
  # Include the CSS
  tags$head(
    tags$link(rel  = "stylesheet",
              type = "text/css",
              href = "custom.css")
  ),
  
  # Include page routing
  router_ui(
    route("/", data_explore())
  )
)