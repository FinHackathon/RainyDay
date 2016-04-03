# Install devtools, if you haven't already.
#install.packages("devtools")

library(devtools)
#install_github("trestletech/shinyTable")

library(shiny)
library(shinyTable)

server <- function(input, output, session) {
  
  rv <- reactiveValues(cachedTbl = NULL)
  
  
  # Reactive expression to compose a data frame containing all of
  # the values
  sliderValues <- reactive({
    
    # Compose data frame
    data.frame(
      Name = c("Integer", 
               "Decimal",
               "Range",
               "Custom Format",
               "Animation"),
      Value = as.character(c(input$integer, 
                             input$decimal,
                             paste(input$range, collapse=' '),
                             input$format,
                             input$animation)), 
      stringsAsFactors=FALSE)
  }) 
  
  # Show the values using an HTML table
  output$values <- renderTable({
    sliderValues()
  })
  
  
  output$tbl <- renderHtable({
    if (is.null(input$tbl)){
      
      #fill table with 0
      tbl <- matrix(0, nrow=3, ncol=3)
      
      rv$cachedTbl <<- tbl
      return(tbl)
    } else{
      rv$cachedTbl <<- input$tbl
      return(input$tbl)
    }
  })  
  
  output$tblNonEdit <- renderTable({
    
    #add dependence on button
    input$actionButtonID
    
    #isolate the cached table so it only responds when the button is pressed
    isolate({
      rv$cachedTbl
    })
  })    
}


ui <- shinyUI(
  navbarPage(
    title = 'DataTable Options',
    tabPanel('Display length',     DT::dataTableOutput('ex1')),
    tabPanel('Length menu',        DT::dataTableOutput('ex2')),
    tabPanel('No pagination',      DT::dataTableOutput('ex3')),
    tabPanel('No filtering',       DT::dataTableOutput('ex4')),
    tabPanel('Function callback',  DT::dataTableOutput('ex5'))
  ),
  
  pageWithSidebar(
  
  headerPanel("Budget Dashboard"),
  
  sidebarPanel(
    helpText(HTML("<p> Predictive analytics </p>")),
    
    # Simple integer interval
    sliderInput("integer", "Integer:", 
                min=0, max=1000, value=500),
    
    # Decimal interval with step value
    sliderInput("decimal", "Decimal:", 
                min = 0, max = 1, value = 0.5, step= 0.1),
    
    # Specification of range within an interval
    sliderInput("range", "Range:",
                min = 1, max = 1000, value = c(200,500)),
    
    # Provide a custom currency format for value display, 
    # with basic animation
    sliderInput("format", "Custom Format:", 
                min = 0, max = 10000, value = 0, step = 2500,
                format="$#,##0", locale="us", animate=TRUE),
    
    # Animation with custom interval (in ms) to control speed,
    # plus looping
    sliderInput("animation", "Looping Animation:", 1, 2000, 1,
                step = 10, animate=
                  animationOptions(interval=300, loop=TRUE))
    
    
  ),
  
  #  tabPanel('Display length',     DT::dataTableOutput('ex1')),
  #  tabPanel('Length menu',        DT::dataTableOutput('ex2'))
  
  # Show the simple table
  mainPanel(
    tableOutput("values"),
    #editable table
    htable("tbl"),
    #update button
    actionButton("actionButtonID","apply table edits"),
    #to show saved edits
    tableOutput("tblNonEdit")

  )
))

runApp(shinyApp(ui = ui, server = server),host="0.0.0.0",port=5050)
