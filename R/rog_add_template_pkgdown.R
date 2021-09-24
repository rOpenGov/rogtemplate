#' Configure `rogtemplate` for your pkgdown site
#'
#' @family extras
#'
#' Add the corresponding configuration to your `_pkgdown.yml`. If it is not
#' present, it would create a file on `pkgdown/_pkgdown.yml`. It would also
#' add the corresponding lines to your .Rbuildignore
#'
#'
#'
#' @seealso `vignette("pkgdown", package = "pkgdown")`,
#'
#' @export
#' @examples
#' \dontrun{
#' rog_add_template_pkgdown()
#' }
#'
rog_add_template_pkgdown <- function() {
  # template
  template <- list(template = list(
    package = "rogtemplate",
    path = NULL,
    params =
      list(bootswatch = NULL)
  ))


  # Detect _pkgdown.yml

  file_exist <- FALSE
  path <- "_pkgdown.yml"

  if (file.exists(path)) file_exist <- TRUE

  if (!file_exist) {
    path <- file.path("pkgdown", "_pkgdown.yml")
    if (file.exists(path)) file_exist <- TRUE
  }

  if (file_exist) {
    newfile <- yaml::read_yaml(path)
    newfile <- modifyList(newfile, template)

    if (length(newfile$template$params) == 0) {
      newfile <- modifyList(
        newfile,
        list(template = list(params = NULL))
      )
    }
  } else {
    newfile <- template
  }




  dir <- dirname(path)

  if (!dir.exists(dir)) dir.create(dir)

  yaml::write_yaml(newfile, file = path)

  usethis::use_build_ignore("pkgdown")
  usethis::use_build_ignore("_pkgdown.yml")

  message("rogtemplate added to ", path)

  return(invisible())
}
