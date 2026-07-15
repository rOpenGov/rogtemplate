# Configure rogtemplate for your pkgdown site

Add the rOpenGov template configuration to your `_pkgdown.yml`. If no
configuration file exists, create one at `pkgdown/_pkgdown.yml`. Also
add the corresponding paths to `.Rbuildignore`.

## Usage

``` r
rog_add_template_pkgdown()
```

## Value

The function is called for its side effects and returns
`invisible(NULL)`.

## Details

The function also adds these package URLs to `_pkgdown.yml` and
DESCRIPTION if they are not already present:

- https://ropengov.github.io/pkgname/

- https://github.com/ropengov/pkgname

## See also

[pkgdown](https://CRAN.R-project.org/package=pkgdown) vignettes:
[`vignette("pkgdown", package = "pkgdown")`](https://pkgdown.r-lib.org/articles/pkgdown.html)
and
[`vignette("linking", package = "pkgdown")`](https://pkgdown.r-lib.org/articles/linking.html),
[usethis](https://CRAN.R-project.org/package=usethis)'s
[`usethis::use_tidy_description()`](https://usethis.r-lib.org/reference/tidyverse.html).

site setup helpers:
[`rog_actions_pkgdown_branch()`](https://ropengov.github.io/rogtemplate/reference/rog_actions_pkgdown_branch.md),
[`rog_build()`](https://ropengov.github.io/rogtemplate/reference/rog_build.md)

## Examples

``` r
# \dontrun{
rog_add_template_pkgdown()
#> Error: No DESCRIPTION file found.
# }
```
