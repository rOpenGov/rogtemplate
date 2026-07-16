#' Build your pkgdown site locally
#'
#' A wrapper around \CRANpkg{pkgdown}'s [`pkgdown::build_site()`].
#'
#' @details
#' This function also calls [rog_add_template_pkgdown()] and [rog_logo()].
#'
#' @inheritParams rog_actions_pkgdown_branch
#' @param ... Arguments passed to [rog_logo()] and \CRANpkg{pkgdown}'s
#'   [`pkgdown::build_site()`]. Common arguments for [rog_logo()] include
#'   `overwrite`, `favicons`, `p_x`, `p_y` and `p_size`.
#' @returns The function is called for its side effects and returns
#'   `invisible(NULL)`.
#' @family site
#' @seealso \CRANpkg{pkgdown}'s [pkgdown::build_site()] and
#'   [rog_add_template_pkgdown()].
#' @encoding UTF-8
#' @export
rog_build <- function(pkg = ".", ...) {
  # nocov start
  usethis::local_project(pkg, force = TRUE)
  dots <- list(...)
  logo_arg <- names(dots) %in% names(formals(rog_logo))
  logo_dots <- dots[logo_arg]
  build_dots <- dots[!logo_arg]

  # Keep generated site assets out of the package build.

  usethis::use_build_ignore(".github")
  usethis::use_build_ignore("._pkgdown.yml")

  do.call(rogtemplate::rog_logo, logo_dots)
  rogtemplate::rog_add_template_pkgdown()

  do.call(pkgdown::build_site, c(list(pkg = "."), build_dots))
  invisible()
  # nocov end
}
