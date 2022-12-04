# Tutorial to make a map tool in R Shiny: https://medium.com/@joyplumeri/how-to-make-interactive-maps-in-r-shiny-brief-tutorial-c2e1ef0447da

library(shiny)
library(shinythemes)
library(leaflet)
library(dplyr)
library(leaflet.extras)
library(rsconnect)

# Define user interface

# Shiny uses fluidPage to create a display that automatically adjusts to the dimensions 
# of your user’s browser window. 

# To add a widget to your app, place a widget function in sidebarPanel or mainPanel 
# in your ui object.Each widget function requires several arguments. 

# The first two arguments for each widget are 
# 1) a name for the widget: The user will not see this name, but you can use it to access 
# the widget’s value. The name should be a character string.
# 2) a label: This label will appear with the widget in your app. It should be a character string, 
# but it can be an empty string "".

# Valid Shiny themes are: cerulean, cosmo, cyborg, darkly, flatly, journal, lumen, paper, 
# readable, sandstone, simplex, slate, spacelab, superhero, united, yeti

ui <- fluidPage(
  theme = shinytheme("cosmo"),
  titlePanel(
    tags$div(class = "jumbotron text-center", style = "margin-bottom:0px;margin-top:0px",
             tags$h2(class = 'jumbotron-heading', style = 'margin-bottom:0px;margin-top:0px', 'Weather Prediction Tool'),
             p('Created by Neha Bhatia, Ananda Badari, Yeojin Chang, Sabrina Edwards-Swart, and Jiahong Zhang')
    )),
  sidebarPanel(
    h3("How to Use This Tool"),
    p("This tool shows the predicted temperature (in degrees Celsius) and precipitation (in cm) for regions in the United States of America during December 2018. Input a date between December 02, 2018 and December 31, 2018, as well as an hour between 0 and 23 to see the predicted temperatures. Predicted precipitation can be toggled by clicking the 'precipitation' checkbox in the top left corner of the map. Hovering your mouse over a circle on the map will show the exact predicted temperature or precipitation for that area."),
    br(),
    dateInput("date", label = h3("Date input"), value = "2018-12-02"),
    numericInput("hour", label = h3("Hour input"), value = 0),),
  
  mainPanel(leafletOutput(outputId = "mymap"),
            #this allows me to put the check marks on top of the map to allow people to view earthquake depth or overlay a heatmap
            absolutePanel(top = 60, left = 20,
                          checkboxInput("precip", "Precipitation", FALSE)
            ))

)

# Define server logic

# Load data
precip <- read.csv("data/precipitation.csv")
temp <- read.csv("data/temperature.csv")

server <- function(input, output) {
  # Subset temperature by user input 
  temp_subset <- reactive({
    a <- subset(temp,  (hour == input$hour & day == format(input$date[1])))
    return(a)
  })
  # Subset precipitation by user input
  precip_subset <- reactive({
    b <- subset(precip,  (hour == input$hour & day == format(input$date[1])))
    return(b)
  })

  

  # #define the color palette for the temperature
  pal <- colorNumeric(
    palette = c('gold', 'orange', 'red', 'dark red'),
    domain = temp$resnet)
  # 
  # #define the color of for the precipitation 
  pal2 <- colorFactor(
    palette = c('white', 'blue'),
    domain = precip$resnet
  )

  #create the map
  
  
  output$mymap <- renderLeaflet({
    leaflet(temp_subset()) %>%
      setView(lng = -99, lat = 45, zoom = 3)  %>% #setting the view over ~ center of North America
      addTiles() %>%
      addCircles(data = temp_subset(), lat = ~ lat, lng = ~ lon, weight = 10, radius = 50, popup = ~as.character(temp_subset()), label = ~as.character(paste0("Temperature (Celsius): ", sep = " ", resnet)), color = ~pal(resnet), fillOpacity = 0.5)
  })
  
  observe({
    proxy <- leafletProxy("mymap", data = precip_subset())
    proxy %>% clearMarkers()
    if (input$precip) {
      proxy %>% addCircleMarkers(stroke = FALSE, color = ~pal2(resnet), fillOpacity = 0.5,      label = ~as.character(paste0("Precipitation (cm): ", sep = " ", resnet)))}
    else {
      proxy %>% clearMarkers() %>% clearControls()
    }
  })

    
    
}

# Run the app

shinyApp(ui = ui, server = server)
  