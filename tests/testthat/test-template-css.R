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

  expect_match(css, "pre code :is(span, a).al /* Alert */ {", fixed = TRUE)
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
  masks <- regmatches(
    css,
    gregexpr("  --rogtemplate-callout-mask: [^\n]+", css)
  )[[1]]
  expect_length(masks, 6L)
  expect_match(
    css,
    "-webkit-mask-image: var\\(--rogtemplate-callout-mask\\);"
  )
  expect_match(css, "  mask-image: var\\(--rogtemplate-callout-mask\\);")
  expect_no_match(paste(masks, collapse = "\n"), "rgb\\(|style=")
  expect_match(css, "background-color: currentColor;")
  expect_match(css, "mask-size: contain;")
  for (type in c("primary", "success", "warning", "danger")) {
    expect_match(css, paste0("color: var\\(--bs-", type, "-text-emphasis\\);"))
  }
})

test_that("light text and Tango colors meet the AA contrast target", {
  config <- yaml::read_yaml(rogtemplate_file("pkgdown/_pkgdown.yml"))
  brand <- config$template$bslib$brand
  palette <- brand$color$palette
  defaults <- brand$defaults$bootstrap$defaults
  css <- paste(
    readLines(rogtemplate_file("pkgdown/assets/BS5/rogtemplate.css")),
    collapse = "\n"
  )
  tokens <- regmatches(
    css,
    gregexpr("--rogtemplate-hl-[a-z]+: #[[:xdigit:]]{6};", css)
  )[[1]]
  colors <- sub(".*: (#[[:xdigit:]]{6});", "\\1", tokens)

  expect_length(colors, 3L)
  for (color in c(palette$code, colors)) {
    expect_gte(contrast_ratio(color, "#f8f8f8"), 4.5)
  }
  expect_gte(
    contrast_ratio(palette[[brand$typography$link$color]], "#fff"),
    4.5
  )
  expect_gte(
    contrast_ratio(defaults[["link-color-dark"]], defaults[["body-bg-dark"]]),
    4.5
  )
})

test_that("narrow navbars retain compact title and version sizing", {
  skip_if_not_installed("sass")

  css <- as.character(sass::sass(
    readLines(
      rogtemplate_file("pkgdown/assets/BS5/rogtemplate.css"),
      warn = FALSE
    ),
    cache = NULL,
    options = sass::sass_options(output_style = "expanded")
  ))
  narrow <- regmatches(
    css,
    regexpr(
      "@media \\(max-width: 375px\\) \\{[\\s\\S]*?\n\\}",
      css,
      perl = TRUE
    )
  )

  expect_match(narrow, "\\.navbar-brand\\s*\\{\\s*font-size: 1\\.125rem;")
  expect_match(narrow, "\\.navbar \\.nav-text\\s*\\{\\s*font-size: 0?\\.65rem;")
})
