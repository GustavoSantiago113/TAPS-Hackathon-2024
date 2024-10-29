show_map <- function(plotBorders){
  
  selection <- dplyr::filter(plotBorders, Plot_ID == 2701)
  
  leaflet(options = leafletOptions(zoomControl = FALSE,
                                   minZoom = 17.3, maxZoom = 17.3,
                                   dragging = FALSE)) %>%
    setView(lng = -101.0653, lat = 39.3860, zoom = 17.3) %>%
    addTiles() %>%
    addPolygons( data = plotBorders,
                 layerId = plotBorders$Plot_ID,
                 weight = 1,
                 smoothFactor = 0.2,
                 fillOpacity = 1,
                 color = "black",
                 fillColor = "white",
                 highlight = highlightOptions(
                   weight = 5,
                   color = "#512888",
                   fillOpacity = 1,
                   bringToFront = TRUE
                 ),
                 label = paste("Plot Id: ", plotBorders$Plot_ID, sep = "")
    ) %>%
    addPolygons(data = selection,
                layerId = selection$Plot_ID,
                weight = 1,
                smoothFactor = 1,
                fillOpacity = 1,
                fillColor = "#512888",
                color = "#512888",
                highlight = highlightOptions(
                  weight = 5,
                  color = "white",
                  fillOpacity = 0.5,
                  bringToFront = TRUE
                )
    ) %>%
    addProviderTiles("Esri.WorldImagery")
}

click_map <- function(input, selected_plot, plotBorders){
  click <- input$map_shape_click$id
  
  if (!is.null(selected_plot)) {
    leafletProxy("map") %>%
      removeShape(layerId = selected_plot) %>%
      addPolygons( data = plotBorders,
                   layerId = plotBorders$Plot_ID,
                   weight = 1,
                   smoothFactor = 0.2,
                   fillOpacity = 1,
                   color = "black",
                   fillColor = "white",
                   highlight = highlightOptions(
                     weight = 5,
                     color = "#512888",
                     fillOpacity = 0.25,
                     bringToFront = TRUE
                   ),
                   label = paste("Plot Id: ", plotBorders$Plot_ID, sep = "")
      )%>%
      addProviderTiles("Esri.WorldImagery")
  }
  
  selected_plot(click)
  
  selection <- dplyr::filter(plotBorders, Plot_ID == click)
  
  leafletProxy("map") %>%
    addPolygons(data = selection,
                layerId = selection$Plot_ID,
                weight = 1,
                smoothFactor = 1,
                fillOpacity = 1,
                fillColor = "#512888",
                color = "#512888",
                highlight = highlightOptions(
                  weight = 5,
                  color = "white",
                  fillOpacity = 0.5,
                  bringToFront = TRUE
                )
    )%>%
    addProviderTiles("Esri.WorldImagery")
}