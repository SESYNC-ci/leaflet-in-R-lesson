---
editor_options: 
  chunk_output_type: console
---

## Layers Control

Layers can be assigned to named **groups** which can be toggled on and off by the user. *baseGroups* are selected with radio buttons (can only choose one at a time), and *overlayGroups* get checkboxes. 

To implement layers control, add group names to individual layers with the `group =` argument **AND** add the layers control layer using `addLayersControl()`. 



~~~r
leaflet() %>%
  addTiles(group = "OSM") %>%
  addProviderTiles(providers$Esri.WorldImagery, group = "Esri World Imagery") %>%
  setView(lng = -76.505206, lat = 38.9767231, zoom = 7) %>%
  addMarkers(lng = -76.505206, lat = 38.9767231, popup = "I am here!", group = "SESYNC") %>%
  addLayersControl(baseGroups = c("OSM", "Esri World Imagery"), 
                   overlayGroups = c("SESYNC"),
                   options = layersControlOptions(collapsed = FALSE))
~~~
{:.text-document title="{{ site.handouts[0] }}"}

<div class="figure">
<!--html_preserve--><div id="htmlwidget-deb4cf2e604225576b3e" style="width:504px;height:504px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-deb4cf2e604225576b3e">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,"OSM",{"minZoom":0,"maxZoom":18,"maxNativeZoom":null,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"continuousWorld":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":null,"unloadInvisibleTiles":null,"updateWhenIdle":null,"detectRetina":false,"reuseTiles":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">OpenStreetMap<\/a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA<\/a>"}]},{"method":"addProviderTiles","args":["Esri.WorldImagery",null,"Esri World Imagery",{"errorTileUrl":"","noWrap":false,"zIndex":null,"unloadInvisibleTiles":null,"updateWhenIdle":null,"detectRetina":false,"reuseTiles":false}]},{"method":"addMarkers","args":[38.9767231,-76.505206,null,null,"SESYNC",{"clickable":true,"draggable":false,"keyboard":true,"title":"","alt":"","zIndexOffset":0,"opacity":1,"riseOnHover":false,"riseOffset":250},"I am here!",null,null,null,null,null,null]},{"method":"addLayersControl","args":[["OSM","Esri World Imagery"],"SESYNC",{"collapsed":false,"autoZIndex":true,"position":"topright"}]}],"setView":[[38.9767231,-76.505206],7,[]],"limits":{"lat":[38.9767231,38.9767231],"lng":[-76.505206,-76.505206]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->
<p class="caption"> </p>
</div>

===

Another type of tile layer is avaible through many web mapping services (WMS), such as the real-time weather radar data from the [Iowa Environmental Mesonet](https://mesonet.agron.iastate.edu/ogc/).


~~~r
leaflet() %>%
  addTiles() %>%
  setView(lng = -76.505206, lat = 38.9767231, zoom = 5) %>%
  addWMSTiles(
    "http://mesonet.agron.iastate.edu/cgi-bin/wms/nexrad/n0r.cgi",
    layers = "nexrad-n0r-900913", 
    options = WMSTileOptions(format = "image/png", transparent = TRUE),
    attribution = "Weather data © 2012 IEM Nexrad"
  ) 
~~~
{:.text-document title="{{ site.handouts[0] }}"}

<div class="figure">
<!--html_preserve--><div id="htmlwidget-f8e9fa8767eef85dd819" style="width:504px;height:504px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-f8e9fa8767eef85dd819">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"maxNativeZoom":null,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"continuousWorld":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":null,"unloadInvisibleTiles":null,"updateWhenIdle":null,"detectRetina":false,"reuseTiles":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">OpenStreetMap<\/a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA<\/a>"}]},{"method":"addWMSTiles","args":["http://mesonet.agron.iastate.edu/cgi-bin/wms/nexrad/n0r.cgi",null,null,{"styles":"","format":"image/png","transparent":true,"version":"1.1.1","crs":null,"attribution":"Weather data © 2012 IEM Nexrad","layers":"nexrad-n0r-900913"}]}],"setView":[[38.9767231,-76.505206],5,[]]},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->
<p class="caption"> </p>
</div>

===

or USGS topographic maps from the [National Map](https://viewer.nationalmap.gov/help/HowTo.htm): 


~~~r
nhd_wms_url <- "https://basemap.nationalmap.gov/arcgis/services/USGSTopo/MapServer/WmsServer"

leaflet() %>% 
  setView(lng = -111.846061, lat = 36.115847, zoom = 12) %>%
  addWMSTiles(nhd_wms_url, layers = "0")
~~~
{:.text-document title="{{ site.handouts[0] }}"}

<div class="figure">
<!--html_preserve--><div id="htmlwidget-dffc47d69d227837cf10" style="width:504px;height:504px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-dffc47d69d227837cf10">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"setView":[[36.115847,-111.846061],12,[]],"calls":[{"method":"addWMSTiles","args":["https://basemap.nationalmap.gov/arcgis/services/USGSTopo/MapServer/WmsServer",null,null,{"styles":"","format":"image/jpeg","transparent":false,"version":"1.1.1","crs":null,"layers":"0"}]}]},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->
<p class="caption"> </p>
</div>

Thanks USGS! Check out more USGS [Web Mapping Services](https://viewer.nationalmap.gov/services/), and R packages for accessing, processing, and modeling data on [github](https://github.com/USGS-R).

===

In addition to tile layers and markers, many other map features can be added and customized with `add*()` functions. Refer to the help documentation (eg. `?addMiniMap`) to see all of the customization options and learn the default settings. 


~~~r
leaflet() %>% 
  setView(lng = -111.846061, lat = 36.115847, zoom = 12) %>%
  addWMSTiles(nhd_wms_url, layers = "0") %>%
  addMiniMap(zoomLevelOffset = -4)
~~~
{:.text-document title="{{ site.handouts[0] }}"}

<div class="figure">
<!--html_preserve--><div id="htmlwidget-8afceff997ea52b4d0f0" style="width:504px;height:504px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-8afceff997ea52b4d0f0">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"setView":[[36.115847,-111.846061],12,[]],"calls":[{"method":"addWMSTiles","args":["https://basemap.nationalmap.gov/arcgis/services/USGSTopo/MapServer/WmsServer",null,null,{"styles":"","format":"image/jpeg","transparent":false,"version":"1.1.1","crs":null,"layers":"0"}]},{"method":"addMiniMap","args":[null,null,"bottomright",150,150,19,19,-4,false,false,false,false,false,false,{"color":"#ff7800","weight":1,"clickable":false},{"color":"#000000","weight":1,"clickable":false,"opacity":0,"fillOpacity":0},{"hideText":"Hide MiniMap","showText":"Show MiniMap"},[]]}]},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->
<p class="caption"> </p>
</div>

===

Add layers with common map elements and customize them with `add*`. Even more new features coming soon! 


~~~r
leaflet() %>% 
  setView(lng = -111.846061, lat = 36.115847, zoom = 12) %>%
  addWMSTiles(nhd_wms_url, layers = "0") %>%
  addMiniMap(zoomLevelOffset = -4) %>%
  addGraticule() %>%
  addTerminator() %>% 
  addMeasure() %>%
  addScaleBar()
~~~
{:.text-document title="{{ site.handouts[0] }}"}

<div class="figure">
<!--html_preserve--><div id="htmlwidget-c0480b175e42a4e4dd3c" style="width:504px;height:504px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-c0480b175e42a4e4dd3c">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"setView":[[36.115847,-111.846061],12,[]],"calls":[{"method":"addWMSTiles","args":["https://basemap.nationalmap.gov/arcgis/services/USGSTopo/MapServer/WmsServer",null,null,{"styles":"","format":"image/jpeg","transparent":false,"version":"1.1.1","crs":null,"layers":"0"}]},{"method":"addMiniMap","args":[null,null,"bottomright",150,150,19,19,-4,false,false,false,false,false,false,{"color":"#ff7800","weight":1,"clickable":false},{"color":"#000000","weight":1,"clickable":false,"opacity":0,"fillOpacity":0},{"hideText":"Hide MiniMap","showText":"Show MiniMap"},[]]},{"method":"addGraticule","args":[20,false,{"color":"#333","weight":1},null,null,{"lineCap":null,"lineJoin":null,"clickable":false,"pointerEvents":"none","className":""}]},{"method":"addTerminator","args":[2,null,null,null,{"lineCap":null,"lineJoin":null,"clickable":false,"pointerEvents":"none","className":""}]},{"method":"addMeasure","args":[{"position":"topright","primaryLengthUnit":"feet","primaryAreaUnit":"acres","activeColor":"#ABE67E","completedColor":"#C8F2BE","popupOptions":{"className":"leaflet-measure-resultpopup","autoPanPadding":[10,10]},"captureZIndex":10000,"localization":"en","decPoint":".","thousandsSep":","}]},{"method":"addScaleBar","args":[{"maxWidth":100,"metric":true,"imperial":true,"updateWhenIdle":true,"position":"topright"}]}]},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->
<p class="caption"> </p>
</div>


===

Trigger custom javascript logic with *EasyButtons*. 


~~~r
leaflet() %>%
  addTiles() %>% 
  addEasyButton(easyButton(
    icon="fa-crosshairs", title = "Locate me", 
    onClick=JS("function(btn, map){ map.locate({setView: true}); }")))
~~~
{:.text-document title="{{ site.handouts[0] }}"}

<div class="figure">
<!--html_preserve--><div id="htmlwidget-e45a3e4aff8161af4c10" style="width:504px;height:504px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-e45a3e4aff8161af4c10">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"maxNativeZoom":null,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"continuousWorld":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":null,"unloadInvisibleTiles":null,"updateWhenIdle":null,"detectRetina":false,"reuseTiles":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">OpenStreetMap<\/a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA<\/a>"}]},{"method":"addEasyButton","args":[{"icon":"fa-crosshairs","title":"Locate me","onClick":"function(btn, map){ map.locate({setView: true}); }","position":"topleft"}]}]},"evals":["calls.1.args.0.onClick"],"jsHooks":[]}</script><!--/html_preserve-->
<p class="caption"> </p>
</div>

The fine print: Note that RStudio's viewer pane or external window does not always behave the same as a web brower.
