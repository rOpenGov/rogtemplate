# Build your pkgdown website locally

A wrapper of
[`pkgdown::build_site()`](https://pkgdown.r-lib.org/reference/build_site.html)

## Usage

``` r
rog_build(pkg = ".", ...)
```

## Arguments

- pkg:

  Path to package.

- ...:

  Arguments passed on to
  [`rog_logo`](https://ropengov.github.io/rogtemplate/reference/rog_logo.md),
  [`pkgdown::build_site`](https://pkgdown.r-lib.org/reference/build_site.html)

  `overwrite`

  :   Should the current logo be overwritten? When `TRUE` it would run
      [`usethis::use_logo()`](https://usethis.r-lib.org/reference/use_logo.html).

  `favicons`

  :   Logical, do you want to create favicons with
      [`pkgdown::build_favicons()`](https://pkgdown.r-lib.org/reference/build_favicons.html)?

  `p_x`

  :   x position for package name

  `p_y`

  :   y position for package name

  `p_size`

  :   font size for package name

  `examples`

  :   Run examples?

  `run_dont_run`

  :   Run examples that are surrounded in \dontrun?

  `seed`

  :   Seed used to initialize random number generation in order to make
      article output reproducible. An integer scalar or `NULL` for no
      seed.

  `lazy`

  :   If `TRUE`, will only rebuild articles and reference pages if the
      source is newer than the destination.

  `preview`

  :   If `TRUE`, or `is.na(preview) && interactive()`, will preview
      freshly generated section in browser.

  `devel`

  :   Use development or deployment process?

      If `TRUE`, uses lighter-weight process suitable for rapid
      iteration; it will run examples and vignettes in the current
      process, and will load code with
      [`pkgload::load_all()`](https://pkgload.r-lib.org/reference/load_all.html).

      If `FALSE`, will first install the package to a temporary library,
      and will run all examples and vignettes in a new process.

      `build_site()` defaults to `devel = FALSE` so that you get high
      fidelity outputs when you building the complete site;
      `build_reference()`, `build_home()` and friends default to
      `devel = TRUE` so that you can rapidly iterate during development.

  `new_process`

  :   If `TRUE`, will run `build_site()` in a separate process. This
      enhances reproducibility by ensuring nothing that you have loaded
      in the current process affects the build process.

  `install`

  :   If `TRUE`, will install the package in a temporary library so it
      is available for vignettes.

## Details

This function would call also
[`rog_add_template_pkgdown()`](https://ropengov.github.io/rogtemplate/reference/rog_add_template_pkgdown.md)
and
[`rog_logo()`](https://ropengov.github.io/rogtemplate/reference/rog_logo.md).

## See also

[`pkgdown::build_site()`](https://pkgdown.r-lib.org/reference/build_site.html),
[`rog_add_template_pkgdown()`](https://ropengov.github.io/rogtemplate/reference/rog_add_template_pkgdown.md).
