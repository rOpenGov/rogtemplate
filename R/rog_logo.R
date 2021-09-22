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
#' rog_logo("test a package", tmp, favicons = FALSE)
#'
#' # Display
#' logo <- magick::image_read(tmp)
#'
#' print(logo)
rog_logo <- function(pkgname, filename = "man/figures/logo.png", favicons = TRUE) {
  if (missing(pkgname)) pkgname <- package_name()

  # Load B612

  family <- load_font_rogtemplate()

  # Autoscaling
  p_size <- 188.46 * nchar(pkgname)**-0.934


  # Create plot
  suppressWarnings(
    hexSticker::sticker(
      subplot = system.file("figures/cat.png", package = "hexSticker"),
      package = pkgname,
      h_fill = "#343a40",
      h_color = "#ff6600",
      p_family = family,
      p_x = 1,
      p_y = 1,
      p_size = p_size,
      filename = filename,
      # No display of subplot
      s_width = 0
    )
  )

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
