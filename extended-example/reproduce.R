library(Tcomp)
library(dplyr)
library(tidyr)
library(parallel)


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
  
  results_mat <- do.call(rbind, results)
  
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
