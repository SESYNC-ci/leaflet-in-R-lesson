---
editor_options: 
  chunk_output_type: console
---

## Leaflet in shiny

Incorporating leaflet maps into [RShiny](https://shiny.rstudio.com/) applications allows for creating more customized interactivity using R code.

As you may have learned in the [Shiny lesson](https://cyberhelp.sesync.org/basic-Shiny-lesson/), the app comprises a *user interface* object that defines how it appears, and a *server* object that defines how it behaves. 

===

The ui and server interact through `*input` and `*output` objects such as input widgets, plots, buttons, tables, etc. Leaflet maps in Shiny are constructed with `renderLeaflet()` and displayed in the output using `leafletOutput()`.

![shinyarrows]({{ site.baseurl }}/images/shiny-arrows.png)

===

To see how this works, we'll build a shiny app with a leaflet map, where one of the map layers is defined with a user-specified value from an input widget. See the app in action [here](https://shiny.sesync.org/apps/leaflet-in-R-shinydemo1/). 

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
{:.text-document .no-eval title="{{ site.handouts[2] }}"}


===

Define the ui to include the output called "map". 



~~~r
ui <- fluidPage(
  leafletOutput("map", height = 800)
)
~~~
{:.text-document .no-eval title="{{ site.handouts[2] }}"}


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
{:.text-document .no-eval title="{{ site.handouts[2] }}"}


===

Use the `dateinput` input object in the Provider Tiles layer.



~~~r
 addProviderTiles(providers$NASAGIBS.ModisTerraTrueColorCR, group = "Modis",
                       options = providerTileOptions(time = input$dateinput))
~~~
{:.text-document .no-eval title="{{ site.handouts[2] }}"}

