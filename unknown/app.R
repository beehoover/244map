#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)


ui <- list(checkboxGroupInput("varbox", "Variable", choices = c("x", "y")),
           br(), br(),
           checkboxGroupInput("datebox", "Date", choices = c("1", "2", "3")),
           br(), br(),
           actionButton("btn", "update"),
           tableOutput("tbl")) 

server <- function(input, output) {
  
  sub_fun <- function(dates, variables) {
    # sub function to create table
    # this does not have any reactive element inside
    tmp <- data.frame(day = rep(1:3, 4), x = 1:12, y = 13:24)
    tmp[tmp$day %in% dates, c("day", variables), drop = FALSE]
  }
  
  get_table <- eventReactive({input$btn; input$datebox}, {
    # reactive function to define the configulation
    sub_fun(as.character(input$datebox), input$varbox)
  })  
  
  output$tbl <- renderTable({
    get_table()
  })
}

shinyApp(list(ui = ui, server = server))
