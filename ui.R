shinyUI(pageWithSidebar(
  headerPanel('SNSDATA k-means clustering'),
  sidebarPanel(
    selectInput('xcol', 'X Variable', names(interests_z)),
    selectInput('ycol', 'Y Variable', names(interests_z),
                selected=names(interests_z)[[2]]),
    numericInput('clusters', 'Cluster count', 3,
                 min = 1, max = 15)
  ),
  mainPanel(
    plotOutput('plot1')
  )
))