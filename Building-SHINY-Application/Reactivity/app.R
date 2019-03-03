#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for dataset viewer application
ui<- shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Reactivity"),
  
  # Sidebar with controls to provide a caption, select a dataset, and 
  # specify the number of observations to view. Note that changes made
  # to the caption in the textInput control are updated in the output
  # area immediately as you type
  sidebarPanel(
    textInput("caption", "Caption:", "Data Summary"),
    
    selectInput("dataset", "Choose a dataset:", 
                choices = c("rock", "pressure", "cars")),
    
    numericInput("obs", "Number of observations to view:", 10)
  ),
  
  
  # Show the caption, a summary of the dataset and an HTML table with
  # the requested number of observations
  mainPanel(
    h3(textOutput("caption")), 
    
    verbatimTextOutput("summary"), 
    
    tableOutput("view")
  )
))

#Server
library(shiny)
library(datasets)

# Define server logic required to summarize and view the selected dataset
server <-shinyServer(function(input, output) {
  
  # By declaring datasetInput as a reactive expression we ensure that:
  #
  #  1) It is only called when the inputs it depends on changes
  #  2) The computation and result are shared by all the callers (it 
  #     only executes a single time)
  #
  datasetInput <- reactive({
    switch(input$dataset,
           "rock" = rock,
           "pressure" = pressure,
           "cars" = cars)
  })
  
  # The output$caption is computed based on a reactive expression that
  # returns input$caption. When the user changes the "caption" field:
  #
  #  1) This expression is automatically called to recompute the output 
  #  2) The new caption is pushed back to the browser for re-display
  # 
  # Note that because the data-oriented reactive expressions below don't 
  # depend on input$caption, those expressions are NOT called when 
  # input$caption changes.
  output$caption <- renderText({
    input$caption
  })
  
  # The output$summary depends on the datasetInput reactive expression, 
  # so will be re-executed whenever datasetInput is invalidated
  # (i.e. whenever the input$dataset changes)
  output$summary <- renderPrint({
    dataset <- datasetInput()
    summary(dataset)
  })
  
  # The output$view depends on both the databaseInput reactive expression
  # and input$obs, so will be re-executed whenever input$dataset or 
  # input$obs is changed. 
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
  })
})
# Run the application 
shinyApp(ui = ui, server = server)

