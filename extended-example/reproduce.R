library(Tcomp)
library(dplyr)
library(tidyr)
library(parallel)

# this function runs the four standard models in forecast_comp, which is part of the package proper,
# on a large chunk of the competition series from either Mcomp or Tcomp.  The aim is to help
# comparisons with Athanasopoulos et al.  I'll probably leave this out of the package proper
# because it's not really a good idea to add dependencies to unnecessary things like
# parallel, dplyr, tidyr, etc., so will keep this as an example of how it can be used.
# The use of makePSOCKcluster and parLapply speeds up the analysis nearly four fold on my laptop
# eg running the test on all the yearly tourism series takes 12 seconds rather than 44 seconds.


#' @param dataobj a list of class Mcomp such as M3 or tourism
#' @param cond1 a condition for subsetting dataobj eg "yearly"
#' @param tests a list of different horizons at which to return the MASE for four different models
accuracy_measures <- function(dataobj, cond1, tests){
  cores <- detectCores()
  
  cluster <- makePSOCKcluster(max(1, cores - 1))
  
  clusterEvalQ(cluster, {
    library(Tcomp)
    library(Mcomp) # for subset.Mdata
    library(forecast)
  })
  
  results <- parLapply(cluster,
                       subset(dataobj, cond1), 
                       forecast_comp, 
                       tests = tests)
  
  extr <- function(x){
    rbind(x[[1]])
  }
  results_ <- do.call(extr, results)
  
  tmp <- as.data.frame(results_mat) %>%
    mutate(method = rownames(results_mat)) %>%
    gather(horizon, mase, -method) %>%
    group_by(method, horizon) %>%
    summarise(mase = round(mean(mase), 2)) %>%
    ungroup() %>%
    mutate(horizon = factor(horizon, levels = colnames(results[[1]]))) %>%
    spread(horizon, mase) %>%
    as.data.frame()

  stopCluster(cluster)
  
  return(tmp)
}
  
accuracy_measures(tourism, "yearly", list(1, 2, 3, 4, 1:2, 1:4))
accuracy_measures(tourism, "quarterly", list(1, 2, 3, 4, 6, 8, 1:4, 1:8))
accuracy_measures(tourism, "monthly", list(1, 2, 3, 6, 12, 18, 24, 1:3, 1:12, 1:24))

accuracy_measures(M3, "yearly", list(1, 2, 3, 4, 1:2, 1:4))
