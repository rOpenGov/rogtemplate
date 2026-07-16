test_that("Test package", {
  pkg <- tempdir()
  expect_message(rog_badge_ropengov(install = FALSE))

  tmp <- tempfile(fileext = ".png")
  expect_message(rog_logo("test", tmp, overwrite = FALSE, favicons = FALSE))
  expect_true(file.exists(tmp))
})

test_that("template home link does not include a closing anchor", {
  pkgdown <- yaml::read_yaml(rogtemplate_file("pkgdown/_pkgdown.yml"))
  link_text <- pkgdown$home$links[[1]]$text

  expect_false(grepl("</a>", link_text, fixed = TRUE))
})

test_that("pkgdown workflow has deploy permissions and logo check", {
  workflow_path <- rogtemplate_file("yaml/rogtemplate-gh-pages.yaml")
  workflow <- yaml::read_yaml(workflow_path)
  workflow_text <- paste(readLines(workflow_path), collapse = "\n")
  logo_check <- gregexpr(
    'file.exists(file.path("man", "figures", "logo.png"))',
    workflow_text,
    fixed = TRUE
  )[[1]]

  expect_equal(workflow$permissions$contents, "write")
  expect_equal(length(logo_check), 1)
})

test_that("rog_actions_pkgdown_branch writes to pkg", {
  pkg <- tempfile("pkg")
  dir.create(pkg)
  writeLines(
    c(
      "Package: tmpkg",
      "Title: Temp Package",
      "Version: 0.0.0.9000",
      paste0(
        "Authors@R: person(\"A\", \"B\", email = \"a@example.com\", ",
        "role = c(\"aut\", \"cre\"))"
      ),
      "Description: Test package.",
      "License: MIT",
      "Encoding: UTF-8"
    ),
    file.path(pkg, "DESCRIPTION")
  )

  expect_message(rog_actions_pkgdown_branch(pkg = pkg), "Workflow added")

  workflow_path <- file.path(
    pkg,
    ".github",
    "workflows",
    "rogtemplate-gh-pages.yaml"
  )
  build_ignore <- readLines(file.path(pkg, ".Rbuildignore"))

  expect_true(file.exists(workflow_path))
  expect_true(any(grepl("github", build_ignore)))
})

