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
        )
     ),

    dashboardBody(
        tabItems(
            tabItem(
                tabName = "home_tab",
                column(width = 5,
                  h1("Explain what each attribute means"),
                  p("1. pH value - how acidic or basic the water is (7 is neutral, torwards 0 is more acidic, torwards 14 is more basic)."),
                  p("2. Hardness - the capacity of water to precipitate soap in mg/L"),
                  p("3. Solids - total dissolved solids in ppm"),
                  p("4. Chloramines - the amount of Chloramines in ppm "),
                  p("5. Sulfate - the amount of Sulfates dissolved in mg/L"),
                  p("6. Conductivity - the electrical conductivity of water in μS/cm."),
                  p("7. Organic_carbon - the amount of organic carbon in ppm."),
                  p("8. Trihalomethanes - the amount of Trihalomethanes in μg/L"),
                  p("9. Turbidity - Measure of light emiting property of water in NTU (nephelometric turbidity units)."),
                  p("10. Potability - indicates if water is safe for human consumption (1 means potable, 0 means not potable).")),
                column(width = 4,
                  plotOutput("potability_bar"))
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
                       verticalLayout(fluidRow(
                           column(width=12, align="center",
                                  selectInput("violin_choice", "Choose attribute:",
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
                           plotOutput("violin_plot")
                     ))
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