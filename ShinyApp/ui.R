library(shiny)
library(plotly)

# Define the UI for the application
ui <- fluidPage(
  
  # Application title
  titlePanel("Predicting mpg using Linear Regression with Sliders for Predictors"),
  tags$style(HTML("
    #prediction_output {
      margin-top: 107px;  /* Adjust the top margin */
    }
  ")),
  
  # Sidebar with inputs for each predictor control
  sidebarLayout(
    sidebarPanel(
      sliderInput("hp", 
                  label = "Adjust Horsepower (hp):", 
                  min = min(mtcars$hp), max = max(mtcars$hp), 
                  value = mean(mtcars$hp)),
      sliderInput("wt", 
                  label = "Adjust Weight (wt):", 
                  min = min(mtcars$wt), max = max(mtcars$wt), 
                  value = mean(mtcars$wt)),
      sliderInput("cyl", 
                  label = "Adjust Number of Cylinders (cyl):", 
                  min = min(mtcars$cyl), max = max(mtcars$cyl), 
                  value = mean(mtcars$cyl)),
      actionButton("update", "Update Prediction"),
      p("Use the sliders to adjust predictor values and click 'Update Prediction' to see the model results.")
    ),
    
    # Main panel for displaying outputs
    mainPanel(
      plotlyOutput("scatter_plot"),
    
      verbatimTextOutput("prediction_output")
    )
  )
)
