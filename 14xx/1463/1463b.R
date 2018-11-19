library(oce)
library(shiny)
ui <- fluidPage(fluidRow(column=2, sliderInput("l", "log10(time interval [sec])", min=0, max=6, value=1, step=0.01)),
                fluidRow(column(10, plotOutput("timeSeries"))))
server <- function(input, output) {
    output$timeSeries <- renderPlot({
        t0 <- as.POSIXct("2018-11-19 00:00:00", tz="UTC")
        t <- c(t0, t0+10^input$l)
        oce.plot.ts(t, seq_along(t), debug=10)
        mtext(sprintf("l=%.2g, 10^l=%.2g [sec]", input$l, 10^input$l), side=3, line=-1)
    })
}
shinyApp(ui, server)

