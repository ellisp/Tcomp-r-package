library(devtools)
library(roxygen2)
library(knitr)

source("prep/groom.R")

document("pkg")
check("pkg")

knit2html("README.Rmd")

