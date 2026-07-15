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
  # Keep generated site assets out of the package build.

  usethis::use_build_ignore(".github")
  usethis::use_build_ignore("._pkgdown.yml")

  rogtemplate::rog_logo(...)
  rogtemplate::rog_add_template_pkgdown()

  pkgdown::build_site(pkg = ".", ...)
  invisible()
  # nocov end
}
