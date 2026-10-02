# Create a logo for your rOpenGov package

Create a logo automatically with
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

  Whether to overwrite the current logo. If `FALSE` and `filename`
  already exists, save the new logo to a temporary file instead.

- favicons:

  Whether to create favicons with
  [pkgdown](https://CRAN.R-project.org/package=pkgdown)'s
  [`pkgdown::build_favicons()`](https://pkgdown.r-lib.org/reference/build_favicons.html)
  when `filename` is `"man/figures/logo.png"`.

## Value

This function is called for its side effects and returns
[`NULL`](https://rdrr.io/r/base/NULL.html) invisibly.

## See also

[`rog_build()`](https://ropengov.github.io/rogtemplate/reference/rog_build.md)
to create the logo as part of a local site build.
[hexSticker](https://CRAN.R-project.org/package=hexSticker)'s
[`hexSticker::sticker()`](https://rdrr.io/pkg/hexSticker/man/sticker.html),
[usethis](https://CRAN.R-project.org/package=usethis)'s
[`usethis::use_logo()`](https://usethis.r-lib.org/reference/use_logo.html)
and [pkgdown](https://CRAN.R-project.org/package=pkgdown)'s
[`pkgdown::build_favicons()`](https://pkgdown.r-lib.org/reference/build_favicons.html).

Package asset helpers:
[`rog_badge_ropengov()`](https://ropengov.github.io/rogtemplate/reference/rog_badge_ropengov.md),
[`rog_load_font()`](https://ropengov.github.io/rogtemplate/reference/rog_load_font.md)

## Examples

``` r
tmp <- tempfile(fileext = ".png")
rog_logo("test a package", tmp, overwrite = FALSE, favicons = FALSE)
#> ✔ Loaded the "B612 Mono" font.
#> ✔ Created logo at /tmp/RtmpsiKbxY/file1d3e1c02abef.png.

# Display the logo.
logo <- magick::image_read(tmp)

logo
#> # A tibble: 1 × 7
#>   format width height colorspace matte filesize density
#>   <chr>  <int>  <int> <chr>      <lgl>    <int> <chr>  
#> 1 PNG      518    600 sRGB       TRUE     32133 118x118

plot(logo)
```
