show_cards <- function(static_data, selected_plot){
  
  plot <- selected_plot()
  
  sand_quantile <- quantile(static_data$Sand, probs = c(0.33, 0.66), na.rm = TRUE)
  clay_quantile <- quantile(static_data$Clay, probs = c(0.33, 0.66), na.rm = TRUE)
  som_quantile <- quantile(static_data$SOM, probs = c(0.33, 0.66), na.rm = TRUE)
  ec_shallow_quantile <- quantile(static_data$EC_Shallow, probs = c(0.33, 0.66), na.rm = TRUE)
  ec_deep_quantile <- quantile(static_data$EC_deep, probs = c(0.33, 0.66), na.rm = TRUE)
  
  data <- static_data %>%
    filter(Plot_ID == plot) %>%
    select(c(Sand, Clay, SOM, EC_Shallow, EC_deep))
  
  tagList(
    p(paste("Soil information for plot", plot)),
    div(
      class = "static-cards",
      style = paste("background-color:", get_color(data$Sand, sand_quantile), ";"),
      p(class = "value", round(data$Sand, digits = 1)),
      p(class = "label", "Sand(%)")
    ),
    div(
      class = "static-cards",
      style = paste("background-color:", get_color(data$Clay, clay_quantile), ";"),
      p(class = "value", round(data$Sand, digits = 1)),
      p(class = "label", "Clay(%)")
    ),
    div(
      class = "static-cards",
      style = paste("background-color:", get_color(data$SOM, som_quantile), ";"),
      p(class = "value", round(data$SOM, digits = 1)),
      p(class = "label", "SOM(%)")
    ),
    div(
      class = "static-cards",
      style = paste("background-color:", get_color(data$EC_Shallow, ec_shallow_quantile), ";"),
      p(class = "value", round(data$EC_Shallow, digits = 1)),
      p(class = "label", "EC Shallow(mS/m)")
    ),
    div(
      class = "static-cards",
      style = paste("background-color:", get_color(data$EC_deep, ec_deep_quantile), ";"),
      p(class = "value", round(data$EC_deep, digits = 1)),
      p(class = "label", "EC Deep(mS/m)")
    )
  )

}

get_color <- function(value, quantiles) {
  if (value < quantiles[1]) {
    return("#E06464")
  } else if (value >= quantiles[1] && value < quantiles[2]) {
    return("#E0DC64")
  } else if (value >= quantiles[2]) {
    return("#64E07F")
  } else {
    return("#512888")
  }
}