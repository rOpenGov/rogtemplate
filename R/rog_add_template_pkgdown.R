#' Configure `rogtemplate` for your pkgdown site
#'
#' Add the corresponding configuration to your `_pkgdown.yml`. If it is not
#' present, it would create a file on `pkgdown/_pkgdown.yml`. It would also
#' add the corresponding lines to your .Rbuildignore.
#'
#' It also adds the corresponding urls to the `_pkgdown.yml` file and the
#' DESCRIPTION file if not present:
#' * https://ropengov.github.io/pkgname/
#' * https://github.com/ropengov/pkgname
#'
#' @family extras
#'
#' @seealso `vignette("pkgdown", package = "pkgdown")`,
#' `vignette("linking", package = "pkgdown")`,
#' [usethis::use_tidy_description()].
#'
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

  # Add auto linking to description
  desc_path <- file.path(normalizePath("."), "DESCRIPTION")

  pkg <- desc::desc_normalize(desc_path)

  urls <- pkg$get_urls()
  issues <- paste0(repo, "/issues")

  # Add url if no present
  if (isFALSE(tolower(pkgurl) %in% tolower(urls))) {
    urls <- c(urls, pkgurl)
  }

  # Add repo if no present

  if (isFALSE(tolower(repo) %in% tolower(urls))) {
    urls <- c(urls, repo)
  }

  pkg$set_urls(urls)

  pkg$set("BugReports", issues)
  pkg$set("X-schema.org-isPartOf", "http://ropengov.org/")

  # Add keywords
  key <- pkg$get("X-schema.org-keywords")
  key <- unique(c("ropengov", unlist(strsplit(key, ","))))
  key <- key[!is.na(key)]
  key <- trimws(key)
  key <- paste(key, collapse = ", ")
  pkg$set("X-schema.org-keywords", key)

  pkg$write(desc_path)

  usethis::use_tidy_description()

  # template
  template <- list(
    url = paste0("https://ropengov.github.io/", pkgname, "/"),
    template = list(
      bootstrap = 5,
      package = "rogtemplate",
      path = NULL,
      opengraph = list(
        twitter = list(site = "@rOpenGov")
      ),
      params = list(bootswatch = NULL)
    )
  )

  # Detect _pkgdown.yml

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

  message("rogtemplate added to ", path)

  return(invisible())
}
