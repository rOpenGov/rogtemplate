#' Build your pkgdown website locally
#'
#' A wrapper of [`pkgdown::build_site()`]
#'
#' @details
#' This function would ask for confirmation to check your `_pkgdown.yml` file
#' and would create your pkgdown site on the `docs/` folder.
#'
#'
#' @seealso [`pkgdown::build_site()`]
#'
#' @export
#'
#' @inheritParams pkgdown::build_site
#'
#' @inheritDotParams pkgdown::build_site
#'
#'
#'
rog_build <- function(pkg = ".", ...) {

  # nocov start
  # Check .Rbuildignore

  usethis::use_build_ignore(".github")
  usethis::use_build_ignore("._pkgdown.yml")


  sel <-
    menu(c("Yes", "No"),
      title = "Have you included \n\ntemplate:\n  package: rogtemplate\n\nin your _pkgdown.yml file?"
    )
  if (sel != 1) {
    stop("Execution halted")
  }

  pkgdown::build_site(pkg = ".", ...)
  return(invisible())
  # nocov end
}
