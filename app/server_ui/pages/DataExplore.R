data_explore <- function(){
  fluidPage(
    div(
      class = "page",
      div(
        class = "outputs",
        p(
          "Click on a plot to see its data",
          style = "margin-bottom: 5px; margin-top: 5px; font-weight: bold;"
        ),
        div(
          class = "upper-section",
          div(
              class = "map-box",
              uiOutput(outputId = "infoBox"),
              leafletOutput("map", width = "470px", height = "350px") %>% withSpinner(color="#512888"),
          ),
          div(
            style = "width: 200px;",
            plotlyOutput(outputId = "SoilMoisture") %>% withSpinner(color="#512888"),
          ),
          div(
            style = "width: 200px;",
            plotlyOutput(outputId = "Irrigation") %>% withSpinner(color="#512888"),
          ),
          div(
            uiOutput(outputId = "staticCards"),
          )
        ),
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
            style = "display:flex; justify-content: space-between; width: 300px",
            span("May 9"),
            span("July 28"),
            span("October 9")
          )
        ),
        div(
          class = "temporal-graphs",
          div(
            plotlyOutput(outputId = "NDVITemporal") %>% withSpinner(color="#512888")
          ),
          div(
            plotlyOutput(outputId = "TemporalSoilMoisture") %>% withSpinner(color="#512888")
          )
        )
      )
    )
  )
}