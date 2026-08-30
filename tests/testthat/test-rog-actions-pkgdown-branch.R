test_that("bundled workflow builds missing logos and deploys pkgdown sites", {
  workflow_path <- rogtemplate_file("yaml/rogtemplate-gh-pages.yaml")
  workflow <- yaml::read_yaml(workflow_path)
  workflow_text <- paste(readLines(workflow_path), collapse = "\n")

  expect_equal(workflow$permissions$contents, "write")
  expect_match(workflow_text, "rogtemplate::rog_logo", fixed = TRUE)
  expect_match(
    workflow_text,
    "rogtemplate::rog_add_template_pkgdown",
    fixed = TRUE
  )
  expect_match(workflow_text, "pkgdown::deploy_to_branch", fixed = TRUE)
})

test_that("rog_actions_pkgdown_branch() installs a deployable workflow", {
  pkg <- local_test_package()

  expect_message(
    result <- rog_actions_pkgdown_branch(pkg = pkg),
    "Added workflow to"
  )

  workflow_path <- file.path(
    pkg,
    ".github",
    "workflows",
    "rogtemplate-gh-pages.yaml"
  )
  source_workflow <- rogtemplate_file("yaml/rogtemplate-gh-pages.yaml")
  build_ignore <- readLines(file.path(pkg, ".Rbuildignore"))
  git_ignore <- readLines(file.path(pkg, ".github", ".gitignore"))

  expect_null(result)
  expect_equal(readLines(workflow_path), readLines(source_workflow))
  expect_setequal(
    build_ignore,
    c("^\\.github$", "^\\._pkgdown\\.yml$")
  )
  expect_setequal(git_ignore, c("*.html", "R-version", "*.Rds"))
})
