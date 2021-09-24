#' Build your pkgdown website locally
#'
#' A wrapper of [`pkgdown::build_site()`]
#'
#' @details
#' This function would call also [rog_add_template_pkgdown()] and
#'  [rog_logo()].
#'
#'
#' @seealso [`pkgdown::build_site()`], [rog_add_template_pkgdown()].
#'
#' @export
#'
#' @inheritParams pkgdown::build_site
#'
#' @inheritDotParams rog_logo -pkgname -filename
#'
#' @inheritDotParams pkgdown::build_site -override
#'
#'
#'
rog_build <- function(pkg = ".", ...) {

  # nocov start
  # Check .Rbuildignore

  usethis::use_build_ignore(".github")
  usethis::use_build_ignore("._pkgdown.yml")

  rogtemplate::rog_logo(...)
  rogtemplate::rog_add_template_pkgdown()

  pkgdown::build_site(pkg = ".", ...)
  return(invisible())
  # nocov end
}
