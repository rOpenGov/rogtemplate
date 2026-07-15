# Add an rOpenGov badge to your README

Add an rOpenGov badge pointing to <https://ropengov.org/> to your
README:

## Usage

``` r
rog_badge_ropengov(install = TRUE)
```

## Arguments

- install:

  `TRUE` or `FALSE`. If `TRUE`, the badge is installed on your
  `README.md` or `README.Rmd`. If `FALSE`, a message with the R Markdown
  code is displayed.

## Value

The function is called for its side effects and returns `NULL`
invisibly.

## Details

[![ options: alt=](figures/ropengov-badge.svg)](https://ropengov.org/)

## See also

[usethis](https://CRAN.R-project.org/package=usethis)'s
[`usethis::use_badge()`](https://usethis.r-lib.org/reference/badges.html).

package asset helpers:
[`rog_load_font()`](https://ropengov.github.io/rogtemplate/reference/rog_load_font.md),
[`rog_logo()`](https://ropengov.github.io/rogtemplate/reference/rog_logo.md)

## Examples

``` r
rog_badge_ropengov(install = FALSE)
#> Badge Markdown is 
#> [![rOpenGov package](https://ropengov.github.io/rogtemplate/reference/figures/ropengov-badge.svg)](https://ropengov.org/)
```
