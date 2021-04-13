---
---

## Leaflet in shiny for people in a hurry

Rendering maps can be slow. Use `leafletProxy()` so the whole map doesn't have to be re-drawn every time the user input is updated. 

Let's make a new shiny app that only changes one layer when a new value is selected from an input widget. See the app in action [here](https://shiny.sesync.org/apps/leaflet-in-R-shinydemo2/). 

===

Define a color palette in the server object using `colorNumeric()` and the user's selection from the color brewer palettes (accessed via the row names of the `brewer.pal.info` data.frame).



~~~r
pal <- colorNumeric(input$colors, wbd_reg2$AREA)
~~~
{:title="{{ site.data.lesson.handouts[2] }}" .no-eval .text-document}


===

Run the app using `shinyApp(ui, server)` and zoom in or out. What happens when you change the color scheme? 

===

Instead of having the `input$` object referred to in the initial `renderLeaflet` definition in the server, move the "reactivity" to a `leafletProxy()` object in the server object. Also redefine the initial palette in the `renderLeaflet` definition, e.g. to `"BrBG"`. What happens without the `clearControls()` layer? 



~~~r
observe({
    pal <- colorNumeric(input$colors, wbd_reg2$AREA)

    leafletProxy("map") %>%
      clearShapes() %>% clearControls() %>%
      addPolygons(data = wbd_reg2, fill = TRUE,
                  color = "black", weight =1,
                  fillColor = ~pal(AREA), fillOpacity = 0.8,
                  popup = ~HUC_NAME) %>%
      addLegend(position = "bottomright", pal = pal, values = wbd_reg2$AREA)

  })
~~~
{:title="{{ site.data.lesson.handouts[2] }}" .no-eval .text-document}


Refer to [Shinny Apps](https://cyberhelp.sesync.org/basic-Shiny-lesson/) for a more in depth lesson on Shinny. 
