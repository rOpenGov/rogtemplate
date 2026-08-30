#' Add an rOpenGov badge to your README
#'
#' Add an rOpenGov badge pointing to <https://ropengov.org/> to your README:
#'
#' \ifelse{html}{\href{https://ropengov.org/}{\figure{ropengov-badge.svg}{
#' options: alt='rOpenGov'}}}{**rOpenGov**}
#'
#' @param install Whether to install the badge in `README.md` or `README.Rmd`.
#'   If `FALSE`, display the R Markdown code instead.
#' @returns The function is called for its side effects and returns `NULL`
#'   invisibly.
#' @seealso \CRANpkg{usethis}'s [usethis::use_badge()].
#' @family assets
#' @export
#' @encoding UTF-8
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
    badge_markdown <- paste0(
      "[![rOpenGov package](",
      badge,
      ")](",
      href,
      ")"
    )
    cli::cli_inform(c(
      "i" = "Markdown for the badge:",
      badge_markdown
    ))
  }
}
