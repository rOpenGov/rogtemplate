#' Configure rogtemplate for your pkgdown site
#'
#' Add the rOpenGov template configuration to your `_pkgdown.yml`. If no
#' configuration file exists, create one at `pkgdown/_pkgdown.yml`. Also add the
#' corresponding paths to `.Rbuildignore`.
#'
#' The function also adds these package URLs to `_pkgdown.yml` and DESCRIPTION
#' if they are not already present:
#' - https://ropengov.github.io/pkgname/
#' - https://github.com/rOpenGov/pkgname
#'
#' @returns The function is called for its side effects and returns
#'   `invisible(NULL)`.
#' @family site
#' @seealso \CRANpkg{pkgdown} vignettes:
#'   `vignette("pkgdown", package = "pkgdown")` and
#'   `vignette("linking", package = "pkgdown")`,
#'   \CRANpkg{usethis}'s [usethis::use_tidy_description()].
#' @encoding UTF-8
#' @export
#' @examples
#' \dontrun{
#' rog_add_template_pkgdown()
#' }
#'
rog_add_template_pkgdown <- function() {
  pkgname <- package_name()

  pkgurl <- paste0("https://ropengov.github.io/", pkgname, "/")
  repo <- paste0("https://github.com/rOpenGov/", pkgname)

  # Prepare DESCRIPTION for automatic links in pkgdown.
  desc_path <- file.path(normalizePath("."), "DESCRIPTION")

  pkg <- desc::desc_normalize(desc_path)

  urls <- pkg$get_urls()
  issues <- paste0(repo, "/issues")

  # Add the package site URL if it is not already present.
  if (isFALSE(tolower(pkgurl) %in% tolower(urls))) {
    urls <- c(urls, pkgurl)
  }

  # Add the package repository URL if it is not already present.
  if (isFALSE(tolower(repo) %in% tolower(urls))) {
    urls <- c(urls, repo)
  }

  pkg$set_urls(urls)

  pkg$set("BugReports", issues)
  pkg$set("X-schema.org-isPartOf", "https://ropengov.org/")

  # Ensure that schema.org keywords include rOpenGov.
  key <- pkg$get("X-schema.org-keywords")
  key <- unique(c("ropengov", unlist(strsplit(key, ","))))
  key <- key[!is.na(key)]
  key <- trimws(key)
  key <- paste(key, collapse = ", ")
  pkg$set("X-schema.org-keywords", key)

  pkg$write(desc_path)

  usethis::use_tidy_description()

  # Define the pkgdown template configuration.
  template <- list(
    url = paste0("https://ropengov.github.io/", pkgname, "/"),
    template = list(
      bootstrap = 5,
      package = "rogtemplate",
      path = NULL,
      bootswatch = NULL,
      bslib = NULL,
      opengraph = list(twitter = list(site = "@rOpenGov")),
      params = list(bootswatch = NULL)
    )
  )

  # Prefer the root pkgdown file, then fall back to pkgdown/_pkgdown.yml.

  file_exist <- FALSE
  path <- "_pkgdown.yml"

  if (file.exists(path)) {
    file_exist <- TRUE
  }

  if (!file_exist) {
    path <- file.path("pkgdown", "_pkgdown.yml")
    if (file.exists(path)) file_exist <- TRUE
  }

  if (file_exist) {
    newfile <- yaml::read_yaml(path)
    newfile <- modifyList(newfile, template, keep.null = FALSE)
    newfile$template$path <- NULL

    if (
      length(newfile$template$params) == 1 &&
        "bootswatch" %in% names(newfile$template$params)
    ) {
      newfile <- modifyList(
        newfile,
        list(template = list(params = NULL)),
        keep.null = FALSE
      )
    }
  } else {
    template_blank <- template
    template_blank$template$path <- NULL
    template_blank$template$params <- NULL
    newfile <- template_blank
  }

  dir <- dirname(path)

  if (!dir.exists(dir)) {
    dir.create(dir)
  }

  yaml::write_yaml(newfile, file = path)

  usethis::use_build_ignore("pkgdown")
  usethis::use_build_ignore("_pkgdown.yml")

  message("rogtemplate added to ", path, ".")

  invisible()
}
