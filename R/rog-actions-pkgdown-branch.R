#' Deploy a pkgdown site with GitHub Actions
#'
#' Create a GitHub Action workflow that builds a \CRANpkg{pkgdown} site from
#' your package and deploys it to the `gh-pages` branch.
#'
#' @param pkg Path to the package.
#' @param overwrite Whether to overwrite the workflow if it already exists.
#' @returns The function is called for its side effects and returns
#'   `invisible(NULL)`.
#' @family site
#' @export
#' @encoding UTF-8
rog_actions_pkgdown_branch <- function(pkg = ".", overwrite = TRUE) {
  usethis::local_project(pkg, force = TRUE)

  # Ensure that the GitHub Actions workflow directory exists.

  destdir <- file.path(".github", "workflows")
  checkdir <- dir.exists(destdir)
  if (isFALSE(checkdir)) {
    dir.create(destdir, recursive = TRUE)
  }

  usethis::use_build_ignore(".github")
  usethis::use_build_ignore("._pkgdown.yml")

  # Ignore transient workflow files generated during local runs.
  usethis::use_git_ignore("*.html", directory = ".github")
  usethis::use_git_ignore("R-version", directory = ".github")
  usethis::use_git_ignore("*.Rds", directory = ".github")

  # Locate the bundled GitHub Actions workflow.
  filepath <- system.file(
    "yaml/rogtemplate-gh-pages.yaml",
    package = "rogtemplate"
  )

  # Copy the workflow into the package.
  result <- file.copy(filepath, destdir, overwrite = overwrite)
  if (result) {
    cli::cli_inform(c(
      "v" = paste(
        "Added workflow to",
        "{.file {file.path(destdir, basename(filepath))}}."
      )
    ))
  } else {
    cli::cli_inform(c(
      "!" = paste(
        "Workflow at",
        "{.file {file.path(destdir, basename(filepath))}} was not updated."
      )
    ))
  }

  invisible()
}
