test_that("rog_add_template_pkgdown() configures a bare rOpenGov package", {
  pkg <- local_test_package("samplepkg")
  withr::local_dir(pkg)
  usethis::local_project(pkg, force = TRUE)

  expect_message(
    result <- rog_add_template_pkgdown(),
    "Added rogtemplate to"
  )

  config <- yaml::read_yaml(file.path("pkgdown", "_pkgdown.yml"))
  description <- read.dcf("DESCRIPTION")
  build_ignore <- readLines(".Rbuildignore")

  expect_null(result)
  expect_equal(config$url, "https://ropengov.github.io/samplepkg/")
  expect_equal(config$template$bootstrap, 5)
  expect_equal(config$template$package, "rogtemplate")
  expect_equal(config$template$opengraph$twitter$site, "@rOpenGov")
  expect_null(config$template$params)
  expect_match(
    description[1, "URL"],
    "https://ropengov.github.io/samplepkg/"
  )
  expect_match(
    description[1, "URL"],
    "https://github.com/rOpenGov/samplepkg"
  )
  expect_equal(
    unname(description[1, "BugReports"]),
    "https://github.com/rOpenGov/samplepkg/issues"
  )
  expect_equal(
    unname(description[1, "X-schema.org-isPartOf"]),
    "https://ropengov.org/"
  )
  expect_match(description[1, "X-schema.org-keywords"], "ropengov")
  expect_setequal(
    build_ignore,
    c("^pkgdown$", "^_pkgdown\\.yml$")
  )
})

test_that("rog_add_template_pkgdown() preserves unrelated site settings", {
  pkg <- local_test_package("samplepkg")
  withr::local_dir(pkg)
  usethis::local_project(pkg, force = TRUE)

  yaml::write_yaml(
    list(
      navbar = list(structure = list(left = c("reference", "news"))),
      template = list(
        bootswatch = "flatly",
        path = "legacy-template",
        params = list(bootswatch = "flatly")
      )
    ),
    "_pkgdown.yml"
  )

  expect_message(rog_add_template_pkgdown(), "Added rogtemplate to")

  config <- yaml::read_yaml("_pkgdown.yml")

  expect_equal(config$navbar$structure$left, c("reference", "news"))
  expect_equal(config$template$package, "rogtemplate")
  expect_null(config$template$bootswatch)
  expect_null(config$template$path)
  expect_null(config$template$params)
  expect_false(file.exists(file.path("pkgdown", "_pkgdown.yml")))
})

test_that("rog_add_template_pkgdown() updates a nested pkgdown config", {
  pkg <- local_test_package("samplepkg")
  withr::local_dir(pkg)
  usethis::local_project(pkg, force = TRUE)
  dir.create("pkgdown")
  yaml::write_yaml(
    list(navbar = list(structure = list(left = "reference"))),
    file.path("pkgdown", "_pkgdown.yml")
  )

  expect_message(
    result <- withVisible(rog_add_template_pkgdown()),
    "Added rogtemplate to"
  )

  config <- yaml::read_yaml(file.path("pkgdown", "_pkgdown.yml"))

  expect_equal(result, list(value = NULL, visible = FALSE))
  expect_equal(config$navbar$structure$left, "reference")
  expect_equal(config$template$package, "rogtemplate")
})
