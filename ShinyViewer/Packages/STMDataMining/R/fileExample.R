#' An example of a feasible input dataset.
#'
#' A dataset containing several feature about defects and the
#' wafer itself:
#'
#' @format A data frame with 16 rows and 45 variables. Here are listed
#' compulsory variables only. If one of them is missing, the whole analysis
#' may not work:
#' \itemize{
#'   \item LOT: lot identifier (string)
#'   \item WAFER: wafer identifier (string)
#'   \item LAYER: layer identifier (string)
#'   \item WAFER_SIZE: wafer diameter (1000 - 2000)
#'   \item DIE_WIDTH: the width of each die in a wafer (10 - 20)
#'   \item DIE_HEIGHT: the width of each die in a wafer (10 - 20)
#'   \item DIE_X: die identifier on the x axis (integer: 1 - 7)
#'   \item DIE_Y: die identifier on the y axis (integer: 1 - 7)
#'   \item DIST_X: position of a defect on the x axis (float: -5 -- 342)
#'   \item DIST_Y: position of a defect on the x axis (float: -14 -- 434)
#' }
"fileExample"
