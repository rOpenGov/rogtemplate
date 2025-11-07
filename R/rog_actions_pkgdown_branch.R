#' Creates a GitHub action that deploys on `gh-pages` branch
#'
#' @description
#'
#' The GitHub action created would build a `pkgdown` of
#' your package in the `gh-pages` branch of your repo.
#'
#' @seealso [rog_build()]
#' @export
#'
#' @param pkg Path to package.
#' @param overwrite Overwrite the action if it was already present.
#'
rog_actions_pkgdown_branch <- function(pkg = ".", overwrite = TRUE) {
  # Check destdir

  destdir <- file.path(pkg, ".github", "workflows")
  checkdir <- dir.exists(destdir)
  if (isFALSE(checkdir)) {
    dir.create(destdir, recursive = TRUE)
  }

  usethis::use_build_ignore(".github")
  usethis::use_build_ignore("._pkgdown.yml")

  # Check gitignore
  usethis::use_git_ignore("*.html", directory = ".github")
  usethis::use_git_ignore("R-version", directory = ".github")
  usethis::use_git_ignore("*.Rds", directory = ".github")

  # Get action file
  filepath <-
    system.file("yaml/rogtemplate-gh-pages.yaml", package = "rogtemplate")

  # Copy
  result <- file.copy(filepath, destdir, overwrite = overwrite)
  if (result) {
    message("Success!")
  } else {
    message("File not updated")
  }

  return(invisible())
}
