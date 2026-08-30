test_that("rog_logo() creates a nonempty PNG in the requested location", {
  output_dir <- withr::local_tempdir()
  logo_path <- file.path(output_dir, "logo.png")

  expect_message(
    result <- rog_logo(
      "test",
      logo_path,
      overwrite = FALSE,
      favicons = FALSE
    ),
    "Created logo at"
  )

  expect_null(result)
  expect_true(file.exists(logo_path))
  expect_gt(file.info(logo_path)$size, 0)
})

test_that("rog_load_font() loads the bundled rOpenGov font", {
  expect_message(
    family <- rog_load_font(),
    'Loaded the "B612 Mono" font'
  )

  expect_equal(family, "B612 Mono")
})

test_that("package metadata is required when detecting a package name", {
  pkg <- withr::local_tempdir()
  withr::local_dir(pkg)

  expect_error(
    package_name(),
    "No .*DESCRIPTION.* file found",
    class = "rlang_error"
  )
})
