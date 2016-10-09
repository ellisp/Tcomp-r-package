# tests object sizes and lengths

library(Tcomp)
library(Mcomp)
library(testthat)



#-------------test number of series---------------
expect_equal(length(tourism), 1311)
expect_equal(length(subset(tourism, "monthly")), 366)
expect_equal(length(subset(tourism, "quarterly")), 427)
expect_equal(length(subset(tourism, "yearly")), 518)

#----------test mean length versus in the Hyndman article----------
lengthsm <- sapply(subset(tourism, "monthly"), function(s){length(s$x)})
lengthsq <- sapply(subset(tourism, "quarterly"), function(s){length(s$x)})
lengthsy <- sapply(subset(tourism, "yearly"), function(s){length(s$x)})


# These tests all fail
expect_equal(mean(lengthsm), 298)
expect_equal(mean(lengthsq), 99)
expect_equal(mean(lengthsy), 24)

expect_equal(median(lengthsm), 330)
expect_equal(median(lengthsq), 1100)
expect_equal(median(lengthsy), 27)

expect_equal(min(lengthsm), 91)
expect_equal(min(lengthsq), 30)
expect_equal(min(lengthsy), 11)

expect_equal(max(lengthsm), 333)
expect_equal(max(lengthsq), 130)
expect_equal(max(lengthsy), 47)


#----------test the test period of each series is immediately after the training period------------

# Series Y18 (#811) fails this test as the final point of the training series is 2003, and
# the first point of the test series is also 2003! To let the package build, the starting date
# of Y18 has been manually changed to 2004 in /prep/groom.R; this seems the most likely
# problem.
test_cont <- function(series){
  # series <- tourism[[1041]] # for debugging and dev  
  x <- series$x
  xx <- series$xx
  expect_equal(
    max(time(x)) + 1 / frequency(x),
    min(time(xx))
  )
} 

lapply(tourism, test_cont)

# for loop below was for tracking exactly which series was wrong.
# for(i in 1:length(tourism)){
#   test_cont(tourism[[i]])
# }


#-----------test forecast horizon matches test set--------------
test_h <- function(series){
  expect_equal(length(series$xx), series$h)
}

lapply(tourism, test_h)

#--------------test forecast horizon matches the Hyndman article------
expect_equal(
  mean(sapply(subset(tourism, "monthly"), function(s){mean(s$h)})),
  24)

expect_equal(
  mean(sapply(subset(tourism, "quarterly"), function(s){mean(s$h)})),
  8)

expect_equal(
  mean(sapply(subset(tourism, "yearly"), function(s){mean(s$h)})),
  4)
