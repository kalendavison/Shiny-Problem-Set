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
                  choices = c("Campbell", "Lewis-Baeck", "EWT2C2", "Fair", "Hibbs", "Abramowitz")),
      
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
      plotOutput("plot")
    )
    
  )
)



# Define server logic to summarize and view selected dataset ----
server <- function(input, output) {
  library(EBMAforecast)
  data("presidentialForecast")
  
  output$plot <- renderPlot({
    input$newplot
    # Add a little noise to the cars data
    plot(x = 1:15, y = presidentialForecast$Actual, main = "Election Results by Indexed Election Year", 
         xlab = "Indexed Election Year 1952-2008", ylab = "Election Results", col = 12, type = "l")
    
  })

  
  datasetInput <- reactive({
    presidentialForecast
  })
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
  })
  
}




# Create Shiny app ----
shinyApp(ui = ui, server = server)


