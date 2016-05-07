
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Student Alcohol Consumption"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
        selectInput("variable", "Variable:",
                    list("School" = "school", 
                         "Gender" = "sex", 
                         "Age" = "age")),
        
        checkboxInput("outliers", "Show outliers", FALSE)
    ),

    # Show a plot of the generated distribution
    mainPanel(
        h3(textOutput("caption")),
        
        plotOutput("d3Plot")
    )
  )
))
