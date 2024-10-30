show_map <- function(plotBorders, fill_colors, data, input){
  
  colored_borders <- get_quartile_colors(data, input$dateInput, plotBorders)
  
  leaflet(options = leafletOptions(
    zoomControl = FALSE,
    minZoom = 17.3,
    maxZoom = 17.3,
    dragging = FALSE
  )) %>%
    setView(lng = -101.0647,
            lat = 39.3861,
            zoom = 17.3) %>%
    addTiles() %>%
    addPolygons(
      data = colored_borders,
      layerId = ~Plot_ID,
      weight = 1,
      smoothFactor = 0.2,
      fillOpacity = 1,
      color = "black",
      fillColor =  ~color,  # Use the dynamic colors
      highlight = highlightOptions(
        weight = 5,
        color = "#512888",
        fillOpacity = 1,
        bringToFront = TRUE
      ),
      label = paste("Plot Id: ", plotBorders$Plot_ID, 
                    "\nNDVI: ", round(data$NDVI_Pred[
                      match(plotBorders$Plot_ID, data$Plot_ID) &
                        data$Date == input$dateInput
                    ], 3),
                    sep = "")
    ) %>%
    addProviderTiles("Esri.WorldImagery") %>%
    addLegend(
      position = "bottomright",
      title = "NDVI Quartiles",
      colors = c("darkgreen", "#78C679", "yellow", "red","#CCCCCC"),
      labels = c("Q4 (Highest)", "Q3", "Q2", "Q1 (Lowest)", "No Data"),
    )
}

click_map <- function(input, selected_plot){
  
  click <- input$map_shape_click$id
  
  selected_plot(click)
}

get_quartile_colors <- function(data, doy, plot_borders) {
  
  day_data <- data[data$Date == doy, ]
  
  color_palette <- c("red", "yellow", "#78C679", "darkgreen")
  
  quarts <- quantile(day_data$NDVI_Pred, 
                     probs = c(0, 0.25, 0.5, 0.75, 1), 
                     na.rm = TRUE)
  
  color_df <- data.frame(
    Plot_Id = day_data$Plot_ID,
    color = sapply(day_data$NDVI_Pred, function(x) {
      if (is.na(x)) return("#CCCCCC")
      else if (x <= quarts[2]) return(color_palette[1])
      else if (x <= quarts[3]) return(color_palette[2])
      else if (x <= quarts[4]) return(color_palette[3])
      else return(color_palette[4])
    })
  )
  
  plot_borders <- plot_borders %>%
    left_join(color_df, by = c("Plot_ID" = "Plot_Id")) %>%
    mutate(color = ifelse(is.na(color), "#CCCCCC", color)) 

  return(plot_borders)
}