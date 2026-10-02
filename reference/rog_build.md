# Build your pkgdown site locally

A wrapper around [pkgdown](https://CRAN.R-project.org/package=pkgdown)'s
[`pkgdown::build_site()`](https://pkgdown.r-lib.org/reference/build_site.html).

## Usage

``` r
rog_build(pkg = ".", ...)
```

## Arguments

- pkg:

  Path to the package.

- ...:

  Arguments passed on to
  [`rog_logo`](https://ropengov.github.io/rogtemplate/reference/rog_logo.md),
  [`pkgdown::build_site`](https://pkgdown.r-lib.org/reference/build_site.html)

  `overwrite`

  :   Whether to overwrite the current logo. If `FALSE` and `filename`
      already exists, save the new logo to a temporary file instead.

  `favicons`

  :   Whether to create favicons with
      [pkgdown](https://CRAN.R-project.org/package=pkgdown)'s
      [`pkgdown::build_favicons()`](https://pkgdown.r-lib.org/reference/build_favicons.html)
      when `filename` is `"man/figures/logo.png"`.

  `p_x`

  :   x position for package name

  `p_y`

  :   y position for package name

  `p_size`

  :   font size for package name

  `examples`

  :   Run examples?

  `preview`

  :   If `TRUE`, or `is.na(preview) && interactive()`, will preview
      freshly generated section in browser.

  `new_process`

  :   If `TRUE`, will run `build_site()` in a separate process. This
      enhances reproducibility by ensuring nothing that you have loaded
      in the current process affects the build process.

  `install`

  :   If `TRUE`, will install the package in a temporary library so it
      is available for vignettes.

## Value

This function is called for its side effects and returns
[`NULL`](https://rdrr.io/r/base/NULL.html) invisibly.

## Details

This function also calls
[`rog_add_template_pkgdown()`](https://ropengov.github.io/rogtemplate/reference/rog_add_template_pkgdown.md)
and
[`rog_logo()`](https://ropengov.github.io/rogtemplate/reference/rog_logo.md).

## See also

[`rog_logo()`](https://ropengov.github.io/rogtemplate/reference/rog_logo.md)
for logo and favicon options, and
[pkgdown](https://CRAN.R-project.org/package=pkgdown)'s
[`pkgdown::build_site()`](https://pkgdown.r-lib.org/reference/build_site.html)
for site build options.

Site setup helpers:
[`rog_actions_pkgdown_branch()`](https://ropengov.github.io/rogtemplate/reference/rog_actions_pkgdown_branch.md),
[`rog_add_template_pkgdown()`](https://ropengov.github.io/rogtemplate/reference/rog_add_template_pkgdown.md)