test_that("minified CSS is generated from the source CSS", {
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

test_that("dark mode danger text has AA contrast", {
  css <- paste(
    readLines(rogtemplate_file("pkgdown/assets/BS5/rogtemplate.css")),
    collapse = "\n"
  )
  body_bg <- sub(
    ".*--bs-body-bg: (#[[:xdigit:]]{6});.*",
    "\\1",
    css
  )
  danger <- sub(
    ".*--bs-danger-text-emphasis: (#[[:xdigit:]]{6});.*",
    "\\1",
    css
  )

  expect_equal(body_bg, "#262b30")
  expect_equal(danger, "#ee99a1")
  expect_gte(contrast_ratio(danger, body_bg), 4.5)
})

test_that("dark mode code text has AA contrast from bslib brand", {
  brand <- yaml::read_yaml(rogtemplate_file("brand_yml/_brand.yml"))
  palette <- brand$color$palette
  bootstrap_defaults <- brand$defaults$bootstrap$defaults
  code <- palette[["code-dark"]]

  expect_equal(code, "#f19ac6")
  expect_equal(bootstrap_defaults[["code-color"]], "$brand-code")
  expect_equal(bootstrap_defaults[["code-color-dark"]], "$brand-code_dark")
  expect_gte(contrast_ratio(code, "#262b30"), 4.5)
  expect_gte(contrast_ratio(code, "#343a40"), 4.5)
  expect_gt(yiq_brightness(code), 128)
})

test_that("dark mode brand orange has AA contrast on the body background", {
  brand <- yaml::read_yaml(rogtemplate_file("brand_yml/_brand.yml"))
  palette <- brand$color$palette

  expect_gte(contrast_ratio(palette$orange, "#262b30"), 4.5)
  expect_gte(contrast_ratio(palette$white, "#262b30"), 4.5)
  expect_gte(contrast_ratio(palette[["logo-gray-light"]], "#262b30"), 4.5)
})

test_that("dark syntax highlighting has AA contrast on code background", {
  code_bg <- "#343a40"

  expect_gte(contrast_ratio("#85c0ff", code_bg), 4.5)
  expect_gte(contrast_ratio("#ffa366", code_bg), 4.5)
  expect_gte(contrast_ratio("#7eca8f", code_bg), 4.5)
  expect_gte(contrast_ratio("#ee99a1", code_bg), 4.5)
  expect_gte(contrast_ratio("#ffffff", code_bg), 4.5)
})

test_that("canonical brand file aligns with pkgdown brand", {
  pkgdown <- yaml::read_yaml(rogtemplate_file("pkgdown/_pkgdown.yml"))
  brand <- yaml::read_yaml(rogtemplate_file("brand_yml/_brand.yml"))
  brand_dir <- dirname(rogtemplate_file("brand_yml/_brand.yml"))

  expect_true(file.exists(rogtemplate_file("brand_yml/_brand.yml")))
  expect_false(file.exists(file.path(brand_dir, "_brand.yaml")))
  expect_equal(
    brand[c("color", "typography", "defaults")],
    pkgdown$template$bslib$brand
  )
})

test_that("standalone brand uses light and dark header logos", {
  brand_path <- rogtemplate_file("brand_yml/_brand.yml")
  brand <- yaml::read_yaml(brand_path)
  normalized_brand <- brand.yml::read_brand_yml(brand_path)
  header_light <- brand$logo$images[["header-light"]]
  header_dark <- brand$logo$images[["header-dark"]]

  expect_equal(header_light, "../pkgdown/assets/logo2020_black_orange.svg")
  expect_equal(header_dark, "../pkgdown/assets/logo2020_white_orange.svg")
  expect_equal(brand$logo$medium$light, "header-light")
  expect_equal(brand$logo$medium$dark, "header-dark")
  expect_true(file.exists(rogtemplate_file(
    "pkgdown/assets/logo2020_black_orange.svg"
  )))
  expect_true(file.exists(rogtemplate_file(
    "pkgdown/assets/logo2020_white_orange.svg"
  )))
  expect_s3_class(
    normalized_brand$logo$medium,
    "brand_logo_resource_light_dark"
  )
  expect_equal(
    normalized_brand$logo$medium$dark$path,
    "../pkgdown/assets/logo2020_white_orange.svg"
  )
})

test_that("custom CSS does not define bslib brand variables", {
  css <- paste(
    readLines(rogtemplate_file("pkgdown/assets/BS5/rogtemplate.css")),
    collapse = "\n"
  )

  expect_equal(
    grep("--brand-[[:alnum:]_-]+\\s*:", css, value = TRUE),
    character()
  )
})

test_that("code blocks do not inherit inline code backgrounds", {
  css <- paste(
    readLines(rogtemplate_file("pkgdown/assets/BS5/rogtemplate.css")),
    collapse = "\n"
  )

  expect_match(css, "pre code,\\s*pre code span")
  expect_match(css, "background-color: transparent !important;")
})

test_that("pkgdown bootstrap defaults use brand palette variables", {
  brand <- yaml::read_yaml(rogtemplate_file("brand_yml/_brand.yml"))
  bootstrap_defaults <- brand$defaults$bootstrap$defaults

  expect_equal(bootstrap_defaults[["navbar-light-bg"]], "$brand-gray_dark")
  expect_equal(bootstrap_defaults[["navbar-dark-bg"]], "$brand-gray_dark")
  expect_equal(bootstrap_defaults[["pkgdown-footer-bg"]], "$brand-gray_dark")
  expect_equal(bootstrap_defaults[["dropdown-bg"]], "$brand-gray_dark")
  expect_equal(bootstrap_defaults[["dropdown-dark-bg"]], "$brand-gray_dark")
  expect_equal(
    bootstrap_defaults[["navbar-light-color"]],
    "rgba(255, 255, 255, .75)"
  )
  expect_equal(
    bootstrap_defaults[["navbar-dark-color"]],
    "rgba(255, 255, 255, .75)"
  )
  expect_equal(
    bootstrap_defaults[["pkgdown-footer-color"]],
    "rgba(255, 255, 255, 0.75)"
  )
  expect_equal(bootstrap_defaults[["navbar-light-brand-color"]], "$brand-white")
  expect_equal(bootstrap_defaults[["navbar-dark-brand-color"]], "$brand-white")
  expect_gte(contrast_ratio_alpha("#fff", "#343a40", 0.75), 4.5)
})

test_that("brand light colors keep the pkgdown palette aligned", {
  brand <- yaml::read_yaml(rogtemplate_file("brand_yml/_brand.yml"))
  palette <- brand$color$palette

  expect_equal(palette$blue, "#007bff")
  expect_equal(palette$orange, "#ff6600")
  expect_equal(palette$gray, "#6c757d")
  expect_equal(palette[["gray-dark"]], "#343a40")
  expect_equal(palette[["logo-gray"]], "#666666")
  expect_equal(palette[["logo-gray-dark"]], "#4d4d4d")
  expect_equal(palette[["logo-gray-light"]], "#b4b4b4")
  expect_equal(palette[["jumbotron-bg"]], "#e9ecef")

  expect_equal(brand$color$foreground, "#212529")
  expect_equal(brand$color$background, "white")
  expect_equal(brand$color$primary, "blue")
  expect_equal(brand$color$warning, "orange")
  expect_gte(contrast_ratio(palette$orange, "#212529"), 4.5)
})
