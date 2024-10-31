data_explore <- function(){
  fluidPage(
    div(
      class = "page",
      div(
        class = "outputs",
        div(
          sliderInput(
            inputId = "dateInput",
            label = "Change the day of the year",
            min = 129,
            max = 289,
            value = 200,
            step = 1,
            ticks = FALSE
          ),
          div(
            style = "display:flex; justify-content: space-between; width: 300px; margin-bottom:5px;",
            span("May 9"),
            span("July 28"),
            span("October 9")
          )
        ),
        div(
          class = "upper-section",
          div(
              class = "map-box",
              uiOutput(outputId = "infoBox"),
              div(
                leafletOutput("map", width = "470px", height = "350px") %>% withSpinner(color="#512888"),
                p(
                  "Click on a plot to see its data",
                  style= "font-weight: bold; text-align: center"
                ),
              )
          ),
          div(
            uiOutput(outputId = "staticCards"),
          ),
          div(
            style = "width: 500px;",
            plotlyOutput(outputId = "NDVITemporal") %>% withSpinner(color="#512888")
          )
        ),
        div(
          class = "temporal-graphs",
          div(
            plotlyOutput(outputId = "TemporalSoilMoisture") %>% withSpinner(color="#512888")
          ),
          div(
            style = "width: 250px;",
            plotlyOutput(outputId = "SoilMoisture") %>% withSpinner(color="#512888"),
          ),
          div(
            style = "width: 250px;",
            plotlyOutput(outputId = "Irrigation") %>% withSpinner(color="#512888"),
          )
        )
      )
    )
  )
}