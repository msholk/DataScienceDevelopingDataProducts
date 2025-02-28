library(shiny)
library(plotly)

# Define the server logic
server <- function(input, output) {
  
  # Reactive expression to prepare data with selected predictor values
  selected_data <- reactive({
    # Create a new data frame based on the slider inputs for the predictors
    new_data <- mtcars
    new_data$hp <- rep(input$hp, nrow(new_data))
    new_data$wt <- rep(input$wt, nrow(new_data))
    new_data$cyl <- rep(input$cyl, nrow(new_data))
    new_data
  })
  
  # Linear model for prediction
  observeEvent(input$update, {
    # Prepare the formula for the linear model using all predictors
    lm_model <- lm(mpg ~ hp + wt + cyl, data = selected_data())
    
    # Predict mpg based on the selected predictors
    predictions <- predict(lm_model, selected_data())
    
    # Create the scatter plot with the actual data and predictions
    output$scatter_plot <- renderPlotly({
      plot_ly(selected_data(), 
              x = ~mpg, 
              y = predictions, 
              type = "scatter", 
              mode = "markers") %>%
        layout(title = "Actual vs Predicted mpg (Using hp, wt, and cyl as predictors)",
               xaxis = list(title = "Actual mpg"),
               yaxis = list(title = "Predicted mpg"),
               width = 800,  # Set the width of the plot
               height = 500  # Set the height of the plot
        )
    })

    
    
    # Display model summary and selected values in the output
    output$prediction_output <- renderText({
      # Create the output string with selected values and model summary
      text_output <- paste("Selected Predictor Values:\n",
                           "Horsepower (hp):", input$hp, "\n",
                           "Weight (wt):", input$wt, "\n",
                           "Number of Cylinders (cyl):", input$cyl, "\n\n",
                           "Linear Model Summary:\n")
      
     
      
      # Return the concatenated result
      text_output
    })
  })
}
