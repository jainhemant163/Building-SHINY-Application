#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
# Partial example
checkboxInput("smooth", "Smooth")

conditionalPanel(
  condition = "input.smooth == true",
  selectInput("smoothMethod", "Method",
              list("lm", "glm", "gam", "loess", "rlm"))
)

# Partial example
selectInput("dataset", "Dataset", c("diamonds", "rock", "pressure", "cars")),
conditionalPanel(
  condition = "output.nrows",
  checkboxInput("headonly", "Only use first 1000 rows"))

# Partial example
numericInput("lat", "Latitude"),
numericInput("long", "Longitude"),
uiOutput("cityControls")