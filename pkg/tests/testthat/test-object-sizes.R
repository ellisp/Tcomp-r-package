

library(Tcomp)
library(Mcomp)
library(testthat)



#-------------test lengths---------------
expect_equal(length(tourism), 1311)
expect_equal(length(subset(tourism, "monthly")), 366)
expect_equal(length(subset(tourism, "quarterly")), 427)
expect_equal(length(subset(tourism, "yearly")), 518)


#----------test the test period of each series is immediately after the training period------------

# Series Y18 (#811) and Y248 (#1041) fail this test as the final point of the training series is 2003, and
# the first point of the test series is also 2003!
test_cont <- function(series){
  # series <- tourism[[1041]] # for debugging and dev  
  x <- series$x
  xx <- series$xx
  expect_equal(
    max(time(x)) + 1 / frequency(x),
    min(time(xx))
  )
} 


for(i in 1:length(tourism)){
  test_cont(tourism[[i]])
}


