contrast_ratio <- function(foreground, background) {
  foreground_luminance <- relative_luminance(hex_to_rgb(foreground))
  background_luminance <- relative_luminance(hex_to_rgb(background))

  (max(foreground_luminance, background_luminance) + 0.05) /
    (min(foreground_luminance, background_luminance) + 0.05)
}

hex_to_rgb <- function(hex) {
  hex <- sub("^#", "", hex)
  strtoi(substring(hex, c(1, 3, 5), c(2, 4, 6)), 16L) / 255
}

relative_luminance <- function(rgb) {
  linear_rgb <- ifelse(
    rgb <= 0.03928,
    rgb / 12.92,
    ((rgb + 0.055) / 1.055)^2.4
  )

  sum(c(0.2126, 0.7152, 0.0722) * linear_rgb)
}
