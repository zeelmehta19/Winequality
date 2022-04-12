

# Import libraries
library(shiny)
library(data.table)
library(randomForest)

# Read in the RF model
model <- readRDS("modellgr.rds")


####################################
# User interface                   #
####################################

ui <- pageWithSidebar(
  
  # Page header
  headerPanel('Wine Quality Prediction'),
  
  # Input values
  sidebarPanel(
    #HTML("<h3>Input parameters</h3>"),
    tags$label(h3('Insert your data for prediction :)')),
    numericInput("type", 
                 label = "Enetr 1 for red and 0 fir white ", 
                 value = 1),
    numericInput("residual_sugar", 
                 label = "Residual sugar ( Enter in range 0-50 ) ", 
                 value = 8),
    numericInput("free_sulfur_dioxide", 
                 label = "free sulfur dioxide ( Enter in range 0-100 ) ", 
                 value = 45),
    numericInput("total_sulfur_dioxide", 
                 label = "total sufur dioxide ( Enter in range 0-500 ) ", 
                 value = 150),
    numericInput("sulphates", 
                 label = "sulphates ( Enter in range 0-1 ) ", 
                 value = 0.5),
    numericInput("fixed_acidity", 
                 label = "fixed acidity ( Enter in range 0-10 ) ", 
                 value = 7),
    numericInput("volatile_acidity", 
                 label = "volatile acidity( Enter in range 0-1 )", 
                 value = 0.5),
    numericInput("citric_acid", 
                 label = "citric acid ( Enter in range 0-1 )", 
                 value = 0.5),
    numericInput("chlorides", 
                 label = "chlorides ( Enter in range 0.00-0.10 )", 
                 value = 0.05),
    numericInput("density", 
                 label = "density ( Enter in range 0-1.5 )", 
                 value = 1.0),
    numericInput("pH", 
                 label = "pH ( Enter in range 0-14 )", 
                 value = 3),
    numericInput("alcohol", 
                 label = "alcohol ( Enter 1-20  )", 
                 value = 10),
    
    actionButton("submitbutton", "Submit", 
                 class = "btn btn-primary")
  ),
  
  mainPanel(
    tags$label(h3('Status/Output')), # Status/Output Text Box
    verbatimTextOutput('contents'),
    tableOutput('tabledata') # Prediction results table
    
  )
)

####################################
# Server                           #
####################################

server<- function(input, output, session) {
  # Input Data
  datasetInput <- reactive({  
    
    print(input$pH)
    print(input$alcohol)
    PREDICTION = ''
    fixed_acidity = c(input$fixed_acidity)
    volatile_acidity = c(input$volatile_acidity)
    citric_acid = c(input$citric_acid)
    chlorides = c(input$chlorides)
    density = c(input$density)
    pH = c(input$pH)
    alcohol = c(input$alcohol)
    type = c(input$type)
    residual_sugar = c(input$residual_sugar)
    free_sulfur_dioxide = c(input$free_sulfur_dioxide)
    total_sulfur_dioxide = c(input$total_sulfur_dioxide)
    sulphates = c(input$sulphates)
    
    datas = data.frame(type, fixed_acidity,volatile_acidity,citric_acid, residual_sugar, chlorides, free_sulfur_dioxide, total_sulfur_dioxide,density, pH, sulphates, alcohol)
    
    model <- readRDS("modellgr.rds")
    result = predict(model,datas)
    PREDICTION = paste('Your wine quality is ',format(round(result, 2), nsmall = 2))
    
    Output <- data.frame(PREDICTION)
    
  })
   # Status/Output Text Box
  output$contents <- renderPrint({
    if (input$submitbutton>0) { 
      isolate("Calculation complete.") 
    } else {
      return("Server is ready for calculation.")
    }
  })
  # Prediction results table
  output$tabledata <- renderTable({
    if (input$submitbutton>0) { 
      isolate(datasetInput()) 
    } 
  })
}

# Create the shiny app             #
shinyApp(ui = ui, server = server)
