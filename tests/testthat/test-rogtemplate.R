test_that("Test package", {
  pkg <- tempdir()
  expect_message(rog_badge_ropengov(install = FALSE))
})
