---
---

## Leaflet in shiny

Add even more interactivity and customization to leaflet maps by incorporating them into [RShiny](https://shiny.rstudio.com/) applications. 

As you may have learned in the [Shiny lesson](https://cyberhelp.sesync.org/basic-Shiny-lesson/), the app comprises a *user interface* object that defines how it appears, and a *server* object that defines how it behaves. 

===

The ui and server interact through `*input` and `*output` objects such as input widgets, plots, buttons, tables, etc. Leaflet maps in Shiny are constructed with `renderLeaflet()` and displayed in the output using `leafletOutput()`.

![shinyarrows]({{ site.baseurl }}/images/shiny-arrows.png)

===

Define an output object called "map" in the server function. 


~~~r
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles(group = "OSM") %>%
      addProviderTiles(providers$NASAGIBS.ModisTerraTrueColorCR, group = "Modis",
                       options = providerTileOptions(time = "2018-01-05")) %>%
      setView(lng = -76.505206, lat = 38.9767231, zoom = 7) %>%
      addLayersControl(baseGroups = c("Modis", "OSM"),
                       options = layersControlOptions(collapsed = FALSE)
      )
  })
~~~
{:.text-document title="{{ site.handouts[2] }}"}


===

Define the ui to include the output called "map". 


~~~r
ui <- fluidPage(
  leafletOutput("map", height = 800)
)
~~~
{:.text-document title="{{ site.handouts[2] }}"}


===

Add a panel to the ui that will let users choose a calendar date. 


~~~r
ui <- fluidPage(
    leafletOutput("map", height = 800),
      absolutePanel(top = 100, right = 10, draggable = TRUE,
              dateInput("dateinput", "Imagery Date", value = "2018-03-28"
                    )
))
~~~
{:.text-document title="{{ site.handouts[2] }}"}


===

Use the `dateinput` input object in the Provider Tiles layer.


~~~r
 addProviderTiles(providers$NASAGIBS.ModisTerraTrueColorCR, group = "Modis",
                       options = providerTileOptions(time = input$dateinput))
~~~
{:.text-document title="{{ site.handouts[2] }}"}

