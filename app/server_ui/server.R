source("server_ui/components/Map.R")
source("server_ui/components/InfoBox.R")
source("server_ui/components/StaticCards.R")

static_data <- read.csv("data/static_df.csv")
dynamic_data <- read.csv("data/dynamic_df.csv")

server <- function(input, output, session){
  
  # Router function
  router_server()
  
  # Input map ----
  selected_plot <- reactiveVal(2701)
  
  Sys.setenv(SHAPE_RESTORE_SHX="YES")
  plotBorders <- st_read("data/plots/2024_Colby_TAPS_Harvest_Area.shp", stringsAsFactors=FALSE, quiet=TRUE)
  
  output$map <- renderLeaflet({show_map(plotBorders, fill_colors, dynamic_data, input)})
  
  # Event that select the plot in the map
  observeEvent(input$map_shape_click, {
    
    click_map(input, selected_plot)

  })
  
  output$infoBox <- renderUI({  info_box_render(static_data, selected_plot) })
    
  output$staticCards <- renderUI({  show_cards(static_data, selected_plot) })
  
}