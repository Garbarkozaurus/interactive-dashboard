library(shiny)
library(shinydashboard)
library(ggplot2)
library(flexdashboard)


dashboardPage(
    dashboardHeader(title="Water potability"),
    dashboardSidebar(
        tags$a(tags$img(src="PP_logotyp_ANG_RGB.png", height="100%", width="100%")),
        sidebarMenu(
            menuItem("Home", tabName = "home_tab", icon=icon("home")),
            menuItem("Dashboard", tabName = "dashboard_tab", icon = icon("tachometer-alt"))
        )
     ),

    dashboardBody(
        tabItems(
            tabItem(
                tabName = "home_tab",
                fluidRow(column(width = 5,
                  h1("Explaining the attributes"),
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
                  plotOutput("potability_bar"))),
                fluidRow(
                    column(width=12, align="center", verticalLayout(
                        h1("Things to try out in the dashboard:"),
                        column(width=12, align="left",
                               HTML("<p>Check out the distribution of attributes using the <b><u>histogram</u></b> - select the attribute you want to examine and adjust the number of bins",
                               "<p>See if there are any dependencies between attributes with the <b><u>scatter plot</u></b>",
                               "<p>Use the <b><u>violin plot</u></b> to see how the values of an atttribute are distributed when the examples are separated by potability",
                               "<p>Explore the dataset with the <b><u>interactive table</u></b>:<br>",
                               "    - see what proportions of each potability value your filters and selections cover using the bar chart to the left",
                               "    - select rows to see them highlighted on the scatter plot above<br>",
                               "    - apply filters and see how many records satisfying the conditions are potable on the gauge to the right<br>")
                        )
                    )

                    )
                )
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
                          h1(""),
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
                           h1(""),
                           plotOutput("violin_plot")
                     ))
            ),

            fluidRow(
                column(width=2,
                       tabsetPanel(
                            tabPanel("Filtered in all", plotOutput("filter_bar")),
                            tabPanel("Selected in filtered", plotOutput("selection_bar"))
                       )),
                column(width=8,
                      DT::dataTableOutput("everything_table")),
                column(width=2,
                       h3("Potable samples based on table filter"),
                       gaugeOutput("filtered_gauge"))
            )
            #tabItem end
            )
        )
    )
)