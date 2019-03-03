#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Shiny Client Data"),
  sidebarPanel(
    sliderInput("obs", "Number of observations:",
                min = 0, max = 1000, value = 500)
  ),
  mainPanel(
    h3("clientData values"),
    verbatimTextOutput("clientdataText"),
    plotOutput("myplot")
  )
))