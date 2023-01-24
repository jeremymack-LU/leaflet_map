library(leaflet)
library(albersusa)
library(sf)
library(tidyverse)

# State boundary sf object
usa.sf <- usa_sf("longlat")
sf::st_crs(usa.sf) <- sf::st_crs(usa.sf)
sf_use_s2(FALSE)

state_centers <- sf::st_centroid(usa.sf) |> 
  dplyr::select(name,iso_3166_2) |> 
  mutate(long = unlist(map(state_centers$geometry,1)),
         lat = unlist(map(state_centers$geometry,2)))

m <- leaflet() |> 
  addPolygons(data=usa.sf,
              weight=0.5,
              opacity=1,
              color='white',
              fillColor='#03F',
              label=~name) |> 
  addLabelOnlyMarkers(data=state_centers,
                      label=state_centers$iso_3166_2,
                      lng=state_centers$long,
                      lat=state_centers$lat,
                      labelOptions = labelOptions(noHide = TRUE,
                                                  direction = 'center',
                                                  textOnly = TRUE))
