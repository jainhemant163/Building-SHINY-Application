#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/

#UI

library(shiny)
library(ggplot2)  # for the diamonds dataset

ui<-shinyUI(pageWithSidebar(
  headerPanel('Examples of DataTables'),
  sidebarPanel(
    checkboxGroupInput('show_vars', 'Columns in diamonds to show:', names(diamonds),
                       selected = names(diamonds)),
    helpText('For the diamonds data, we can select variables to show in the table;
             for the mtcars example, we use bSortClasses = TRUE so that sorted
             columns are colored since they have special CSS classes attached;
             for the iris data, we customize the length menu so we can display 5
             rows per page.')
  ),
  mainPanel(
    tabsetPanel(
      tabPanel('diamonds',
               dataTableOutput("mytable1")),
      tabPanel('mtcars',
               dataTableOutput("mytable2")),
      tabPanel('iris',
               dataTableOutput("mytable3"))
    )
  )
))

#server 
library(shiny)

server <- shinyServer(function(input, output) {
  
  # a large table, reative to input$show_vars
  output$mytable1 = renderDataTable({
    library(ggplot2)
    diamonds[, input$show_vars, drop = FALSE]
  })
  
  # sorted columns are colored now because CSS are attached to them
  output$mytable2 = renderDataTable({
    mtcars
  }, options = list(bSortClasses = TRUE))
  
  # customize the length drop-down menu; display 5 rows per page by default
  output$mytable3 = renderDataTable({
    iris
  }, options = list(aLengthMenu = c(5, 30, 50), iDisplayLength = 5))
  
})

# Run the application 
shinyApp(ui = ui, server = server)

