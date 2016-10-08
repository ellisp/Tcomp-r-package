

library(Tcomp)
library(Mcomp)
library(testthat)


expect_equal(length(tourism), 1311)

expect_equal(length(subset(tourism, "monthly")), 366)
expect_equal(length(subset(tourism, "quarterly")), 427)
expect_equal(length(subset(tourism, "yearly")), 518)
