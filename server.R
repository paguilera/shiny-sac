
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(plyr)

diabetesRisk <- function(glucose) {
    glucose / 200  
}

shinyServer(function(input, output) {
    
    output$ageValue <- renderPrint({input$age})
    output$weightValue <- renderPrint({input$weight})
    output$waistValue <- renderPrint({input$waist})
    output$glucoseValue <- renderPrint({input$glucose})
    output$famhistValue <- renderPrint({input$famhist})
    output$prediction <- renderPrint({diabetesRisk(input$glucose)})

})
