library(stringr)
library(testthat)

# tourism should be a list with as many elements as total series in the competition.  Each element
# of the list should itself be a list with 6 elements resembling this, except no type, description or sn.
# The examples below are from Mcomp and form the model of the structure of each element of the tourism object.

#--------------download data----------------
monthly_in <- read.csv("source-data/monthly_in.csv", stringsAsFactors = FALSE, colClasses = "numeric")
quarterly_in <- read.csv("source-data/quarterly_in.csv", stringsAsFactors = FALSE, colClasses = "numeric")
yearly_in <- read.csv("source-data/yearly_in.csv", stringsAsFactors = FALSE, colClasses = "numeric", nrows = 50)
monthly_oos<- read.csv("source-data/monthly_oos.csv", stringsAsFactors = FALSE, colClasses = "numeric")
quarterly_oos<- read.csv("source-data/quarterly_oos.csv", stringsAsFactors = FALSE, colClasses = "numeric")
yearly_oos<- read.csv("source-data/yearly_oos.csv", stringsAsFactors = FALSE, colClasses = "numeric")

# Manual cleaning
#
# 1.
# something very odd about the yearly_in spreadsheet has extra numbers appearing in row 336 for some columns
# eg column 248, 249, etc.  Hence the limitation to just 50 rows.
#
# 2.
# there appears to be an extra point in series Y18.  See /pkg/tests/testthat/test-object-sizes.R.  
# Y18 goes up to 2003 in the "yearly_in" data, but 2003 is given as the starting point in "yearly_oos".
# To get around this I manually change the starting date of the oos set to 2004.
yearly_oos[2 ,18] <- 2004



#-------------set up objects----------------
number <- ncol(monthly_in) + ncol(quarterly_in) + ncol(yearly_in)
tourism <- list()
all_series <- c(names(monthly_in), names(quarterly_in), names(yearly_in))

all_series <- toupper(all_series)

#--------------monthly data----------------
for(i in 1:length(monthly_in)){
  datain <- monthly_in
  dataoos <- monthly_oos
  
  tourism[[i]] <- list()
  tourism[[i]]$st <- names(datain)[i]
  tourism[[i]]$period <- "MONTHLY"
  
  x <- datain[-(1:3) , i]
  x <- x[!is.na(x)]
  tourism[[i]]$x <- ts(x, start = c(datain[2, i], datain[3, i]), frequency = 12)
  
  xx <- dataoos[-(1:3) , i]
  xx <- xx[!is.na(xx)]
  tourism[[i]]$xx <- ts(xx, start = c(dataoos[2, i], dataoos[3, i]), frequency = 12)
  
  tourism[[i]]$h <- dataoos[1 , i]
  n <- datain[1, i]
  expect_equal(n, length(x))
  tourism[[i]]$n <- n
}

#--------------quarterly data----------------
for(j in 1:length(quarterly_in)){
  i <- i + 1
  datain <- quarterly_in
  dataoos <- quarterly_oos
  
  tourism[[i]] <- list()
  tourism[[i]]$st <- names(datain)[j]
  tourism[[i]]$period <- "QUARTERLY"
  
  x <- datain[-(1:3) , j]
  x <- x[!is.na(x)]
  tourism[[i]]$x <- ts(x, start = c(datain[2, j], datain[3, j]), frequency = 4)
  
  xx <- dataoos[-(1:3) , j]
  xx <- xx[!is.na(xx)]
  tourism[[i]]$xx <- ts(xx, start = c(dataoos[2, j], dataoos[3, j]), frequency = 4)
  
  tourism[[i]]$h <- dataoos[1 , j]
  n <- datain[1, j]
  expect_equal(n, length(x))
  tourism[[i]]$n <- n
}

#--------------annual data----------------
datain <- yearly_in
dataoos <- yearly_oos

for(j in 1:length(yearly_in)){
  i <- i + 1
  
  tourism[[i]] <- list()
  tourism[[i]]$st <- names(datain)[j]
  tourism[[i]]$period <- "YEARLY"
  
  x <- datain[-(1:2) , j]
  x <- x[!is.na(x)]
  tourism[[i]]$x <- ts(x, start = datain[2, j], frequency = 1)
  
  xx <- dataoos[-(1:2) , j]
  xx <- xx[!is.na(xx)]
  tourism[[i]]$xx <- ts(xx, start = dataoos[2, j], frequency = 1)
  
  tourism[[i]]$h <- dataoos[1 , j]
  n <- datain[1, j]
  expect_equal(n, length(x))
  tourism[[i]]$n <- n
}


#-----------give class, names etc-------------
class(tourism) <- "Mcomp"

for(i in 1:length(tourism)){
  class(tourism[[i]]) <- "Mdata"
  tourism[[i]]$sn <- all_series[i]
  tourism[[i]]$type <- "TOURISM"
  tourism[[i]]$description <- "No description available"
}

names(tourism) <- all_series

save(tourism, file = "pkg/data/tourism.rda", compress = "xz")
