ndvi_temporal <- function(data, selected_plot, input){
  
  DOY <- input$dateInput
  plot <- selected_plot()
  
  # if (is.numeric(DOY)) {
  #   year_ref <- lubridate::year(min(data$Date))  
  #   DOY <- as.Date(DOY - 1, origin = paste0(year_ref, "-01-01"))
  # }
  
  df_filtered <- data %>% filter(Plot_ID == plot)
  df_doy <- df_filtered %>% filter(Date == DOY)
  plot <- plot_ly(df_filtered, x = ~Date) %>%
    add_lines(y = ~NDVI_Pred, name = "NDVI", line = list(dash = 'dash', color = 'rgba(34, 139, 34, 0.8)', width = 3)) %>%
    add_trace(x = df_doy$Date, y = df_doy$NDVI_Pred, type = 'scatter', 
              mode = 'markers', name = "NDVI in the selected day", 
              marker = list(color = 'rgba(139, 69, 19, 1)', size = 10))  %>%
    layout(
      xaxis = list(title = list(text = "", font = list(size = 16)), tickfont = list(size = 14)),
      yaxis = list(title = list(text = "NDVI", font = list(size = 16)), tickfont = list(size = 14), side = "left"),
      legend = list(font = list(size = 14), orientation = "h", x = 0.5, xanchor = "center", y = -0.1) 
    )
  plot
  
}

soil_moisture_graph <- function(data, selected_plot, input){
  
  DOY <- input$dateInput
  plot <- selected_plot()
  
  # if (is.numeric(DOY)) {
  #   year_ref <- lubridate::year(min(data$Date))
  #   DOY <- as.Date(DOY - 1, origin = paste0(year_ref, "-01-01"))
  # }
  
  df_filtered <- data %>% filter(Plot_ID == plot)
  df_doy <- df_filtered %>% filter(Date == DOY)
  

  if (nrow(df_doy) == 0) {
    stop("No data available for the specified DOY.")
  }
  
  pwp_fc_plot <- plot_ly(df_doy, x = ~1) %>%
    add_bars(y = ~PWP, name = "PWP", marker = list(color = 'rgba(255, 102, 102, 0.7)')) %>%
    add_bars(y = ~FC - PWP, name = "FC", marker = list(color = 'rgba(144, 238, 144, 0.7)'), base = ~PWP) %>%
    layout(
      xaxis = list(title = "", showticklabels = FALSE, zeroline = FALSE),
      yaxis = list(title = list(text = "Soil Moisture", font = list(size = 16)), tickfont = list(size = 14)),
      barmode = "stack",
      legend = list(font = list(size = 14), orientation = "h", x = 0.5, xanchor = "center", y = -0.1)
    )
  

  sm_plot <- plot_ly(df_doy, x = ~1) %>%
    add_bars(y = ~sm, name = "Soil Moisture", marker = list(color = 'rgba(30, 144, 255, 0.7)')) %>%
    

    layout(
      xaxis = list(title = "", showticklabels = FALSE, zeroline = FALSE),
      yaxis = list(title = list(text = "Soil Moisture", font = list(size = 16)), tickfont = list(size = 14)),
      legend = list(font = list(size = 14), orientation = "h", x = 0.5, xanchor = "center", y = -0.1)
    )
  

  combined_plot <- subplot(pwp_fc_plot, sm_plot, nrows = 1, shareY = TRUE, titleX = TRUE)
  
  combined_plot
}

