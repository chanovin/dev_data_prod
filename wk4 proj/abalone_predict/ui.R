#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
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
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Abalone Age Estimator"),
  
  # Sidebar with a slider inputs diameter, height, and length
  # plus a dropdown for plot x-axis
  sidebarLayout(
    sidebarPanel(
       sliderInput("diam","Diameter (inches):",
                   min = 0.00, max = 0.75, value = 0.40, step = .01),
       sliderInput("leng","Length (inches):",
                   min = 0.00, max = 1.00, value = 0.50, step = .01),
       sliderInput("ht","Height (inches):",
                   min = 0.00, max = 1.25, value = 0.15, step = .01),
       selectInput("xaxis",'x-axis',c('diameter','length','height')),
       br(), br(), h3("Documentation"), br(), 
       em("This Shiny app takes about one minute to load; please wait for the plot to appear."),
       br(), br(), "This app estimates an abalone's age based on three measurements input by you.",
       br(), br(), "You can also choose the x-axis for the plot to compare your abalone with the data.",
       br(), br(), "Estimation is performed based on a treebag fit."
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("abaPlot"),
       textOutput("abaText")
    )
  )
))
