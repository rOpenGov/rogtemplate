#' rOpenGov color palettes
#'
#' Color palettes based on the color scheme of rOpenGov
#'
#' @family rog_plot
#' @family extras
#'
#' @rdname rog_pals
#' @name rog_pals
#'
#' @return Color palettes
#'
#' @export
#'
#' @inheritParams grDevices::hcl.pals
#'
#' @seealso [grDevices::hcl.colors()]
#'
#' @examples
#'
#' scales::show_col(rog_orange_pal(9))
#'
#' scales::show_col(rog_dark_pal(9))
#'
#' scales::show_col(rog_gradient_pal(9))
#'
#' scales::show_col(rog_qualitative_pal(9))
rog_orange_pal <- function(n = 4, alpha = 0.9, rev = FALSE) {
  cols <- c("#ff6600", "#ffe7d8")
  if (rev) {
    cols <- rev(cols)
  }

  ramp <- colorRampPalette(cols)
  if (alpha == 1) {
    return(ramp(n))
  }
  col_end <- adjustcolor(ramp(n), alpha.f = alpha)
  col_end
}

#' @rdname rog_pals
#'
#' @export
rog_dark_pal <- function(n = 4, alpha = 0.9, rev = FALSE) {
  cols <- c("#343a40", "#e8ebed")
  if (rev) {
    cols <- rev(cols)
  }

  ramp <- colorRampPalette(cols)
  if (alpha == 1) {
    return(ramp(n))
  }
  col_end <- adjustcolor(ramp(n), alpha.f = alpha)
  col_end
}

#' @rdname rog_pals
#'
#' @export
rog_gradient_pal <- function(n = 4, alpha = 0.9, rev = FALSE) {
  cols <- c("#343a40", "#9A5020", "#CD5B10", "#ff6600")
  if (rev) {
    cols <- rev(cols)
  }

  ramp <- colorRampPalette(cols)
  if (alpha == 1) {
    return(ramp(n))
  }
  col_end <- adjustcolor(ramp(n), alpha.f = alpha)
  col_end
}

#' @rdname rog_pals
#'
#' @export
rog_qualitative_pal <- function(n = 6, alpha = 0.9, rev = FALSE) {
  color <- "#ff6600"

  rgb_col <- col2rgb(color)
  hsv_col <- rgb2hsv(rgb_col)[, 1]
  hue <- hsv_col[1]
  sat <- hsv_col[2]
  val <- hsv_col[3]
  cols <- seq(hue, hue + 1, by = 1 / n)
  cols <- cols[seq_len(n)]
  cols[cols > 1] <- cols[cols > 1] - 1
  colors <- hsv(cols, sat, val)
  if (startsWith(color, "#") && nchar(color) == 9) {
    alpha <- substr(color, 8, 9)
    colors <- paste(colors, alpha, sep = "")
  }

  if (rev) {
    colors <- rev(colors)
  }

  if (alpha == 1) {
    return(colors)
  }

  colors <- adjustcolor(colors, alpha.f = alpha)

  colors
}
