source("server_ui/components/Header.R")

data_explore <- function(){
  fluidPage(
    header(),
    div(
      class = "page",
      div(
        class = "outputs",
        br(),
        sliderInput(
          inputId = "dateInput",
          label = "Change the day of the year",
          min = 92,
          max = 289,
          value = 92,
          step = 1
        ),
        h3(
            "Click on a plot to see the data"
          ),
        div(
          class = "map-box",
          leafletOutput("map", width = "550px", height = "350px") %>% withSpinner(color="#512888"),
          uiOutput(outputId = "infoBox"),
         ),
        br(),
        "NDVI Graph",
        br(),
        "Plot 2"
      ),
      div(
        class = "output-right",
        br(),
        uiOutput(outputId = "staticCards"),
        br(),
        "Plot 4"
      )
    )
  )
}