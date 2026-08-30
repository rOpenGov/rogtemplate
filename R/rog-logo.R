#' Create a logo for your rOpenGov package
#'
#' Creates a logo automatically with \CRANpkg{hexSticker}'s
#' [hexSticker::sticker()]. Optionally, create favicons with
#' \CRANpkg{pkgdown}'s [pkgdown::build_favicons()].
#'
#' @inheritParams hexSticker::sticker
#' @param pkgname Name of the package. If not supplied, the name is detected
#'   from DESCRIPTION.
#' @param overwrite Should the current logo be overwritten? When `TRUE`, it
#'   runs \CRANpkg{usethis}'s [usethis::use_logo()].
#' @param favicons Should favicons be created with \CRANpkg{pkgdown}'s
#'   [pkgdown::build_favicons()]?
#' @returns The function is called for its side effects and returns `NULL`
#'   invisibly.
#' @seealso \CRANpkg{hexSticker}'s [hexSticker::sticker()],
#'   \CRANpkg{usethis}'s [usethis::use_logo()] and \CRANpkg{pkgdown}'s
#'   [pkgdown::build_favicons()].
#' @family assets
#' @export
#' @encoding UTF-8
#' @examples
#' tmp <- tempfile(fileext = ".png")
#' rog_logo("test a package", tmp, overwrite = FALSE, favicons = FALSE)
#'
#' # Display the logo.
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

  # Load the rOpenGov font.

  family <- rog_load_font()

  # Remove old PNG and SVG logos before creating a new one.
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
    cli::cli_inform(c(
      "!" = "Existing logo detected, using a temporary output file.",
      "i" = paste(
        "Set {.arg overwrite} to {.code TRUE} to replace the existing",
        "logo."
      )
    ))
  }

  # Build the logo background from the rOpenGov asset.
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

  # Create the hex logo.
  suppressWarnings(hexSticker::sticker(
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
  ))

  cli::cli_inform(c(
    "v" = "Created logo at {.file {filename}}."
  ))

  # Create favicons for pkgdown when the default logo path is used.

  if (isTRUE(favicons) && filename == "man/figures/logo.png") {
    pkgdown::build_favicons(overwrite = TRUE)
  }
}

#' Get package name
#' @noRd
package_name <- function() {
  desc_path <- file.path(normalizePath("."), "DESCRIPTION")

  if (!file.exists(desc_path)) {
    cli::cli_abort("No {.file DESCRIPTION} file found.", call = NULL)
  }

  # Read the package name from DESCRIPTION.

  packagename <- read.dcf(desc_path, "Package")

  packagename
}

#' Load the rogtemplate font
#'
#' Load the current rOpenGov font,
#' [B612 Mono](https://fonts.google.com/specimen/B612+Mono).
#'
#' @returns The font family name, `"B612 Mono"`.
#' @family assets
#' @export
#' @encoding UTF-8
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

  cli::cli_inform(c(
    "v" = "Loaded the {.val {family}} font."
  ))

  family
}
