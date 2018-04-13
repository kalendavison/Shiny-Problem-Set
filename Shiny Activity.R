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
      
      # Include clarifying text ----
      helpText("Here are the results from presidential forecasts from 1952-2008")
    ),
    
    
    # Main panel for displaying outputs ----
    mainPanel(
      tableOutput("view")
    )
    
  )
)



# Define server logic to summarize and view selected dataset ----
server <- function(input, output) {
  library(EBMAforecast)
  data("presidentialForecast")
  
  output$view <- renderTable({
  presidentialForecast
    })
}

# Create Shiny app ----
shinyApp(ui, server)


