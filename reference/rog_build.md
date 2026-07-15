# Build your pkgdown site locally

A wrapper around [pkgdown](https://CRAN.R-project.org/package=pkgdown)'s
[`pkgdown::build_site()`](https://pkgdown.r-lib.org/reference/build_site.html).

## Usage

``` r
rog_build(pkg = ".", ...)
```

## Arguments

- pkg:

  Path to package.

- ...:

  Arguments passed to
  [`rog_logo()`](https://ropengov.github.io/rogtemplate/reference/rog_logo.md)
  and [pkgdown](https://CRAN.R-project.org/package=pkgdown)'s
  [`pkgdown::build_site()`](https://pkgdown.r-lib.org/reference/build_site.html).
  Common arguments for
  [`rog_logo()`](https://ropengov.github.io/rogtemplate/reference/rog_logo.md)
  include `overwrite`, `favicons`, `p_x`, `p_y` and `p_size`.

## Value

The function is called for its side effects and returns
`invisible(NULL)`.

## Details

This function also calls
[`rog_add_template_pkgdown()`](https://ropengov.github.io/rogtemplate/reference/rog_add_template_pkgdown.md)
and
[`rog_logo()`](https://ropengov.github.io/rogtemplate/reference/rog_logo.md).

## See also

[pkgdown](https://CRAN.R-project.org/package=pkgdown)'s
[`pkgdown::build_site()`](https://pkgdown.r-lib.org/reference/build_site.html)
and
[`rog_add_template_pkgdown()`](https://ropengov.github.io/rogtemplate/reference/rog_add_template_pkgdown.md).

site setup helpers:
[`rog_actions_pkgdown_branch()`](https://ropengov.github.io/rogtemplate/reference/rog_actions_pkgdown_branch.md),
[`rog_add_template_pkgdown()`](https://ropengov.github.io/rogtemplate/reference/rog_add_template_pkgdown.md)
