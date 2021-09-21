test_that("Test package", {
  pkg <- tempdir()

  expect_message(rog_actions_pkgdown_branch(pkg, TRUE))
  expect_message(rog_actions_pkgdown_branch(pkg, FALSE))


  expect_message(rog_badge_ropengov(install = FALSE))
})
