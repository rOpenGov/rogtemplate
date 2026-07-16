contrast_ratio <- function(foreground, background) {
  foreground_luminance <- relative_luminance(hex_to_rgb(foreground))
  background_luminance <- relative_luminance(hex_to_rgb(background))

  (max(foreground_luminance, background_luminance) + 0.05) /
    (min(foreground_luminance, background_luminance) + 0.05)
}

contrast_ratio_alpha <- function(foreground, background, alpha) {
  foreground_rgb <- hex_to_rgb(foreground)
  background_rgb <- hex_to_rgb(background)
  composite_rgb <- foreground_rgb * alpha + background_rgb * (1 - alpha)

  foreground_luminance <- relative_luminance(composite_rgb)
  background_luminance <- relative_luminance(background_rgb)

  (max(foreground_luminance, background_luminance) + 0.05) /
    (min(foreground_luminance, background_luminance) + 0.05)
}

hex_to_rgb <- function(hex) {
  hex <- sub("^#", "", hex)
  if (nchar(hex) == 3) {
    hex <- paste0(
      substr(hex, 1, 1),
      substr(hex, 1, 1),
      substr(hex, 2, 2),
      substr(hex, 2, 2),
      substr(hex, 3, 3),
      substr(hex, 3, 3)
    )
  }

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

yiq_brightness <- function(hex) {
  rgb <- hex_to_rgb(hex) * 255

  sum(c(299, 587, 114) * rgb) / 1000
}

rogtemplate_file <- function(...) {
  system.file(..., package = "rogtemplate", mustWork = TRUE)
}
