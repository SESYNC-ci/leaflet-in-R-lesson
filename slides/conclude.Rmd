---
---

## Summary

Main functions for leaflet maps

* **View window** - `setView(lat, lon, zoom)` `fitBounds()` `setMaxBounds()`
* **Background tiles** - `addTiles()` `addProviderTiles()` `addWMSTiles()`
* **Point layers** - `addMarkers()` `addCircleMarkers()` `addAwesomeMarkers()` `addLabelOnlyMarkers()`
* **Shape layers** - `addPolylines()` `addCircles()` `addRectangles()` `addPolygons()`
* **Images** - `addRasterImage()`
* **Common features** - `addLegend()` `addLayersControl()` `addControl()`

For HTML

* `saveWidget(map, file="map.html")` saves your map object as an html file which can be loaded in a browser. 
* Use `iframe` to embed the map html file to your website and share it :). 

For Shiny apps

* `renderLeaflet()` objects in the server and use them in the ui with `leafletOutput()`
* Use `shinyApp()` to display your map with Shiny.  
* Host your app on GitHub or another web server and share your app. 

