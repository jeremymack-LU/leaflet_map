library(leaflet)
library(albersusa)

# State boundary sf object
usa.sf <- usa_sf("longlat")
sf::st_crs(usa.sf) <- sf::st_crs(usa.sf)

m <- leaflet() %>%
  addPolygons(data=usa.sf,
              weight=1,
              label=~name)