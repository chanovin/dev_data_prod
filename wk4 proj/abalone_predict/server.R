#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(caret)
library(lattice)
library(ggplot2)
library(ipred)
library(plyr)
library(e1071)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  abalone <- read.csv(url("http://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.data"),
                      header=FALSE)
  names(abalone) <- c("sex","length","diameter","height","whole_wt","shuck_wt","visc_wt","shell_wt","rings")
  abalone$rings <- as.factor(abalone$rings)
  fit <- train(rings ~ length + diameter + height, data=abalone, method="treebag")
   
    output$abaPlot <- renderPlot({
      newAbalone <- data.frame(length=input$leng,diameter=input$diam,height=input$ht)
      theorAbalone <- data.frame(length=input$leng,diameter=input$diam,height=input$ht,
                                 rings=predict(fit, newAbalone))
      if(input$xaxis == "diameter")
        thisplot <- ggplot(abalone, aes(x=diameter,y=rings)) + geom_point(shape=1) +
          geom_point(data=theorAbalone,aes(x=diameter, y=rings),shape=4,color="red")
      else if(input$xaxis == "height")
        thisplot <- ggplot(abalone, aes(x=height,y=rings)) + geom_point(shape=1) + 
          geom_point(data=theorAbalone,aes(x=height, y=rings),shape=4,color="red")
      else
        thisplot <- ggplot(abalone, aes(x=length,y=rings)) + geom_point(shape=1) + 
          geom_point(data=theorAbalone,aes(x=length, y=rings),shape=4,color="red")
      print(thisplot)
    })

    output$abaText <- renderText({
      newAbalone <- data.frame(length=input$leng,diameter=input$diam,height=input$ht)
      theorAbalone <- data.frame(length=input$leng,diameter=input$diam,height=input$ht,
                                 rings=predict(fit, newAbalone))
      
      paste("Abalone with diameter ", input$diam, " inches, length ", input$leng,
            " inches, and height ", input$ht, " inches is estimated to have ",
            theorAbalone$rings, " rings and to be ", as.numeric(theorAbalone$rings)+1.5, " years old.")
    })
})
  
