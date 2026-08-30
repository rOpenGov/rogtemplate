test_that("sequential palettes retain their rOpenGov color endpoints", {
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

test_that("palette controls apply transparency and reverse the scale", {
  expect_equal(
    rog_orange_pal(4),
    c("#FF6600E6", "#FF9148E6", "#FFBC90E6", "#FFE7D8E6")
  )
  expect_equal(
    rog_orange_pal(4, alpha = 1, rev = TRUE),
    rev(rog_orange_pal(4, alpha = 1))
  )
})
