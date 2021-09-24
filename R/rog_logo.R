#' Creates a logo for your rOpenGov package
#'
#' @family extras
#'
#' Creates a logo automatically with [hexSticker::sticker()].
#' Optionally, create also favicons with [pkgdown::build_favicons()].
#'
#' @param pkgname Name of the package. If not present it would be autodetected
#'   by the function.
#'
#' @param overwrite Should the current logo be overwritten? When `TRUE` it
#'   would run [usethis::use_logo()].
#'
#' @param favicons Logical, do you want to create favicons with
#' [pkgdown::build_favicons()]?
#'
#' @inheritParams hexSticker::sticker
#'
#'
#' @seealso [hexSticker::sticker()], [usethis::use_logo()],
#' [pkgdown::build_favicons()].
#'
#' @export
#' @examples
#'
#' tmp <- tempfile(fileext = ".png")
#' rog_logo("test a package", tmp, overwrite = FALSE, favicons = FALSE)
#'
#' # Display
#' logo <- magick::image_read(tmp)
#'
#' logo
#'
#' opar <- par(no.readonly = TRUE)
#'
#' par(ask = FALSE, mar = c(0, 0, 0, 0))
#' plot(logo)
#' par(opar)
rog_logo <- function(pkgname, filename = "man/figures/logo.png",
                     overwrite = FALSE,
                     favicons = TRUE) {
  if (missing(pkgname)) pkgname <- package_name()

  # Load B612

  family <- load_font_rogtemplate()

  # Autoscaling
  p_size <- 160 * nchar(pkgname)**-1


  if (isTRUE(overwrite)) {
    filename <- tempfile(fileext = ".png")
    if (file.exists("man/figures/logo.png")) {
      d <- file.remove("man/figures/logo.png")
    }
  }

  if (isFALSE(overwrite) && file.exists(filename)) {
    filename <- tempfile(fileext = ".png")
  }



  # Create plot
  suppressWarnings(
    hexSticker::sticker(
      subplot = system.file("figures/cat.png", package = "hexSticker"),
      package = pkgname,
      h_fill = "#343a40",
      h_color = "#ff6600",
      p_family = "B612",
      p_x = 1,
      p_y = 1,
      p_size = p_size,
      filename = filename,
      # No display of subplot
      s_width = 0
    )
  )


  if (overwrite) {
    usethis::use_logo(filename)
  } else {
    message("Logo created on ", filename)
  }

  # Favicons

  if (isTRUE(favicons)) pkgdown::build_favicons(overwrite = TRUE)
}





#' Get package name
#' @noRd
package_name <- function() {
  desc_path <- file.path(normalizePath("."), "DESCRIPTION")

  if (!file.exists(desc_path)) stop("No DESCRIPTION file found ", call. = FALSE)

  # Read package name

  packagename <- read.dcf(desc_path, "Package")

  packagename
}

#' Get package name
#' @noRd
package_name <- function() {
  desc_path <- file.path(normalizePath("."), "DESCRIPTION")

  if (!file.exists(desc_path)) stop("No DESCRIPTION file found ", call. = FALSE)

  # Read package name

  packagename <- read.dcf(desc_path, "Package")

  packagename
}

