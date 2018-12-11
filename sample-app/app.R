#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("ggplot2 histogram"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins",
                     "Number of bins:",
                     min = 1,
                     max = 50,
                     value = 30),
         hr(),
         selectizeInput("color",
                     "Pick a fill color:",
                     list("red" , "green" , "blue"),
                     options = list(create = TRUE)),
         helpText("Hint: You can add your own colors! Try 'tomato' or #FFF456")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot"),
         textOutput("text")
         
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
   
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      ggplot(mtcars) +
       geom_histogram(aes(mpg), fill = input$color, bins = input$bins) +
       labs(x = "Miles per gallon", y = "Count")
   })
      
   output$text <- renderText({paste("You have created a ggplot histogram with",
                                 input$bins,
                                 "bins and",
                                 input$color,
                                 "fill color")})
   
   
}

# Run the application 
shinyApp(ui = ui, server = server)