temporal_soil_moisture <- function(data, selected_plot, input) {
  
  DOY <- input$dateInput
  plot <- selected_plot()
  
  # if (is.numeric(DOY)) {
  #   year_ref <- lubridate::year(min(data$Date))  
  #   DOY <- as.Date(DOY - 1, origin = paste0(year_ref, "-01-01"))
  # }
  
  df_filtered <- data %>% filter(Plot_ID == plot)
  df_doy <- df_filtered %>% filter(Date == DOY)
  
  
  plot <- plot_ly(df_filtered, x = ~Date) %>%
    
    
    add_bars(y = ~PRECIP, name = "Rainfall", yaxis = "y2", 
             marker = list(color = 'rgba(30, 144, 255, 0.7)', 
                           type = 'bar', width = 1)) %>%
    add_bars(y = ~Irrigation_mm, name = "Irrigation", yaxis = "y2", 
             marker = list(color = 'rgba(0, 0, 139, 0.7)', 
                           type = 'bar', width = 1)) %>%
    
    
    add_trace(y = ~sm, type = 'scatter', mode = 'lines', name = "Soil Moisture (Calc'd)", yaxis = "y", 
              line = list(color = 'rgba(139, 69, 19, 0.8)')) %>%
    
    
    layout(shapes = list(
      list(type = "rect", fillcolor = "rgba(255, 0, 0, 0.1)", line = list(color = "rgba(173, 216, 230, 0)"),
           x0 = min(df_filtered$Date), 
           x1 = max(df_filtered$Date), 
           y0 = 0, y1 = max(df_filtered$PWP, na.rm = TRUE), yref = "y"),
      list(type = "rect", fillcolor = "rgba(0, 255, 0, 0.1)", line = list(color = "rgba(144, 238, 144, 0)"),
           x0 = min(df_filtered$Date), 
           x1 = max(df_filtered$Date), 
           y0 = min(df_filtered$PWP, na.rm = TRUE), 
           y1 = max(df_filtered$FC, na.rm = TRUE), 
           yref = "y"),
      list(type = "rect", fillcolor = "rgba(255, 255, 0, 0.1)", 
           line = list(color = "rgba(255, 255, 0, 0)"),
           x0 = min(df_filtered$Date), 
           x1 = max(df_filtered$Date), 
           y0 = min(df_filtered$FC, na.rm = TRUE), 
           y1 = max(df_filtered$sm, na.rm = TRUE), yref = "y")
    )) %>%
    
    
    add_lines(y = ~FC, name = "Field Capacity", 
              line = list(dash = 'dash', color = 'rgba(34, 139, 34, 0.8)', width = 3)) %>%
    add_lines(y = ~PWP, name = "Wilting Point", 
              line = list(dash = 'dash', color = 'rgba(255, 69, 0, 0.8)', width = 3)) %>%
    
    
    add_trace(x = df_doy$Date, y = df_doy$sm, type = 'scatter', 
              mode = 'markers', name = "Soil Moisture (DOY)", 
              marker = list(color = 'rgba(139, 69, 19, 1)', size = 10)) %>%
    add_trace(x = df_doy$Date, y = df_doy$PRECIP, type = 'scatter', 
              mode = 'markers', name = "Rainfall (DOY)", yaxis = "y2", 
              marker = list(color = 'rgba(30, 144, 255, 1)', size = 10)) %>%
    add_trace(x = df_doy$Date, y = df_doy$Irrigation_mm, type = 'scatter', 
              mode = 'markers', name = "Irrigation (DOY)", yaxis = "y2", 
              marker = list(color = 'rgba(0, 0, 139, 1)', size = 10)) %>%
    add_trace(x = df_doy$Date, y = df_doy$FC, type = 'scatter', 
              mode = 'markers', name = "Field Capacity (DOY)", 
              marker = list(color = 'rgba(34, 139, 34, 1)', size = 10)) %>%
    add_trace(x = df_doy$Date, y = df_doy$PWP, type = 'scatter', 
              mode = 'markers', name = "Wilting Point (DOY)", 
              marker = list(color = 'rgba(255, 69, 0, 1)', size = 10)) %>%
    
    
    layout(
      title = list(text = paste("Water Dynamics for Plot", plot), 
                   font = list(size = 18)),
      xaxis = list(title = list(text = "", 
                                font = list(size = 16)), tickfont = list(size = 14)),
      yaxis = list(title = list(text = "Soil Moisture (%)", 
                                font = list(size = 16)), tickfont = list(size = 14), side = "right"),
      yaxis2 = list(title = list(text = "Irrigation / Rainfall (mm)", 
                                 font = list(size = 16)), 
                    tickfont = list(size = 14), overlaying = "y", side = "left"),
      legend = list(font = list(size = 14), 
                    orientation = "h", x = 0.5, xanchor = "center", y = -0.1) 
    )
  
  plot
}