
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

    tabsetPanel(
        tabPanel("Main Shiny App",
                 # Application title
                 titlePanel("Diabetes Prediction Function"),
                 headerPanel(h3('Please specify the various inputs here')),
                 
                 inputPanel(
                     sliderInput(inputId = 'age', label = 'The age of the patient', value = 40, min = 10, max = 100, step = 1),
                     sliderInput(inputId = 'height', label = 'The height of the patient in inches', value = 64, min = 58, max = 94, step = 1),
                     sliderInput(inputId = 'waist', label = 'The waist measurement of the patient in inches', value = 30, min = 20, max = 60, step = 1),
                     numericInput(inputId = 'glucose', label = 'Glucose mg/dl', value = 90, min = 50, max = 200, step = 5),
                     checkboxInput(inputId = 'famhist', label = 'History of diabetes in family?', value = FALSE),
                     submitButton('Submit')
                 ),
                 mainPanel(
                     h3('Results of prediction'),
                     h4('You entered'),
                     verbatimTextOutput("ageValue"),
                     verbatimTextOutput("heightValue"),
                     verbatimTextOutput("waistValue"),
                     verbatimTextOutput("glucoseValue"),
                     verbatimTextOutput("famhistValue"),
                     h4('Which resulted in a prediction of '),
                     verbatimTextOutput("prediction")
                 )
        ),
        tabPanel("About this Shiny App",
                 mainPanel(
                     "Some text will go here."
                 )),
        tabPanel("Disclaimer",
                 mainPanel(
                     "Disclaimer: This prediction function is provided for illustration purposes only and is not intended for use as a substitute for trained medical examination or evaluation. For serious diabetes care, please contact your primary care physician or other medical professional."
                 ))
    )
))
