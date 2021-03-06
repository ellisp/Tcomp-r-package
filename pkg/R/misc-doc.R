

#'  
#' Tourism competition data
#'
#' The data from the tourism forecasting competition described
#' in George Athanasopolous, Rob J. Hyndman, Haiyan Song, Doris C. Wu (2011) 
#' ``The tourism forecasting competition'', \emph{International Journal of Forecasting} 27 (2011) 822-844.
#' 
#' @format A list of 1311 series, of class \code{Mcomp}.  Each series within \code{tourism} is of 
#' class \code{Mdata} with the following structure:
#'    \describe{
#' \item{sn}{Name of the series}
#' \item{st}{Series number and period. For example "Y1" denotes
#' first yearly series, "Q20" denotes 20th quarterly series and so on.}
#' \item{n}{The number of observations in the time series}
#' \item{h}{The number of required forecasts}
#' \item{period}{Interval of the time series. Possible values are "YEARLY", "QUARTERLY" &
#' "MONTHLY"}
#' \item{type}{The type of series. For data in \code{tourism}, this is always "TOURISM".}
#' \item{description}{"No description available".  Kept for consistency with the M3 and M1 data.}
#' \item{x}{A time series of length \code{n} (the historical data)}
#' \item{xx}{A time series of length \code{h} (the future data)}
#' }
#' @source \url{http://robjhyndman.com/papers/the-tourism-forecasting-competition}
#' @seealso \code{\link[Mcomp]{subset.Mcomp}}, \code{\link[Mcomp]{plot.Mdata}}
#' @examples
#' plot(tourism$Y1)
"tourism"



#'  
#' Reproduction of selected tourism competition results
#'
#' Reproduction of selected results from the tourism forecasting competition described in 
#' Athanasopoulos et al. 2011 (\url{http://robjhyndman.com/papers/forecompijf.pdf})
#' 
#' Note that only Mean Absolute Percentage Error of the naive forecasts matches exactly that published.
#' All Mean Absolute Scaled Error results are slightly higher than those published due to an unknown
#' difference in MASE method.  All results for ARIMA, ETS and Theta method forecasts differ due to
#' changes in the forecasting methods since 2011.
#' See Vignette for details,
#' including the code required to re-create the `Tcomp_reproduction` object.
#' 
#' @format {A list of three elements named \code{monthly}, \code{quarterly} and \code{yearly}.   
#' These correspond to tables 4, 5 and 6 in the Athanasopoulos et al 2011 article.  
#' }
#' @source \url{http://robjhyndman.com/papers/the-tourism-forecasting-competition}
#' @examples
#' Tcomp_reproduction
"Tcomp_reproduction"


#' Tcomp: Data from the Tourism Forecasting competition
#'
#' The Tcomp package provides data from the tourism forecasting competition described
#' in George Athanasopolous, Rob J. Hyndman, Haiyan Song, Doris C. Wu (2011) 
#' ``The tourism forecasting competition'', \emph{International Journal of Forecasting} 27 (2011) 822-844.
#' 
#' 
#' @section Tcomp data:
#' \describe{
#' \item{tourism}{A list of class Mdata with 1,311 time series in it, divided into 
#' training (\code{x}) and test (\code{xx}) sets. The data are subsettable with subset method from Mcomp R package by monthly, quarterly and yearly series.}
#' }
#' @section Tcomp functions:
#' \describe{
#' \item{forecast_comp}{A convenient wrapper function for providing the mean absolute scaled error (MASE) of four common forecasting methodologies for a time series of class Mdata.}
#' }
#'
#' @docType package
#' @name Tcomp
NULL

#' @importFrom Mcomp subset.Mcomp plot.Mdata
NULL