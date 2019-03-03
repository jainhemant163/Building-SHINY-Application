#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

shinyServer(function(input, output, session) {
  # Store in a convenience variable
  cdata <- session$clientData
  
  # Values from cdata returned as text
  output$clientdataText <- renderText({
    cnames <- names(cdata)
    
    allvalues <- lapply(cnames, function(name) {
      paste(name, cdata[[name]], sep=" = ")
    })
    paste(allvalues, collapse = "\n")
  })
  
  # A histogram
  output$myplot <- renderPlot({
    hist(rnorm(input$obs), main="Generated in renderPlot()")
  })
})