test_that("rog_build() routes logo and pkgdown arguments independently", {
  calls <- new.env(parent = emptyenv())
  pkg <- local_test_package()

  local_mocked_bindings(
    rog_logo = function(pkgname,
                        filename = "man/figures/logo.png",
                        p_x = 1,
                        p_y = 1,
                        p_size = NULL,
                        overwrite = FALSE,
                        favicons = TRUE) {
      calls$logo <- list(overwrite = overwrite, favicons = favicons)
    },
    rog_add_template_pkgdown = function() {
      calls$template <- TRUE
    },
    build_pkgdown_site = function(...) {
      calls$site <- list(...)
    }
  )

  result <- rog_build(
    pkg = pkg,
    overwrite = TRUE,
    favicons = FALSE,
    preview = FALSE,
    quiet = FALSE
  )

  expect_null(result)
  expect_equal(calls$logo, list(overwrite = TRUE, favicons = FALSE))
  expect_true(calls$template)
  expect_equal(
    calls$site,
    list(pkg = ".", preview = FALSE, quiet = FALSE)
  )
})
