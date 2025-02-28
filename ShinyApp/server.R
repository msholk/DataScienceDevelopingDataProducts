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
    
    # 3D Scatter Plot of mtcars data with prediction ball
    output$scatter_plot <- renderPlotly({
      # Create the linear model based on user-selected inputs
      lm_model <- lm(mpg ~ hp + wt + cyl, data = mtcars)
      predicted_mpg <- predict(lm_model, newdata = data.frame(hp = input$hp, wt = input$wt, cyl = input$cyl))
      
      # Plot the 3D scatter plot
      plot_ly(mtcars, x = ~mpg, y = ~hp, z = ~wt, color = ~factor(cyl), 
              type = "scatter3d", mode = "markers") %>%
        add_trace(
          x = predicted_mpg, y = input$hp, z = input$wt, 
          type = "scatter3d", mode = "markers", 
          marker = list(color = 'red', size = 10, symbol = 'circle')
        ) %>%
        layout(title = "3D Scatter Plot of mtcars Data Colored by Cylinders",
               scene = list(xaxis = list(title = "Miles per Gallon (mpg)"),
                            yaxis = list(title = "Horsepower (hp)"),
                            zaxis = list(title = "Weight (wt)")),
               coloraxis = list(colorbar = list(title = "Number of Cylinders")),
               width = 800,  # Set the width of the plot
               height = 500  # Set the height of the plot
        )
    })
    

    
    
    # Display model summary and selected values in the output
    output$prediction_output <- renderText({
      lm_model <- lm(mpg ~ hp + wt + cyl, data = mtcars)
      predicted_mpg <- predict(lm_model, newdata = data.frame(hp = input$hp, wt = input$wt, cyl = input$cyl))
      
      # Create the output string with selected values and model summary
      text_output <- paste("Selected Predictor Values:\n",
                           "Horsepower (hp):", input$hp, "\n",
                           "Weight (wt):", input$wt, "\n",
                           "Number of Cylinders (cyl):", input$cyl, "\n\n",
                           "Predicted MPG:", round(predicted_mpg,1), "\n\n"
      )
      
     
      
      # Return the concatenated result
      text_output
    })
  })
}
