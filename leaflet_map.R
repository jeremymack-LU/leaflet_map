# Packages ----
library(leaflet)
library(sf)
library(tidyverse)
library(htmlwidgets)

# Data ----
# Lehigh buildings url
url <- paste0('https://services5.arcgis.com/i9vGNbDq7aH5qCXl/ArcGIS/rest/services/LU_Indoors_Base_Web_Map_WFL1_view/',
              'FeatureServer/4/query?where=OBJECTID+%3E+0&outFields=NAME%2C+NAME_LONG%2C++LU_SHORTNAME%2C+LU_ADDRESS',
              '&returnGeometry=true&f=geojson')

# Read buildings geojson to sf object
build_sf <- read_sf(url)

# Map ----
# Read in environment file
readRenviron('.renviron')

# Jawg map tile
stadia_key <- Sys.getenv('stadia_key')
stadia_url <- paste0('https://tiles.stadiamaps.com/styles/stamen_terrain.json?api_key=',stadia_key)

# Initial view
lat <- 40.595
lng <- -75.366
zoom <- 14

# Leaflet map
m <- leaflet() |> 
  setView(
    lat = lat,
    lng = lng,
    zoom = zoom) |> 
  addPolygons(
    data = build_sf,
    opacity = 0,
    fillOpacity = 0,
    color = 'white',
    fillColor = '#03F',
    label=~LU_SHORTNAME) |> 
  addTiles('https://tiles.stadiamaps.com/tiles/alidade_smooth/{z}/{x}/{y}{r}.png')

saveWidget(m, file="index.html")

# Unused code ----
# m <- leaflet(
#   options = leafletOptions(
#     doubleClickZoom=FALSE,
#     minZoom = 4,
#     maxZoom = 4)) |>
#   addLabelOnlyMarkers(
#     data=state_centers,
#     label=state_centers$iso_3166_2,
#     lng=state_centers$long,
#     lat=state_centers$lat,
#     labelOptions = labelOptions(
#       noHide = TRUE,
#       direction = 'center',
#       textOnly = TRUE))

