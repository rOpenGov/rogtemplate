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

test_that("rog_logo() detects the package name and creates directories", {
  pkg <- local_test_package("samplepkg")
  withr::local_dir(pkg)
  logo_path <- file.path("nested", "assets", "logo.png")

  expect_message(
    result <- withVisible(
      rog_logo(filename = logo_path, favicons = FALSE)
    ),
    "Created logo at"
  )

  expect_equal(result, list(value = NULL, visible = FALSE))
  expect_true(file.exists(logo_path))
  expect_gt(file.info(logo_path)$size, 0)
})

test_that("rog_logo() preserves an existing logo unless overwrite is set", {
  output_dir <- withr::local_tempdir()
  logo_path <- file.path(output_dir, "logo.png")
  writeLines("existing logo", logo_path)
  png_before <- list.files(tempdir(), pattern = "[.]png$", full.names = TRUE)

  messages <- capture.output(
    rog_logo("test", logo_path, overwrite = FALSE, favicons = FALSE),
    type = "message"
  )

  png_after <- list.files(tempdir(), pattern = "[.]png$", full.names = TRUE)
  temporary_logo <- setdiff(png_after, png_before)
  withr::defer(unlink(temporary_logo))

  expect_match(paste(messages, collapse = "\n"), "Existing logo detected")
  expect_equal(readLines(logo_path), "existing logo")
  expect_length(temporary_logo, 1)
  expect_gt(file.info(temporary_logo)$size, 0)
})

test_that("rog_logo() replaces old logo assets", {
  pkg <- withr::local_tempdir()
  withr::local_dir(pkg)
  dir.create(file.path("man", "figures"), recursive = TRUE)
  png_path <- file.path("man", "figures", "logo.png")
  svg_path <- file.path("man", "figures", "logo.svg")
  writeLines("old PNG", png_path)
  writeLines("old SVG", svg_path)

  expect_message(
    result <- withVisible(
      rog_logo("test", overwrite = TRUE, favicons = FALSE)
    ),
    "Created logo at"
  )

  expect_equal(result, list(value = NULL, visible = FALSE))
  expect_true(file.exists(png_path))
  expect_gt(file.info(png_path)$size, 0)
  expect_false(file.exists(svg_path))
})

test_that("rog_logo() builds favicons for the default logo", {
  pkg <- withr::local_tempdir()
  withr::local_dir(pkg)
  favicons <- NULL

  local_mocked_bindings(
    build_pkgdown_favicons = function(...) {
      favicons <<- list(...)
    }
  )

  expect_message(
    rog_logo("test", overwrite = TRUE),
    "Created logo at"
  )

  expect_equal(favicons, list(overwrite = TRUE))
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
