library(shiny)
library(shinydashboard)
library(ggplot2)
library(ggthemes)
library(flexdashboard)
library(DT)

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

combined_plot = function(x_name, y_name) {
  p = ggplot(water, aes(x = get(x_name), y = get(y_name), color = factor(Potability))) +
      geom_point() +
      labs(title = paste(x_name, "against", y_name, sep=" ")) +
      xlab(x_name) + ylab(y_name)
  return(p)
}

violin = function(data) {
  p = ggplot(water, aes(x = get(data), y = Potability, fill = Potability)) +
      geom_violin() +
      labs(title = paste("Distribution of", data, "with respect to potability", sep=" "), ylab = "Potability") +
      xlab(data) + coord_flip()
  return(p)
}

column_histogram = function(col_name, length_var) {
    col_data = get(col_name, water)
    bins = seq(min(col_data), max(col_data), length.out = length_var + 1)
    p = ggplot(data.frame(col_data), aes(x=col_data)) +
        geom_histogram(breaks=bins, color="darkblue", fill="lightblue") +
        theme(
            axis.text.x = element_blank(),
            axis.text.y = element_blank(),
            axis.ticks.x = element_blank(),
            axis.ticks.y = element_blank()) +
        labs(title=col_name, x="", y="")
    return(p)
    #return(hist(col_data, breaks = bins, main = name, xlab="", ylab="", axes=F, col="lightblue", border="darkblue"))
}

pretty_table = function(table_df, round_columns_func=is.numeric, significant_digits=4)
{
    DT::datatable(table_df, style="bootstrap", filter = "top", rownames = FALSE,
                  options = list(dom = 'Bfrtip', scrollX=T)) %>%
        formatSignif(unlist(lapply(table_df, round_columns_func)), significant_digits, mark='')
}

water = na.omit(read.csv("./data/water_potability.csv", sep=','))
water$Potability = as.factor(water$Potability)


shinyServer(function(input, output) {
    output$attribute_histogram = renderPlot({
        column_histogram(input$histogram_attr, input$bins)
    })

    output$gauge = renderGauge({
        gauge(round(mean(water$Potability), 2),
              min = 0,
              max = 1,
              sectors = gaugeSectors(success = c(0.5, 1),
                                     warning = c(0.3, 0.5),
                                     danger = c(0, 0.3)))
    })

    output$everything_table = DT::renderDataTable(pretty_table(water))

    output$combined_plot = renderPlot({
      combined_plot(input$choice2D_1, input$choice2D_2)
    })

    output$violin_plot = renderPlot({
      violin(input$violin_choice)
    })

})
