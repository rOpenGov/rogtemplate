#' Build your pkgdown site locally
#'
#' A wrapper around \CRANpkg{pkgdown}'s [`pkgdown::build_site()`].
#'
#' @details
#' This function also calls [rog_add_template_pkgdown()] and [rog_logo()].
#'
#' @inheritParams rog_actions_pkgdown_branch
#' @inheritDotParams rog_logo overwrite favicons p_x p_y p_size
#' @inheritDotParams pkgdown::build_site examples preview new_process install
#' @returns The function is called for its side effects and returns
#'   `invisible(NULL)`.
#' @seealso \CRANpkg{pkgdown}'s [pkgdown::build_site()].
#' @family site
#' @export
#' @encoding UTF-8
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

  do.call(build_pkgdown_site, c(list(pkg = "."), build_dots))
  invisible()
  # nocov end
}

build_pkgdown_site <- function(...) {
  pkgdown::build_site(...)
}
