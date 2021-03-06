#' An example of a feasible input for KDE algorithm.
#'
#' A dataset containing several feature about defects and the
#' wafer itself. 40 wafers have been simulated from 4 different
#' spatial distributions of defects: a central spot, a ring,
#' three spots and uniform.
#'
#' @format A data frame with 4064 rows and 10 variables.
#' \itemize{
#'   \item LOT: lot identifier (string)
#'   \item WAFER: wafer identifier (integer: 1 -- 40)
#'   \item LAYER: layer identifier (integer: 1)
#'   \item WAFER_SIZE: wafer diameter (60)
#'   \item DIE_WIDTH: the width of each die in a wafer (2)
#'   \item DIE_HEIGHT: the width of each die in a wafer (1)
#'   \item DIE_X: die identifier on the x axis (integer: 1 - 30)
#'   \item DIE_Y: die identifier on the y axis (integer: 1 - 60)
#'   \item DIST_X: position of a defect on the x axis (float: -59 -- 59)
#'   \item DIST_Y: position of a defect on the x axis (float: -59.5 -- 59.5)
#' }
"wafers"
