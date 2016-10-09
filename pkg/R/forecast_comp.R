


#' Four standard forecasts of a competition dataset
#' 
#' Applies four modelling strategies (ARIMA, ETS, Theta and naive or seasonally naive) to a dataset
#' with class Mdata, returns MASE statistics and (optionally) a summary graphic
#' 
#' @export
#' @import forecast
#' @importFrom graphics par
#' @param the_series a list of class \code{Mdata} eg from the \code{Mcomp} or \code{Tcomp} package.  Crucially, must include elements \code{x} (the training set), \code{xx} (the test set) and \code{h} (the forecast horizon)
#' @param tests a list of the forecast horizons over which to return the MASE, passed to \code{accuracy}
#' @param plot whether or not to draw basic plot of the four forecast model
#' @param ... other parameters to pass to \code{plot.forecast()}
#' @return a data frame of 4 rows and \code{length(tests) + 1} columns with first column as method and each other column containing the 
#' Mean Absolute Scaled Error at the horizon indicated by the column name
#' @details this is just a convenience function for fitting four different standard time series forecasts to an object from an 
#' M competition or the tourism competition.  Mainly of interest to analysis wishing to re-produce published results or create 
#' a benchmark against which other methods can be compared.
#' @examples
#' forecast_comp(tourism$Y18, test = list(1, 2, 3, 4, 1:2, 1:4), plot = TRUE)
#' forecast_comp(tourism$Q4, test = list(1, 2, 3, 4, 5, 6, 7, 8, 1:4, 1:8), plot = FALSE)
forecast_comp <- function(the_series, tests = list(the_series$h), plot = FALSE, ...){
  # the_series <- tourism[[800]] # for dev
  x <- the_series$x   # training set
  xx <- the_series$xx # test set
  h <- the_series$h
  
  mod1 <- auto.arima(x)
  fc1 <- forecast::forecast(mod1, h = h)
  fc2 <- forecast::forecast(forecast::ets(x), h = h)
  fc3 <- forecast::thetaf(x, h = h)
  fc4 <- forecast::snaive(x, h = h)
  if(plot){
    par(mfrow = c(2, 2), bty = "l", ...)
    plot(fc1, ylab = the_series$st)
    plot(fc2, ylab = the_series$st)  
    plot(fc3, ylab = the_series$st)  
    plot(fc4, ylab = the_series$st)
  }
  
  MASEs <- matrix(0, nrow = 4, ncol = length(tests))
  for(j in 1:length(tests)){
    this_test <- tests[[j]]
    
    MASEs[ , j] <- c(
      forecast::accuracy(fc1, xx, test = this_test)["Test set", "MASE"],
      forecast::accuracy(fc2, xx, test = this_test)["Test set", "MASE"],
      forecast::accuracy(fc3, xx, test = this_test)["Test set", "MASE"],
      forecast::accuracy(fc4, xx, test = this_test)["Test set", "MASE"]
    )
  }
  colnames(MASEs) <- gsub(":", "-" , as.character(tests))
  rownames(MASEs) <- c("ARIMA", "ETS", "Theta", "Naive")
  
  return(MASEs)
}




