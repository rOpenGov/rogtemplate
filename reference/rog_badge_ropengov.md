# Add a rOpenGov badge to your `README` file

Add an rOpenGov badge pointing to <https://ropengov.org/> on your
`README` file:

[![rOpenGov](figures/ropengov-badge.svg)](https://ropengov.org/)

## Usage

``` r
rog_badge_ropengov(install = TRUE)
```

## Arguments

- install:

  TRUE/FALSE. On TRUE the badge would be installed on your
  README.md/.Rmd. On FALSE a message with the Rmarkdown code would be
  displayed.

## Value

A markdown badge or a message with the markdown code to be pasted.

## See also

[`usethis::use_badge()`](https://usethis.r-lib.org/reference/badges.html)

Other extras:
[`rog_add_template_pkgdown()`](https://ropengov.github.io/rogtemplate/reference/rog_add_template_pkgdown.md),
[`rog_load_font()`](https://ropengov.github.io/rogtemplate/reference/rog_load_font.md),
[`rog_logo()`](https://ropengov.github.io/rogtemplate/reference/rog_logo.md),
[`rog_pals`](https://ropengov.github.io/rogtemplate/reference/rog_pals.md)

## Examples

``` r
rog_badge_ropengov(install = FALSE)
#> Badge URL is 
#> [![rOG-badge](https://ropengov.github.io/rogtemplate/reference/figures/ropengov-badge.svg)](https://ropengov.org/)
```
