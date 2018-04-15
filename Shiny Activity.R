getwd()
setwd("/Users/kalendavison/Desktop/Applied Statistical Programming/GitHub/Shiny-Problem-Set")
library(shiny)

# Define UI for dataset viewer app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Presidential Forecasts"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      selectInput(inputId = "forecast",
                  label = "Choose a forecast:",
                  choices = c("Campbell", "Lewis-Beck", "EWT2C2", "Fair", "Hibbs", "Abramowitz")),
      
      # Input: Numeric entry for number of obs to view ----
      numericInput(inputId = "obs",
                   label = "Number of elections to display:",
                   value = 15
    ),
      
      
      # Include clarifying text ----
      helpText("Here are the results from presidential forecasts from 1952-2008")
    ),
    
    
    # Main panel for displaying outputs ----
    mainPanel(
      tableOutput("view"),
      plotOutput("plot", click = "plot_click"),
      verbatimTextOutput("info")
    )
    
    
  )
)



# Define server logic to summarize and view selected dataset ----
server <- function(input, output) {
  library(EBMAforecast)
  data("presidentialForecast")
  
  forecastInput <- reactive({
    switch(input$forecast,
           "Campbell" = presidentialForecast$Campbell,
           "Lewis-Beck" = presidentialForecast$`Lewis-Beck`,
           "EWT2C2" = presidentialForecast$EWT2C2,
           "Fair" = presidentialForecast$Fair,
           "Hibbs" = presidentialForecast$Hibbs,
           "Abramowitz" = presidentialForecast$Abramowitz) 
  })
  
  output$plot <- renderPlot({
    input$newplot
    plot(x = 1:15, y = presidentialForecast$Actual, main = "Election Results by Indexed Election Year", 
         xlab = "Indexed Election Year 1952-2008", ylab = "Election Results", col = 12, type = "l")
    lines(x = 1:15, y = forecastInput())
    
  })
    
  datasetInput <- reactive({
    presidentialForecast
  })
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
  })
  
  output$info <- renderText({
    paste0("x=", input$plot_click$x, "\ny=", input$plot_click$y)
  })
}


# Create Shiny app ----
shinyApp(ui = ui, server = server)


