library(shiny)
library(shinydashboard)
library(ggplot2)
library(flexdashboard)


dashboardPage(
    dashboardHeader(title="This is the header"),
    
    
    dashboardSidebar(
        # find a good place to put this
        tags$a(tags$img(src="PP_logotyp_ANG_RGB.png", height="100%", width="100%")),
        sidebarMenu(
            menuItem("Home", tabName = "home_tab", icon=icon("home")),
            menuItem("Dashboard", tabName = "dashboard_tab"),
            menuItem("Combined 2D", tabName = "combined2D_tab"),
            menuItem("Violin plots", tabName = "violin_tab")
        )
     ),
    
    dashboardBody(
        tabItems(
            tabItem(
                tabName = "home_tab",
                h1("Explain what each attribute means"),
                p("Add some generic info about the dataset"),
                p("And maybe a very basic visualisation?"),
                p("Fraction of potable sources in the sample"),
                gaugeOutput("gauge")
            ),
            tabItem(tabName = "dashboard_tab",
            fluidRow(
                column(width=4,
                
                   verticalLayout(
                       # hack to have the slider centered
                       column(width=12,
                              sliderInput("bins",
                                          "Number of bins:",
                                          min = 1,
                                          max = 50,
                                          value = 30),
                                          align="center"),
                    navlistPanel(
                        tabPanel("pH", plotOutput("ph_hist")),
                        tabPanel("Hardness", plotOutput("hardness_hist")),
                        tabPanel("Solids", plotOutput("solids_hist")),
                        tabPanel("Chloramines", plotOutput("chloramines_hist")),
                        tabPanel("Sulfate", plotOutput("sulfate_hist")),
                        tabPanel("Conductivity", plotOutput("conductivity_hist")),
                        tabPanel("Organic carbon", plotOutput("organic_carbon_hist")),
                        tabPanel("Trihalomethanes", plotOutput("trihalomethanes_hist")),
                        tabPanel("Turbidity", plotOutput("turbidity_hist"))
                    )
                )
                ),
                column(width=4, 
                       h1("#TODO")),
                column(width=4, 
                       h1("#TODO"))
            ),
            
            fluidRow(
                column(width=3, 
                       h1("#TODO")),
                column(width=6, 
                      DT::dataTableOutput("everything_table")),
                column(width=3, 
                       h1("#TODO"))
            )
            #tabItem end
            ),
            tabItem(tabName = "combined2D_tab",
                    h1("Use the list to choose two attributes to compare!"),
                    column(width = 4,
                     selectInput("choice2D_1", "Choose x:",
                                 c("pH" = "ph",
                                   "Hardness" = "Hardness",
                                   "Solids" = "Solids",
                                   "Chloramines" = "Chloramines",
                                   "Sulfate" = "Sulfate",
                                   "Conductivity" = "Conductivity",
                                   "Organic carbon" = "Organic_carbon",
                                   "Trihalomethanes" = "Trihalomethanes",
                                   "Turbidity" = "Turbidity")),
                      selectInput("choice2D_2", "Choose y:",
                                  c("pH" = "ph",
                                    "Hardness" = "Hardness",
                                    "Solids" = "Solids",
                                    "Chloramines" = "Chloramines",
                                    "Sulfate" = "Sulfate",
                                    "Conductivity" = "Conductivity",
                                    "Organic carbon" = "Organic_carbon",
                                    "Trihalomethanes" = "Trihalomethanes",
                                    "Turbidity" = "Turbidity"))),
                    column(width = 10,
                      plotOutput("combined_plot"))
            #tabItem end
            ),
            tabItem(tabName = "violin_tab",
                    h1("Use the list to choose an attribute to see the violin plots for!"),
                    column(width = 4,
                           selectInput("violin_choice", "Choose attribute:",
                                       c("pH" = "ph",
                                         "Hardness" = "Hardness",
                                         "Solids" = "Solids",
                                         "Chloramines" = "Chloramines",
                                         "Sulfate" = "Sulfate",
                                         "Conductivity" = "Conductivity",
                                         "Organic carbon" = "Organic_carbon",
                                         "Trihalomethanes" = "Trihalomethanes",
                                         "Turbidity" = "Turbidity"))),
                    column(width = 10,
                           plotOutput("violin_plot"))
                    #tabItem end
            )
        )
    )
    
)
