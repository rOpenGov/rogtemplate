# Create a logo for your rOpenGov package

Creates a logo automatically with
[hexSticker](https://CRAN.R-project.org/package=hexSticker)'s
[`hexSticker::sticker()`](https://rdrr.io/pkg/hexSticker/man/sticker.html).
Optionally, create favicons with
[pkgdown](https://CRAN.R-project.org/package=pkgdown)'s
[`pkgdown::build_favicons()`](https://pkgdown.r-lib.org/reference/build_favicons.html).

## Usage

``` r
rog_logo(
  pkgname,
  filename = "man/figures/logo.png",
  p_x = 1,
  p_y = 1,
  p_size = 202.6 * nchar(pkgname)^-1.008,
  overwrite = FALSE,
  favicons = TRUE
)
```

## Arguments

- pkgname:

  Name of the package. If not supplied, the name is detected from
  DESCRIPTION.

- filename:

  filename to save sticker

- p_x:

  x position for package name

- p_y:

  y position for package name

- p_size:

  font size for package name

- overwrite:

  Should the current logo be overwritten? When `TRUE` it runs
  [usethis](https://CRAN.R-project.org/package=usethis)'s
  [`usethis::use_logo()`](https://usethis.r-lib.org/reference/use_logo.html).

- favicons:

  Should favicons be created with
  [pkgdown](https://CRAN.R-project.org/package=pkgdown)'s
  [`pkgdown::build_favicons()`](https://pkgdown.r-lib.org/reference/build_favicons.html)?

## Value

The function is called for its side effects and returns `NULL`
invisibly.

## See also

[hexSticker](https://CRAN.R-project.org/package=hexSticker)'s
[`hexSticker::sticker()`](https://rdrr.io/pkg/hexSticker/man/sticker.html),
[usethis](https://CRAN.R-project.org/package=usethis)'s
[`usethis::use_logo()`](https://usethis.r-lib.org/reference/use_logo.html)
and [pkgdown](https://CRAN.R-project.org/package=pkgdown)'s
[`pkgdown::build_favicons()`](https://pkgdown.r-lib.org/reference/build_favicons.html).

package asset helpers:
[`rog_badge_ropengov()`](https://ropengov.github.io/rogtemplate/reference/rog_badge_ropengov.md),
[`rog_load_font()`](https://ropengov.github.io/rogtemplate/reference/rog_load_font.md)

## Examples

``` r
tmp <- tempfile(fileext = ".png")
rog_logo("test a package", tmp, overwrite = FALSE, favicons = FALSE)
#> B612 Mono font loaded.
#> Logo created at /tmp/RtmphVK0ib/file1c95370a9d5f.png.

# Display the logo.
logo <- magick::image_read(tmp)

logo
#> # A tibble: 1 × 7
#>   format width height colorspace matte filesize density
#>   <chr>  <int>  <int> <chr>      <lgl>    <int> <chr>  
#> 1 PNG      518    600 sRGB       TRUE     32133 118x118

plot(logo)
```
