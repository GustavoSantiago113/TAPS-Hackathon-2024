list.of.packages <- c(
  "shiny",
  "shiny.router",
  "leaflet",
  "sf",
  "dplyr",
  "shinyjs",
  "shinycssloaders",
  "plotly",
  "lubridate"
)

new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library(shiny)
library(shiny.router)
library(leaflet)
library(sf)
library(dplyr)
library(shinyjs)
library(shinycssloaders)
library(plotly)
library(lubridate)