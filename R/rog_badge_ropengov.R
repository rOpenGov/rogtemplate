#' Add an rOpenGov badge to your README
#'
#' Add an rOpenGov badge pointing to <https://ropengov.org/> to your README:
#'
#' \ifelse{html}{\href{https://ropengov.org/}{\figure{ropengov-badge.svg}{
#' options: alt='rOpenGov'}}}{**rOpenGov**}
#'
#' @param install `TRUE` or `FALSE`. If `TRUE`, the badge is installed on your
#'   `README.md` or `README.Rmd`. If `FALSE`, a message with the R Markdown code
#'   is displayed.
#' @returns The function is called for its side effects and returns `NULL`
#'   invisibly.
#' @family assets
#' @seealso \CRANpkg{usethis}'s [usethis::use_badge()].
#' @encoding UTF-8
#' @export
#' @examples
#' rog_badge_ropengov(install = FALSE)
rog_badge_ropengov <- function(install = TRUE) {
  stopifnot(is.logical(install))

  # Point to the shared rOpenGov badge asset.
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
      "Badge Markdown is ",
      "\n",
      "[![rOpenGov package](",
      badge,
      ")](",
      href,
      ")"
    )
  }
}
