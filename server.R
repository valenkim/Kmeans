palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
          "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

shinyServer(function(input, output, session) {
  teens <- read.csv("snsdata.csv")
  teens$age <- ifelse(teens$age >= 13 & teens$age < 20, teens$age, NA)
  
  teens$female <- ifelse(teens$gender == "F" & !is.na(teens$gender), 1, 0)
  teens$no_gender <- ifelse(is.na(teens$gender), 1, 0)
  
  ave_age <- ave(teens$age, teens$gradyear, FUN = function(x) mean(x, na.rm = TRUE))
  
  teens$age <- ifelse(is.na(teens$age), ave_age, teens$age)
  interests <- teens[5:40]
  interests_z <- as.data.frame(lapply(interests, scale))
  
  # Combine the selected variables into a new data frame
  selectedData <- reactive({
    interests_z[, c(input$xcol, input$ycol)]
  })
  
  clusters <- reactive({
    kmeans(selectedData(), input$clusters)
  })
  
  output$plot1 <- renderPlot({
    par(mar = c(5.1, 4.1, 0, 1))
    plot(selectedData(),
         col = clusters()$cluster,
         pch = 20, cex = 3)
    points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
  })
  
})