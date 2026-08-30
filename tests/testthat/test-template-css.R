test_that("bundled minified CSS matches the template source", {
  skip_if_not_installed("sass")

  source_path <- rogtemplate_file("pkgdown/assets/BS5/rogtemplate.css")
  min_path <- rogtemplate_file("pkgdown/assets/BS5/rogtemplate.min.css")
  expected <- sass::sass(
    readLines(source_path),
    cache = NULL,
    options = sass::sass_options(output_style = "compressed")
  )
  actual <- paste(readLines(min_path), collapse = "\n")
  expected <- sub("\n$", "", as.character(expected))

  expect_equal(actual, expected)
})

test_that("template CSS delegates brand colors and sizing to bslib", {
  css <- paste(
    readLines(rogtemplate_file("pkgdown/assets/BS5/rogtemplate.css")),
    collapse = "\n"
  )

  expect_equal(
    grep("--brand-[[:alnum:]_-]+\\s*:", css, value = TRUE),
    character()
  )
  expect_no_match(css, "--bs-body-bg\\s*:")
  expect_no_match(css, "--bs-danger-text-emphasis\\s*:")
  expect_no_match(css, "--bs-dropdown-[[:alnum:]_-]+\\s*:")
  expect_no_match(css, "font-size: 1\\.5rem;")
  expect_no_match(css, "font-size: 1\\.25rem;")
  expect_match(css, "font-size: var\\(--bs-blockquote-font-size\\);")
  expect_no_match(css, "#navbar \\.dropdown-menu \\.dropdown-item\\.active")
  expect_match(css, "color: var\\(--bs-navbar-hover-color\\);")
  expect_match(css, "color: var\\(--bs-navbar-active-color\\);")
  expect_match(
    css,
    "background-color: RGBA\\(var\\(--bs-warning-rgb\\), 0\\.05\\);"
  )
})

test_that("inline code styling uses bslib variables", {
  css <- paste(
    readLines(rogtemplate_file("pkgdown/assets/BS5/rogtemplate.css")),
    collapse = "\n"
  )

  expect_no_match(css, "code\\s*\\{[^}]*--bs-code-bg")
  expect_no_match(css, "code\\s*\\{[^}]*--bs-code-font-size")
  expect_no_match(css, "pre code,\\s*pre code span")
})

test_that("dark alert syntax has a transparent background", {
  css <- paste(
    readLines(rogtemplate_file("pkgdown/assets/BS5/rogtemplate.css")),
    collapse = "\n"
  )

  expect_match(css, "pre code span\\.al /\\* Alert \\*/ \\{")
  expect_match(css, "background-color: transparent;")
  expect_no_match(css, "pre code span\\s*\\{[^}]*background-color: transparent")
})
