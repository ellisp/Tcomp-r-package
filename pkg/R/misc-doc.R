
#' @importFrom Mcomp plot.Mdata print.Mdata subset.Mcomp
#'  
#' Tourism competition data
#'
#' The data from the 2011 tourism forecasting competition
#' 
#' @format A list of 518 series, of class \code{Mcomp}.  Each series within \code{tourism} is of 
#' class \code{Mdata} with the following structure
#'    \describe{
#' \item{sn}{Name of the series}
#' \item{st}{Series number and period. For example "Y1" denotes
#' first yearly series, "Q20" denotes 20th quarterly series and so on.}
#' \item{n}{The number of observations in the time series}
#' \item{h}{The number of required forecasts}
#' \item{period}{Interval of the time series. Possible values are "YEARLY", "QUARTERLY",
#' "MONTHLY" & "OTHER".}
#' \item{type}{The type of series. Possible values for M1 are "DEMOGR", "INDUST",
#' "MACRO1", "MACRO2", "MICRO1", "MICRO2" & "MICRO3". Possible
#' values for M3 are "DEMOGRAPHIC", "FINANCE", "INDUSTRY", "MACRO",
#' "MICRO", "OTHER".}
#' \item{description}{A short description of the time series}
#' \item{x}{A time series of length \code{n} (the historical data)}
#' \item{xx}{A time series of length \code{h} (the future data)}
#' }
#' @source \url{http://robjhyndman.com/papers/the-tourism-forecasting-competition}
#' @seealso \code{\link[Mcomp]{subset.Mcomp}}, \code{\link[Mcomp]{plot.Mdata}}
#' @examples
#' plot(tourism$Y1)
"tourism"