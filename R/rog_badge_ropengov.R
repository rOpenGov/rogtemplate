#' Add a rOpenGov badge to your `README` file
#'
#'
#' @description
#'
#' Add an rOpenGov badge pointing to <https://ropengov.org/> on your `README`
#' file:
#'
#' \ifelse{html}{\href{https://ropengov.org/}{\figure{ropengov-badge.svg}{
#' options: alt='rOpenGov'}}}{**rOpenGov**}
#'
#' @export
#'
#' @return A markdown badge or a message with the markdown code to be pasted.
#'
#' @seealso [`usethis::use_badge()`]
#'
#' @param install TRUE/FALSE. On TRUE the badge would be installed on your
#' README.md/.Rmd. On FALSE a message with the Rmarkdown code would be
#' displayed.
#'
#' @family extras
#'
#' @examples
#'
#' rog_badge_ropengov(install = FALSE)
rog_badge_ropengov <- function(install = TRUE) {
  stopifnot(is.logical(install))

  # Add pkg
  badge <- paste0(
    "https://ropengov.github.io/rogtemplate/reference/figures/",
    "ropengov-badge.svg"
  )

  href <- "https://ropengov.org/"

  if (install) {
    # nocov start
    usethis::use_badge("rOpenGov package", href = href, src = badge)
    # nocov end
  } else {
    message(
      "Badge URL is ",
      "\n",
      "[![rOpenGov package](",
      badge,
      ")](",
      href,
      ")"
    )
  }
}
