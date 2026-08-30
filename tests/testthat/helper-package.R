local_test_package <- function(
  package = "tmpkg",
  .local_envir = parent.frame()
) {
  pkg <- withr::local_tempdir(
    pattern = "rogtemplate-",
    .local_envir = .local_envir
  )

  writeLines(
    c(
      paste("Package:", package),
      "Title: Temporary Package",
      "Version: 0.0.0.9000",
      paste0(
        "Authors@R: person(\"A\", \"B\", email = \"a@example.com\", ",
        "role = c(\"aut\", \"cre\"))"
      ),
      "Description: A temporary package used to test rogtemplate.",
      "License: MIT",
      "Encoding: UTF-8"
    ),
    file.path(pkg, "DESCRIPTION")
  )

  pkg
}
