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
            menuItem("Dashboard", tabName = "dashboard_tab")
            #menuItem("Combined 2D TEST", tabName = "combined2D_tab")
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
                   verticalLayout(fluidRow(
                       column(width=6,
                              sliderInput("bins",
                                          "Number of bins:",
                                          min = 1,
                                          max = 50,
                                          value = 30),
                                          align="center"),
                       column(width=6,
                              selectInput("histogram_attr", "Choose attribute:",
                                          c("ph" = "ph",
                                            "Hardness" = "Hardness",
                                            "Solids" = "Solids",
                                            "Chloramines" = "Chloramines",
                                            "Sulfate" = "Sulfate",
                                            "Conductivity" = "Conductivity",
                                            "Organic carbon" = "Organic_carbon",
                                            "Trihalomethanes" = "Trihalomethanes",
                                            "Turbidity" = "Turbidity"))
                    )),
                    plotOutput("attribute_histogram")
                )),
                column(width=4,
                       verticalLayout(fluidRow(
                           column(width=6,
                               selectInput("choice2D_1", "Choose x:",
                                      c("pH" = "ph",
                                        "Hardness" = "Hardness",
                                        "Solids" = "Solids",
                                        "Chloramines" = "Chloramines",
                                        "Sulfate" = "Sulfate",
                                        "Conductivity" = "Conductivity",
                                        "Organic carbon" = "Organic_carbon",
                                        "Trihalomethanes" = "Trihalomethanes",
                                        "Turbidity" = "Turbidity"))),
                            column(width=6,
                               selectInput("choice2D_2", "Choose y:",
                                      c("pH" = "ph",
                                        "Hardness" = "Hardness",
                                        "Solids" = "Solids",
                                        "Chloramines" = "Chloramines",
                                        "Sulfate" = "Sulfate",
                                        "Conductivity" = "Conductivity",
                                        "Organic carbon" = "Organic_carbon",
                                        "Trihalomethanes" = "Trihalomethanes",
                                        "Turbidity" = "Turbidity"))
                          )),
                          plotOutput("combined_plot"))
                       ),
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
            )
        )
    )
)