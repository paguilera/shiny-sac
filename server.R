
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(plyr)

diabetesRisk <- function(age, height, waist, glucose, famhist) {
    value.age = age / 100
    value.wtoh = 0
    value.glucose = glucose / 200
    value.fam = 0
    if (famhist == TRUE) {value.fam = 1}
    if (waist > (height/2)) {value.wtoh = 1}
    (value.age + value.glucose + value.fam + value.wtoh) / 2
}

shinyServer(function(input, output) {
    
    output$ageValue <- renderPrint({input$age})
    output$heightValue <- renderPrint({input$height})
    output$waistValue <- renderPrint({input$waist})
    output$glucoseValue <- renderPrint({input$glucose})
    output$famhistValue <- renderPrint({input$famhist})
    output$prediction <- renderPrint({diabetesRisk(input$age, input$height, input$waist, input$glucose, input$famhist)})

})
