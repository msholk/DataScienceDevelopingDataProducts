library(shiny)
library(plotly)

# Define the UI for the application
ui <- fluidPage(
  
  # Application title
  titlePanel("Predicting mpg using Linear Regression with Sliders for Predictors"),
  # Add instructional text
  p("Welcome to the mpg prediction app! 
    This application helps you predict the miles per gallon (mpg) 
    of a car based on its horsepower (hp), weight (wt), and number of cylinders (cyl). 
    You can adjust these values using the sliders below to see how changes in these predictors 
    affect the mpg prediction."),

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
    
      verbatimTextOutput("prediction_output"),
      # Instructions section at the bottom
      p("How to Use This Application:"),
      p("1. Adjust the 'Horsepower (hp)', 'Weight (wt)', and 'Number of Cylinders (cyl)' sliders to modify the values of the predictors."),
      p("2. After adjusting the sliders, click the 'Update Prediction' button to see how the model predicts the mpg for the given input values."),
      p("3. The scatter plot will update dynamically to reflect the changes in the data, and the predicted mpg will be shown below the plot.")
      
    )
  )
)
