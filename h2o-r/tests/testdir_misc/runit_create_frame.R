setwd(normalizePath(dirname(R.utils::commandArgs(asValues=TRUE)$"f")))
source('../h2o-runit.R')

test.createFrame <- function(conn) {
  seed <- sample(.Machine$integer.max, 1)
  Log.info(paste("Create a data frame with rows = 1000, cols = 20, randomize = TRUE, seed =", seed))
  hex <- h2o.createFrame(conn, rows = 1000, cols = 20, categorical_fraction = 0.1, factors = 5, integer_fraction = 0.5, integer_range = 1, seed = seed)
  expect_equal(dim(hex), c(1000, 20))
  expect_equal(length(colnames(hex)), 20)
  
  Log.info("Check that 0.1 * 20 = 2 columns are categorical")
  fac_col <- sapply(1:20, function(i) is.factor(hex[,i]))
  num_fac <- sum(fac_col)
  expect_equal(num_fac/20, 0.1)
  
  Log.info("Create a data frame with rows = 1000, cols = 20, randomize = FALSE, value = 5")
  hex2 <- h2o.createFrame(conn, rows = 1000, cols = 20, randomize = FALSE, value = 5, categorical_fraction = 0, integer_fraction = 0, missing_fraction = 0, has_response = TRUE)
  expect_equal(dim(hex2), c(1000, 21))
  expect_equal(length(colnames(hex2)), 21)
  
  Log.info("Check that all data entries are equal to 5 (including response)")
  cons_col <- sapply(1:21, function(i) { min(hex2[,i]) == 5 && max(hex2[,i]) == 5 })
  expect_true(all(cons_col))
  
  testEnd()
}

doTest("Create a random data frame in H2O", test.createFrame)
