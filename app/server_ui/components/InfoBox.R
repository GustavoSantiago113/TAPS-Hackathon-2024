info_box_render <- function(static_data, selected_plot){
  
  plot <- selected_plot()
  
  data <- static_data %>%
    filter(Plot_ID == plot)

  tagList(
    div(
      class = "info-box",
      p(paste("Plot ID: ", plot, sep = "")),
      p(paste("Team: ", data$Team, sep = "")),
      p(paste("Population: ", data$Population, sep = "")),
      p(paste("Planting date: ", data$PlantingDate, sep = "")),
      p(paste("Hybrid: ", data$Hybrid, sep = "")),
      p(paste("Seed company: ", data$Company, sep = "")),
    )
  )
}