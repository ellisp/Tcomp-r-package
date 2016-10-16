library(devtools)
library(roxygen2)
library(knitr)

source("prep/groom.R")

document("pkg")
test("pkg")
;# note - passsing tests depends on truncating the mean length of
#        the groups of series.  Confirmed by hand check in Excel.

check("pkg")

knit2html("README.Rmd")

build_vignettes("pkg")
build("pkg")
install("pkg", build_vignettes = TRUE)

# devtools::install_github("ellisp/Tcomp-r-package/pkg")
# browseVignettes("Tcomp")
