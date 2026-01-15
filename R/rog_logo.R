#' Creates a logo for your rOpenGov package
#'
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
#' @family extras
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
#' plot(logo)
rog_logo <- function(
  pkgname,
  filename = "man/figures/logo.png",
  p_x = 1,
  p_y = 1,
  p_size = 202.6 * nchar(pkgname)**-1.008,
  overwrite = FALSE,
  favicons = TRUE
) {
  if (missing(pkgname)) {
    pkgname <- package_name()
  }

  enddir <- dirname(filename)
  if (!dir.exists(enddir)) {
    dir.create(enddir, recursive = TRUE)
  }

  # Load B612

  family <- rog_load_font()

  # Remove old logos: png and svg
  if (isTRUE(overwrite)) {
    oldlogo <- file.path("man", "figures", "logo.png")
    if (file.exists(oldlogo)) {
      file.remove(oldlogo)
    }

    oldlogo <- file.path("man", "figures", "logo.svg")
    if (file.exists(oldlogo)) file.remove(oldlogo)
  }

  if (isFALSE(overwrite) && file.exists(filename)) {
    filename <- tempfile(fileext = ".png")
    message("Old logo detected. Use overwrite = TRUE")
  }

  # Subplot
  img <- magick::image_read(system.file(
    "assets/partof.png",
    package = "rogtemplate"
  ))
  g <- grid::rasterGrob(img, interpolate = TRUE)

  p <- ggplot2::ggplot() +
    ggplot2::annotation_custom(
      g,
      xmin = -Inf,
      xmax = Inf,
      ymin = -Inf,
      ymax = Inf
    ) +
    ggplot2::theme_void()

  # Create plot
  suppressWarnings(
    hexSticker::sticker(
      p,
      package = pkgname,
      s_width = 1,
      s_y = 0.45,
      s_x = 1,
      h_fill = "#343a40",
      h_color = "#ff6600",
      p_family = family,
      p_x = p_x,
      p_y = p_y,
      p_size = p_size,
      p_color = "#ffffff",
      filename = filename
    )
  )

  message("Logo created on ", filename)

  # Favicons

  if (isTRUE(favicons) && filename == "man/figures/logo.png") {
    pkgdown::build_favicons(overwrite = TRUE)
  }
}


#' Get package name
#' @noRd
package_name <- function() {
  desc_path <- file.path(normalizePath("."), "DESCRIPTION")

  if (!file.exists(desc_path)) {
    stop("No DESCRIPTION file found ", call. = FALSE)
  }

  # Read package name

  packagename <- read.dcf(desc_path, "Package")

  packagename
}


#' Load rogtemplate fonts
#'
#' Load the current font in use for rOpenGov,
#' [B612 Mono](https://fonts.google.com/specimen/B612+Mono)
#'
#' @family extras
#'
#' @export
#' @examples
#' rog_load_font()
rog_load_font <- function() {
  family <- "B612 Mono"
  fonts <- list.files(
    system.file("fonts", package = "rogtemplate"),
    pattern = "ttf$",
    recursive = TRUE,
    full.names = TRUE
  )

  sysfonts::font_add(
    family,
    regular = as.character(fonts[4]),
    bold = as.character(fonts[1]),
    italic = as.character(fonts[3]),
    bolditalic = as.character(fonts[2])
  )

  showtext::showtext_auto()

  message(paste(family, "font loaded"))

  family
}
