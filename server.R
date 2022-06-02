library(shiny)
library(shinydashboard)
library(ggplot2)
library(ggthemes)

label_size = 12
axis_title_size = 12
legend_item_size = 12
legend_title_size = 13
title_size = 20
theme_set(theme_minimal())
theme_update(
    axis.text=element_text(size=label_size),
    axis.title=element_text(size=axis_title_size),
    legend.title=element_text(size=legend_title_size),
    legend.text=element_text(size=legend_item_size),
    plot.title = element_text(face="bold", size=title_size, hjust=0)
)

column_histogram = function(col_data, length_var, name) {
    bins = seq(min(col_data), max(col_data), length.out = length_var + 1)
    p = ggplot(data.frame(col_data), aes(x=col_data)) + 
        geom_histogram(breaks=bins, color="darkblue", fill="lightblue") +
        theme(
            axis.text.x = element_blank(),
            axis.text.y = element_blank(), 
            axis.ticks.x = element_blank(), 
            axis.ticks.y = element_blank()) +
        labs(title=name, x="", y="")
    return(p)
    #return(hist(col_data, breaks = bins, main = name, xlab="", ylab="", axes=F, col="lightblue", border="darkblue"))
}


water = na.omit(read.csv("./data/water_potability.csv", sep=','))
# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$ph_hist = renderPlot({
        column_histogram(water$ph, input$bins, "pH")
    })

    output$hardness_hist = renderPlot({
        column_histogram(water$Hardness, input$bins, "Hardness")
    })
    
    output$solids_hist = renderPlot({
        column_histogram(water$Solids, input$bins, "Solids")
        
    })
    
    output$chloramines_hist = renderPlot({
        column_histogram(water$Chloramines, input$bins, "Chloramines")
        
    })
    output$sulfate_hist = renderPlot({
        column_histogram(water$Sulfate, input$bins, "Sulfate")
        
    })
    output$conductivity_hist = renderPlot({
        column_histogram(water$Conductivity, input$bins, "Conductivity")
    })
    output$organic_carbon_hist = renderPlot({
        column_histogram(water$Organic_carbon, input$bins, "Organic carbon")
    })
    output$trihalomethanes_hist = renderPlot({
        column_histogram(water$Trihalomethanes, input$bins, "Trihalomethanes")
    })
    output$turbidity_hist = renderPlot({
        column_histogram(water$Turbidity, input$bins, "Turbidity")
        
    })
})
