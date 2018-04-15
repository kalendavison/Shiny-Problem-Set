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
      plotOutput(outputId = "Plot")
    )
    
  )
)



# Define server logic to summarize and view selected dataset ----
server <- function(input, output) {
  library(EBMAforecast)
  data("presidentialForecast")
  
  datasetInput <- reactive({
    presidentialForecast
  })
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
  })
  
}





# Create Shiny app ----
shinyApp(ui = ui, server = server)


