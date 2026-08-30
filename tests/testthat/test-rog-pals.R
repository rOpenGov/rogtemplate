test_that("sequential palettes retain their rOpenGov color endpoints", {
  skip_on_os("mac")

  expect_equal(
    rog_orange_pal(4, alpha = 1),
    c("#FF6600", "#FF9148", "#FFBC90", "#FFE7D8")
  )
  expect_equal(
    rog_dark_pal(4, alpha = 1),
    c("#343A40", "#707579", "#ABB0B3", "#E8EBED")
  )
  expect_equal(
    rog_gradient_pal(4, alpha = 1),
    c("#343A40", "#9A5020", "#CD5B10", "#FF6600")
  )
})

test_that("qualitative palette generates distinct rOpenGov hues", {
  expect_equal(
    rog_qualitative_pal(6, alpha = 1),
    c(
      "#FF6600",
      "#99FF00",
      "#00FF66",
      "#0099FF",
      "#6600FF",
      "#FF0099"
    )
  )
})

test_that("all palettes apply transparency and reverse their scales", {
  palettes <- list(
    orange = rog_orange_pal,
    dark = rog_dark_pal,
    gradient = rog_gradient_pal,
    qualitative = rog_qualitative_pal
  )

  opaque <- lapply(palettes, \(palette) palette(4, alpha = 1))
  transparent <- lapply(palettes, \(palette) palette(4, alpha = 0.5))
  reversed <- lapply(
    palettes,
    \(palette) palette(4, alpha = 1, rev = TRUE)
  )

  expect_equal(
    lengths(opaque),
    stats::setNames(rep(4L, length(palettes)), names(palettes))
  )
  expect_equal(reversed, lapply(opaque, rev))
  expect_equal(
    vapply(
      transparent,
      \(colors) all(grepl("^#[[:xdigit:]]{8}$", colors)),
      logical(1)
    ),
    stats::setNames(rep(TRUE, length(palettes)), names(palettes))
  )
})
