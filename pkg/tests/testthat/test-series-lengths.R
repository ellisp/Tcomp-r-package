library(Tcomp)
library(Mcomp)

#----------test series length versus in the Hyndman article----------
lengthsm <- sapply(subset(tourism, "monthly"), function(s){length(s$x)})
lengthsq <- sapply(subset(tourism, "quarterly"), function(s){length(s$x)})
lengthsy <- sapply(subset(tourism, "yearly"), function(s){length(s$x)})


# These tests all fail
expect_equal(mean(lengthsm), 298)
expect_equal(mean(lengthsq), 99)
expect_equal(mean(lengthsy), 24)

expect_equal(median(lengthsm), 330)
expect_equal(median(lengthsq), 110)
expect_equal(median(lengthsy), 27)

expect_equal(min(lengthsm), 91)
expect_equal(min(lengthsq), 30)
expect_equal(min(lengthsy), 11)

expect_equal(max(lengthsm), 333)
expect_equal(max(lengthsq), 130)
expect_equal(max(lengthsy), 47)

