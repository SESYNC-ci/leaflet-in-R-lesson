# worksheet 5
# leaflet in html

library(htmlwidgets)
library(leaflet)

# Crate a map with point and tiles
rand_lng = function(n = 10) rnorm(n, -93.65, .01)
rand_lat = function(n = 10) rnorm(n, 42.0285, .01)
map = leaflet() %>% addTiles() %>% addCircles(rand_lng(50), rand_lat(50), radius = runif(50, 10, 200))

# Save map to html
saveWidget(map, file="map.html")
