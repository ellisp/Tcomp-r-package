library(Mcomp)

# tourism should be a list with as many elements as total series in the competition.  Each element
# of the list should itself be a list with 7 elements resembling this, except no type or description.
# The examples below are from Mcomp and form the model.
# 
# > str(M3$N0001)
# List of 9
# $ st         : chr "Y1"
# $ type       : chr "MICRO"
# $ period     : chr "YEARLY"
# $ description: chr "SALES ( CODE= ABT)"
# $ sn         : chr "N0001"
# $ x          : Time-Series [1:14] from 1975 to 1988: 941 1085 1245 1445 1683 ...
# $ xx         : Time-Series [1:6] from 1989 to 1994: 5380 6159 6877 7852 8408 ...
# $ h          : num 6
# $ n          : int 14
# - attr(*, "class")= chr "Mdata"

# > str(M3$N1122)
# List of 9
# $ st         : chr "Q477"
# $ type       : chr "MACRO"
# $ period     : chr "QUARTERLY"
# $ description: chr "CANADA-GDP by cost structure"
# $ sn         : chr "N1122"
# $ x          : Time-Series [1:44] from 1980 to 1991: 2701 2664 2673 2871 3421 ...
# $ xx         : Time-Series [1:8] from 1991 to 1993: 7849 8134 8171 8460 8273 ...
# $ h          : num 8
# $ n          : int 44
# - attr(*, "class")= chr "Mdata"


#--------------download data----------------
monthly_in <- read.csv("source-data/monthly_in.csv", stringsAsFactors = FALSE, colClasses = "numeric")
quarterly_in <- read.csv("source-data/quarterly_in.csv", stringsAsFactors = FALSE, colClasses = "numeric")
yearly_in <- read.csv("source-data/yearly_in.csv", stringsAsFactors = FALSE, colClasses = "numeric")
monthly_oos<- read.csv("source-data/monthly_oos.csv", stringsAsFactors = FALSE, colClasses = "numeric")
quarterly_oos<- read.csv("source-data/quarterly_oos.csv", stringsAsFactors = FALSE, colClasses = "numeric")
yearly_oos<- read.csv("source-data/yearly_oos.csv", stringsAsFactors = FALSE, colClasses = "numeric")


#-------------set up objects----------------
number <- ncol(monthly_in) + ncol(quarterly_in) + ncol(yearly_in)
tourism <- list()
all_series <- c(names(monthly_in), names(quarterly_in), names(yearly_in))


#--------------monthly data----------------
for(i in 1:length(monthly_in)){
  tourism[[i]] <- list()
  tourism[[i]]$st <- names(monthly_in)[i]
  tourism[[i]]$period <- "MONTHLY"
  
  x <- monthly_in[-(1:3) , i]
  x <- x[!is.na(x)]
  tourism[[i]]$x <- ts(x, start = c(monthly_in[2, i], monthly_in[3, i]), frequency = 12)
  
  xx <- monthly_oos[-(1:3) , i]
  xx <- xx[!is.na(xx)]
  tourism[[i]]$xx <- ts(xx, start = c(monthly_oos[2, i], monthly_oos[3, i]), frequency = 12)
  
  tourism[[i]]$h <- monthly_oos[1 , i]
  tourism[[i]]$n <- monthly_in[i, 1]
}

