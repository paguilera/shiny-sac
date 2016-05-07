
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {
    
    # Check if our desired working directory exists. If it doesn't, then create it.
    if(!file.exists("./data")){dir.create("./data")}
    
    # Moving into the desired working directory after recording our starting directory.
    original_dir <- getwd()
    setwd("./data")
    
    # First step is to download the zip file that contains our data and then unzip it,
    # but only do these steps if the file hasn't already been downloaded and unzipped.
    fileUrl <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00356/student.zip"
    zipFile <- "student.zip"
    if(!file.exists(zipFile)){
        download.file(fileUrl,destfile=zipFile,mode="wb")
        unzip(zipFile)
    }
    
    # Using the information found in the student-merge.R file included in the zipfile
    d1 <- read.table("student-mat.csv",sep=";",header=TRUE)
    d1$class <- "Math"
    d2 <- read.table("student-por.csv",sep=";",header=TRUE)
    d2$class <- "Portuguese"
    
    d3 <- merge(d1,d2,by=c("school","sex","age","address","famsize","Pstatus","Medu",
                           "Fedu","Mjob","Fjob","reason","guardian","traveltime","studytime",
                           "failures","schoolsup","famsup","paid","activities","nursery",
                           "higher","internet","romantic","famrel","freetime","goout","Dalc",
                           "Walc","health","absences","class","G1","G2","G3"))
    d3$school <- as.factor(d3$school)
    d3$sex <- as.factor(d3$sex)
    d3$age <- as.factor(d3$age)
    d3$Medu <- as.factor(d3$Medu)
    d3$Fedu <- as.factor(d3$Fedu)
    d3$traveltime <- as.factor(d3$traveltime)
    d3$studytime <- as.factor(d3$studytime)
    d3$failures <- as.factor(d3$failures)
    d3$famrel <- as.factor(d3$famrel)
    d3$freetime <- as.factor(d3$freetime)
    d3$goout <- as.factor(d3$goout)
    d3$Dalc <- as.factor(d3$Dalc)
    d3$Walc <- as.factor(d3$Walc)
    d3$health <- as.factor(d3$health)
    d3$class <- as.factor(d3$class)


  output$distPlot <- renderPlot({

      # Compute the forumla text in a reactive expression since it is 
      # shared by the output$caption and output$mpgPlot expressions
      formulaText <- reactive({
          paste("d3 ~", input$variable)
      })
      
      # Return the formula text for printing as a caption
      output$caption <- renderText({
          formulaText()
      })
      
      # Generate a plot of the requested variable against mpg and only 
      # include outliers if requested
      output$d3Plot <- renderPlot({
          boxplot(as.formula(formulaText()), 
                  data = d3,
                  outline = input$outliers)
      })
  })

})
