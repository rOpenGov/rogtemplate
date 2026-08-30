test_that("bundled pkgdown home link contains valid inline HTML", {
  config <- yaml::read_yaml(rogtemplate_file("pkgdown/_pkgdown.yml"))
  link_text <- config$home$links[[1]]$text

  expect_no_match(link_text, "</a>", fixed = TRUE)
  expect_match(link_text, "rog_logo.svg", fixed = TRUE)
  expect_equal(config$template$bootstrap, 5)
  expect_true(config$template[["light-switch"]])
})

test_that("bundled brand matches the pkgdown template brand", {
  config <- yaml::read_yaml(rogtemplate_file("pkgdown/_pkgdown.yml"))
  brand <- yaml::read_yaml(rogtemplate_file("brand_yml/_brand.yml"))
  brand_dir <- dirname(rogtemplate_file("brand_yml/_brand.yml"))

  expect_true(file.exists(rogtemplate_file("brand_yml/_brand.yml")))
  expect_false(file.exists(file.path(brand_dir, "_brand.yaml")))
  expect_equal(
    brand[c("color", "typography", "defaults")],
    config$template$bslib$brand
  )
})

test_that("bundled brand selects light and dark rOpenGov header logos", {
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

test_that("dark danger text meets WCAG AA contrast", {
  brand <- yaml::read_yaml(rogtemplate_file("brand_yml/_brand.yml"))
  defaults <- brand$defaults$bootstrap$defaults
  body_bg <- defaults[["body-bg-dark"]]
  danger <- defaults[["danger-text-emphasis-dark"]]

  expect_equal(body_bg, "#262b30")
  expect_equal(danger, "#ee99a1")
  expect_gte(contrast_ratio(danger, body_bg), 4.5)
})

test_that("dark code text is readable on supported backgrounds", {
  brand <- yaml::read_yaml(rogtemplate_file("brand_yml/_brand.yml"))
  palette <- brand$color$palette
  defaults <- brand$defaults$bootstrap$defaults
  code <- palette[["code-dark"]]

  expect_equal(code, "#f19ac6")
  expect_equal(defaults[["code-font-size"]], "0.875em")
  expect_equal(defaults[["code-bg"]], "transparent")
  expect_equal(defaults[["code-color"]], "$brand-code")
  expect_equal(defaults[["code-color-dark"]], "$brand-code_dark")
  expect_gte(contrast_ratio(code, "#262b30"), 4.5)
  expect_gte(contrast_ratio(code, "#343a40"), 4.5)
  expect_gt(yiq_brightness(code), 128)
})

test_that("dark brand colors meet WCAG AA contrast", {
  brand <- yaml::read_yaml(rogtemplate_file("brand_yml/_brand.yml"))
  palette <- brand$color$palette
  body_bg <- "#262b30"

  expect_gte(contrast_ratio(palette$orange, body_bg), 4.5)
  expect_gte(contrast_ratio(palette$white, body_bg), 4.5)
  expect_gte(
    contrast_ratio(palette[["logo-gray-light"]], body_bg),
    4.5
  )
})

test_that("dark syntax colors meet WCAG AA contrast", {
  code_bg <- "#343a40"

  expect_gte(contrast_ratio("#85c0ff", code_bg), 4.5)
  expect_gte(contrast_ratio("#ffa366", code_bg), 4.5)
  expect_gte(contrast_ratio("#7eca8f", code_bg), 4.5)
  expect_gte(contrast_ratio("#ee99a1", code_bg), 4.5)
  expect_gte(contrast_ratio("#ffffff", code_bg), 4.5)
})

test_that("pkgdown Bootstrap defaults resolve through the brand palette", {
  brand <- yaml::read_yaml(rogtemplate_file("brand_yml/_brand.yml"))
  defaults <- brand$defaults$bootstrap$defaults

  expected <- list(
    "navbar-light-bg" = "$brand-gray_dark",
    "navbar-dark-bg" = "$brand-gray_dark",
    "pkgdown-footer-bg" = "$brand-gray_dark",
    "dropdown-bg" = "$brand-gray_dark",
    "dropdown-dark-bg" = "$brand-gray_dark",
    "navbar-brand-font-size" = "1.5rem",
    "blockquote-font-size" = "1.25rem",
    "body-bg-dark" = "#262b30",
    "danger-text-emphasis-dark" = "#ee99a1",
    "dropdown-link-active-bg" = "rgba(255, 102, 0, .05)",
    "dropdown-link-active-color" = "$brand-white",
    "dropdown-link-color" = "rgba(255, 255, 255, .75)",
    "dropdown-link-hover-color" = "$brand-white",
    "dropdown-link-hover-bg" = "rgba(255, 102, 0, .05)",
    "dropdown-header-color" = "$brand-white",
    "dropdown-dark-link-active-bg" = "rgba(255, 102, 0, .05)",
    "dropdown-dark-link-active-color" = "$brand-white",
    "dropdown-dark-link-color" = "rgba(255, 255, 255, .75)",
    "dropdown-dark-link-hover-color" = "$brand-white",
    "dropdown-dark-link-hover-bg" = "rgba(255, 102, 0, .05)",
    "dropdown-dark-header-color" = "$brand-white",
    "navbar-light-color" = "rgba(255, 255, 255, .75)",
    "navbar-light-hover-color" = "$brand-white",
    "navbar-dark-hover-color" = "$brand-white",
    "navbar-dark-color" = "rgba(255, 255, 255, .75)",
    "pkgdown-footer-color" = "rgba(255, 255, 255, 0.75)",
    "navbar-light-brand-color" = "$brand-white",
    "navbar-dark-brand-color" = "$brand-white"
  )

  expect_equal(defaults[names(expected)], expected)
  expect_gte(contrast_ratio_alpha("#fff", "#343a40", 0.75), 4.5)
})

test_that("light template colors preserve the rOpenGov brand", {
  brand <- yaml::read_yaml(rogtemplate_file("brand_yml/_brand.yml"))
  palette <- brand$color$palette

  expected <- list(
    blue = "#007bff",
    orange = "#ff6600",
    gray = "#6c757d",
    "gray-dark" = "#343a40",
    "logo-gray" = "#666666",
    "logo-gray-dark" = "#4d4d4d",
    "logo-gray-light" = "#b4b4b4",
    "jumbotron-bg" = "#e9ecef"
  )

  expect_equal(palette[names(expected)], expected)
  expect_equal(brand$color$foreground, "#212529")
  expect_equal(brand$color$background, "white")
  expect_equal(brand$color$primary, "blue")
  expect_equal(brand$color$warning, "orange")
  expect_gte(contrast_ratio(palette$orange, "#212529"), 4.5)
})
