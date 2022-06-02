library(shiny)
library(shinydashboard)
library(ggplot2)


dashboardPage(
    dashboardHeader(title="This is the header"),
    
    
    dashboardSidebar(
        # find a good place to put this
        tags$a(tags$img(src="PP_logotyp_ANG_RGB.png", height="100%", width="100%")),
        sidebarMenu(
            menuItem("Home", tabName = "home_tab", icon=icon("home")),
            menuItem("Histograms", tabName = "histograms_tab"),
            menuItem("Handling missing values", tabName = "missing_values_tab")
        )
     ),
    
    dashboardBody(
        tabItems(
            tabItem(
                tabName = "home_tab",
                h1("Explain what each attribute means"),
                p("Add some generic info about the dataset"),
                p("And maybe a very basic visualisation?")
            ),
            tabItem(tabName = "histograms_tab",
            verticalLayout(
                # hack to have the slider centered
                column(width=12,
                       sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30),
                        align="center"),
                
                fluidRow(column(width=4, plotOutput("ph_hist")), 
                         column(width=4, plotOutput("hardness_hist")), 
                         column(width=4, plotOutput("solids_hist"))),
                
                fluidRow(column(width=4, plotOutput("chloramines_hist")),
                         column(width=4, plotOutput("sulfate_hist")),
                         column(width=4, plotOutput("conductivity_hist"))),
                
                fluidRow(column(width=4, plotOutput("organic_carbon_hist")),
                         column(width=4, plotOutput("trihalomethanes_hist")),
                         column(width=4, plotOutput("turbidity_hist")))
            )
            ),
            tabItem(tabName = "missing_values_tab",
                    h1("Add options for handling missing values and summarising 
                       the results"))
        )
    )
    
)
