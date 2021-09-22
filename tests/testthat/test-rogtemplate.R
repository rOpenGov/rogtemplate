test_that("Test package", {
  pkg <- tempdir()
  expect_message(rog_badge_ropengov(install = FALSE))

  tmp <- tempfile(fileext = ".png")
  expect_message(rog_logo("test", tmp, overwrite = FALSE, favicons = FALSE))
  expect_true(file.exists(tmp))
})
