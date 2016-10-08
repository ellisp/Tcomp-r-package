library(devtools)
library(roxygen2)
library(knitr)

source("prep/groom.R")

document("pkg")
check("pkg")

source("pkg/tests/testthat.R")

knit2html("README.Rmd")

