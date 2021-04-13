---
---

## Publish a Leaflet map using HTML

If you prefer not to use Shinny, you can render a map using HTML!

~~~r
library(leaflet)

map <- leaflet() %>%
  addTiles() %>%
  setView(lng = -76.505206, lat = 38.9767231, zoom = 5) %>%
  addWMSTiles(
    "http://mesonet.agron.iastate.edu/cgi-bin/wms/nexrad/n0r.cgi",
    layers = "nexrad-n0r-900913", 
    options = WMSTileOptions(format = "image/png", transparent = TRUE),
    attribution = "Weather data © 2012 IEM Nexrad"
  )

saveWidget(map, file="map.html")    # Save map as an html file
~~~

You can now open `map.htlm` in your browser. `map.html` will open as a full screen html file in your browser. 

You can upload the html file wherever you like and then iframe to it if you want to embed it into a website:
```html
<iframe src="map.html" frameborder="0" width="100%" height="400px"></iframe>
```

===
