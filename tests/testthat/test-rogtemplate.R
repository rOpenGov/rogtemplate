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
  danger <- sub(
    ".*--bs-danger-text-emphasis: (#[[:xdigit:]]{6});.*",
    "\\1",
    css
  )

  expect_equal(danger, "#ee99a1")
  expect_gte(contrast_ratio(danger, "#394046"), 4.5)
})

test_that("dark mode code text has AA contrast from bslib brand", {
  pkgdown <- yaml::read_yaml(rogtemplate_file("pkgdown/_pkgdown.yml"))
  bootstrap_defaults <- pkgdown$template$bslib$brand$defaults$bootstrap$defaults
  code <- bootstrap_defaults[["code-color-dark"]]

  expect_equal(code, "#f19ac6")
  expect_gte(contrast_ratio(code, "#394046"), 4.5)
  expect_gte(contrast_ratio(code, "#343a40"), 4.5)
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
