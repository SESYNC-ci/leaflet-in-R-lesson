# worksheet 2
# leaflet with data

library(sf) # read in points and polygons
library(raster) # read in raster
library(dplyr) # filter sf objects
library(RColorBrewer) # for brewer.pal.info

# read in water quality portal points
wqp_sites <- ...("data/wqp_sites")

# read in md county boundaries
counties_md <- st_read("data/cb_2016_us_county_5m") %>% 
  filter(STATEFP == "24") %>%
  ...(...)

# read in watershed boundaries for northeast region
wbd_reg2 <- st_read("data/huc250k") %>%
  filter(REG == "02") %>%
  st_transform(4326)

# nlcd raster
nlcd <- ...("data/nlcd_crop.grd")

# add polygons

leaflet() %>%
  ...() %>%
  ...(data = counties_md)

leaflet() %>%
  addTiles() %>%
  addPolygons(data = counties_md, 
              ...)

# use polygon attributes - labeling

leaflet() %>%
  addTiles() %>%
  addPolygons(data = counties_md, ...) %>%
  addPolygons(data = counties_md, ...) %>%
  ...

# use polygon attributes - color fill

leaflet() %>%
  addTiles() %>%
  addPolygons(data = wbd_reg2)

pal <- colorNumeric("PiYG", wbd_reg2$AREA)
# use brewer.pal.info to get list of palettes
# also see colorFactor(), colorBin(), colorQuantile()

leaflet() %>%
  addTiles() %>%
  addPolygons(data = wbd_reg2, 
              fillColor = ..., 
              fillOpacity = 1, 
              weight = 1)

# add Legend

leaflet() %>%
  addTiles() %>%
  addPolygons(data = wbd_reg2, 
              fillColor = ~pal(AREA), 
              fillOpacity = 0.9, 
              weight = 1) %>%
  ...

# add points

leaflet() %>%
  addTiles() %>%
  ...(data = wqp_sites[1:1000,], group = ...) %>%
  ...(data = wqp_sites[1:1000,], radius = 5, group = ...) %>%
  ...(baseGroups = c(...))

# cluster points

leaflet() %>%
  addTiles() %>%
  addMarkers(data = wqp_sites, 
             ...,
             popup = ...(MntrnLN, ",", OrgnztI))

# add raster

leaflet() %>%
  addTiles() %>%
  ...(nlcd)

# Publish a map using html and a web hosting service
# Create a leaflet map, add tiles, and set the view

library(htmlwidgets) 

map <- leaflet() %>%
  addTiles() %>%
  setView(lng = -76.505206, lat = 38.9767231, zoom = 5) %>%
  addWMSTiles(
    "http://mesonet.agron.iastate.edu/cgi-bin/wms/nexrad/n0r.cgi",
    layers = "nexrad-n0r-900913", 
    options = WMSTileOptions(format = "image/png", transparent = TRUE),
    attribution = "Weather data © 2012 IEM Nexrad"
  )

# save map to working directory as an html file
...(map, file="map.html")
