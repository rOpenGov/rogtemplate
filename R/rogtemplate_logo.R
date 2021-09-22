#' Creates a logo for your rOpenGov package
#'
#'
#' Creates a logo. Optionally, create also favicons with
#' [pkgdown::build_favicons()].
#'



#' Get package name
#' @noRd
package_name <- function() {
  desc_path <- file.path(normalizePath("."), "DESCRIPTION")

  if (!file.exists(desc_path)) stop("No DESCRIPTION file found ", call. = FALSE)

  # Read package name

  packagename <- read.dcf(desc_path, "Package")

  packagename
}
