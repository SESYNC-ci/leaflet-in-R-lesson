---
editor_options: 
  chunk_output_type: console
---

## Add data Layers

Spatial objects (points, lines, polygons, rasters) in your R environment can also be added as map layers, provided that they have a CRS defined with a datum. Leaflet will try to make the necessary trasnformation to display your data in EPSG:4326. 


===

Read in data using sf and raster packages.


~~~r
library(sf)
library(raster)
library(dplyr)
wqp_sites <- st_read("data/wqp_sites") 
counties_md <- st_read("data/cb_2016_us_county_5m") %>% 
  filter(STATEFP == "24") %>% st_transform(4326)
wbd_reg2 <- st_read("data/huc250k/") %>%
  filter(REG == "02") %>% st_transform(4326)
nlcd <- raster("data/nlcd_crop.grd")
~~~
{:.text-document title="worksheet-2.R"}


===

Add a polygons layer, being sure to specify the `data = ` argument. All of the `add*` layers have "map" as the first argument, facilitating use of the pipe (`%>%`) operator, but `data` is not the second argument so it must be named. 


~~~r
leaflet() %>%
  addTiles() %>%
  addPolygons(data = counties_md)
~~~
{:.text-document title="worksheet-1.R"}


===

Customize Polygons with border and fill colors and opacities.


~~~r
leaflet() %>%
  addTiles() %>%
  addPolygons(data = counties_md, 
              color = "green", 
              fillColor = "gray", 
              fillOpacity = 0.75, 
              weight = 1)
~~~
{:.text-document title="worksheet-2.R"}


===

Attributes can be referred to using the `~` operator in combination with a column name from any `sf` object or `Spatial*DataFrame`. What is the difference between a popup and a label?


~~~r
leaflet() %>%
  addTiles() %>%
  addPolygons(data = counties_md, popup = ~NAME, group = "click") %>%
  addPolygons(data = counties_md, label = ~NAME, group = "hover") %>%
  addLayersControl(baseGroups = c("click", "hover"))
~~~
{:.text-document title="worksheet-2.R"}


===

For numeric or categorical data, create a color palette from [colorbrewer](http://colorbrewer2.org/#) using `colorNumeric()`, `colorFactor()`, `colorBin()`, or `colorQuantile()`. `brewer.pal.info` is a data.frame containing information about the palettes.


~~~r
leaflet() %>%
  addTiles() %>%
  addPolygons(data = wbd_reg2, 
              fillColor = ~pal(AREA), 
              fillOpacity = 1, 
              weight =1)
~~~
{:.text-document title="worksheet-2.R"}


===

Add a legend (which will likely duplicate arguments from the layer that used that palette). 


~~~r
leaflet() %>%
  addTiles() %>%
  addPolygons(data = wbd_reg2, 
              fillColor = ~pal(AREA), 
              fillOpacity = 0.9, 
              weight =1) %>%
  addLegend(pal = pal, values = wbd_reg2$AREA, title = "Watershed Area")
~~~
{:.text-document title="worksheet-2.R"}


===

Add points as markers, circle markers, or [customized icons](https://rstudio.github.io/leaflet/markers.html).


~~~r
leaflet() %>%
  addTiles() %>%
  addMarkers(data = wqp_sites[1:1000,], group = "markers") %>%
  addCircleMarkers(data = wqp_sites[1:1000,], radius = 5, group = "circlemarkers") %>%
  addLayersControl(baseGroups = c("markers", "circlemarkers"))
~~~
{:.text-document title="worksheet-2.R"}


===

Display a different number of markers at each zoom level using `clusterOptions` on markers or circle markers layers


~~~r
leaflet() %>%
  addTiles() %>%
  addMarkers(data = wqp_sites, clusterOptions = markerClusterOptions(),
             popup = ~paste(MntrnLN, ",", OrgnztI))
~~~
{:.text-document title="worksheet-2.R"}


===

Rasters can be slow to load. Be patient but also check out the `maxBytes =` argument if need be. 


~~~r
leaflet() %>%
  addTiles() %>%
  addRasterImage(nlcd)
~~~
{:.text-document title="worksheet-2.R"}


