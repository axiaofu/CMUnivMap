
# global setting ----------------------------------------------------------

options(stringsAsFactors = FALSE)
library(magrittr)
library(data.table)
library(shiny)
library(shinythemes)
library(DT)
library(shinyjs)
library(shinyBS)
library(leaflet)

# data --------------------------------------------------------------------

# read data
dt <- readxl::read_excel("data.xlsx") %>% setDT()
dt_lng_lat <- readxl::read_excel("lng-lat.xlsx") %>% setDT()

# gen random attitude
dt[, c("lng", "lat") := dt_lng_lat[sample(1:.N, nrow(dt)), .(lng, lat)]]

# ui ----------------------------------------------------------------------

navbarPage(
  title = "China Medicine University Distribution",
  theme = shinytheme("united"),
  collapsible = TRUE,
  tabPanel(
    title = "Global Map",
    leafletOutput("global_map", height = "800px")
  ),
  tabPanel(
    title = "Query",
    bsCollapse(
      multiple = TRUE,
      open = c("Query Table", "Location"),
      bsCollapsePanel(
        title = "Query Table",
        dataTableOutput("query_table")
      ),
      bsCollapsePanel(
        title = "Location",
        leafletOutput("location")
      )
    )
  )
)