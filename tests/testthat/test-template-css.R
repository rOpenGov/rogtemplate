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

test_that("copy button interaction colors meet text contrast requirements", {
  css <- paste(
    readLines(rogtemplate_file("pkgdown/assets/BS5/rogtemplate.css")),
    collapse = "\n"
  )
  rule <- regmatches(
    css,
    regexpr("\\.btn-copy-ex:hover,[^}]+\\}", css)
  )

  expect_match(rule, "\\.btn-copy-ex:focus")
  expect_match(rule, "color: var\\(--bs-gray-900\\);")
  expect_match(rule, "background-color: var\\(--bs-warning\\);")

  config <- yaml::read_yaml(rogtemplate_file("pkgdown/_pkgdown.yml"))
  palette <- config$template$bslib$brand$color$palette
  expect_gte(contrast_ratio("#212529", palette$orange), 4.5)
})

test_that("callout masks have no embedded colors and use theme colors", {
  css <- paste(
    readLines(rogtemplate_file("pkgdown/assets/BS5/rogtemplate.css")),
    collapse = "\n"
  )
  masks <- regmatches(css, gregexpr("  mask-image: [^\n]+", css))[[1]]
  webkit_masks <- regmatches(
    css,
    gregexpr("  -webkit-mask-image: [^\n]+", css)
  )[[1]]

  expect_length(masks, 6L)
  expect_equal(sub("-webkit-", "", webkit_masks, fixed = TRUE), masks)
  expect_no_match(paste(masks, collapse = "\n"), "rgb\\(|style=")
  expect_match(css, "background-color: currentColor;")
  expect_match(css, "mask-size: contain;")
  for (type in c("primary", "success", "warning", "danger")) {
    expect_match(css, paste0("color: var\\(--bs-", type, "-text-emphasis\\);"))
  }
})
