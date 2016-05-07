
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
    
    # First step is to download the zip file that contains our data.
    fileUrl <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00356/student.zip"
    zipFile <- "student.zip"
    if(!file.exists(zipFile)){download.file(fileUrl,destfile=zipFile,mode="wb")}
    
    # Next step is to extract the data from the zip file.
    unzip(zipFile)
    
    # Need to move into the directory that contains the data.
    if(dir.exists("./student")){setwd("./student")}

    # Using the information found in the student-merge.R file included in the zipfile
    d1=read.table("student-mat.csv",sep=";",header=TRUE)
    d2=read.table("student-por.csv",sep=";",header=TRUE)
    
    d3=merge(d1,d2,by=c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet"))

  output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')

  })

})
