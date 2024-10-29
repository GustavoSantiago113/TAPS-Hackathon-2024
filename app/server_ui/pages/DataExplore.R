source("server_ui/components/Header.R")

data_explore <- function(){
  fluidPage(
    header(),
    div(
      class = "page",
      div(
          h3(
              "Click on a plot to see its data"
            ),
          div(
            class = "map-box",
            leafletOutput("map", width = "350px", height = "450px") %>% withSpinner(color="#512888"),
            uiOutput(outputId = "infoBox"),
            "Graph"
          ),
      ),
      uiOutput(outputId = "staticCards")
    )
  )
}