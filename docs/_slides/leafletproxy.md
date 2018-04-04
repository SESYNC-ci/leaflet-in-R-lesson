---
---

## Leaflet in shiny for people in a hurry

Rendering maps can be slow. Use `leafletProxy()` so the whole map doesn't have to be re-drawn every time the user input is updated. 

===

Define a color palette in the server using colorNumeric and the user's selection from the color brewer palettes (accessed via the row names of the brewer.pal.info data.frame).


~~~r
pal <- colorNumeric(input$colors, wbd_reg2$AREA)
~~~
{:.text-document title="worksheet-4.R"}


===

Run the app and zoom in or out. What happens when you change the color scheme? 

===

Instead of having the `input$` object referred to in the intial `renderLeaflet` definition in the server, move the "reactivity" to a `leafletProxy()` object in the server. Also redefine the initial palette in the renderLeaflet definition eg to "BrBG". 


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
{:.text-document title="worksheet-4.R"}


