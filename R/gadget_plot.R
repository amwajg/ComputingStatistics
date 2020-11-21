#'@title gadget function
#'
#'@param .h input WDI dataset
gadget_plot <-  function(.h) {
  ui <- miniPage(
    gadgetTitleBar("Density Plot"),
    miniTabstripPanel(
      miniTabPanel(
        "Parameters",
        icon = icon("sliders"),
        miniContentPanel(
          selectInput(
            "x",
            "Select X-AXIS",
            series_labels,
            selected = series_labels[c(1)],
            multiple = FALSE,
            selectize = TRUE,
            width = NULL,
            size = NULL)

        )),

      miniTabPanel(
        "Visualize",
        icon = icon("area-chart"),
        miniContentPanel(plotOutput("plot", height = "100%")
        ))





    )
  )

  server <- function(input, output, session) {
    output$plot <- renderPlot({
      location <- which(series_labels == input$x)
      x_value <- series_values[location]
      .h %>%
        ggplot(aes(x = !!sym(x_value)))+
        geom_density() +
        labs(x = input$x)
    })
  }



  runGadget(ui, server)
}
