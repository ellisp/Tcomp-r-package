library(devtools)
library(roxygen2)

source("prep/groom.R")

document("pkg")
check("pkg")
