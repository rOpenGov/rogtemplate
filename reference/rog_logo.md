# Creates a logo for your rOpenGov package

Creates a logo automatically with
[`hexSticker::sticker()`](https://rdrr.io/pkg/hexSticker/man/sticker.html).
Optionally, create also favicons with
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

  Name of the package. If not present it would be autodetected by the
  function.

- filename:

  filename to save sticker

- p_x:

  x position for package name

- p_y:

  y position for package name

- p_size:

  font size for package name

- overwrite:

  Should the current logo be overwritten? When `TRUE` it would run
  [`usethis::use_logo()`](https://usethis.r-lib.org/reference/use_logo.html).

- favicons:

  Logical, do you want to create favicons with
  [`pkgdown::build_favicons()`](https://pkgdown.r-lib.org/reference/build_favicons.html)?

## See also

[`hexSticker::sticker()`](https://rdrr.io/pkg/hexSticker/man/sticker.html),
[`usethis::use_logo()`](https://usethis.r-lib.org/reference/use_logo.html),
[`pkgdown::build_favicons()`](https://pkgdown.r-lib.org/reference/build_favicons.html).

Other extras:
[`rog_add_template_pkgdown()`](https://ropengov.github.io/rogtemplate/reference/rog_add_template_pkgdown.md),
[`rog_badge_ropengov()`](https://ropengov.github.io/rogtemplate/reference/rog_badge_ropengov.md),
[`rog_load_font()`](https://ropengov.github.io/rogtemplate/reference/rog_load_font.md),
[`rog_pals`](https://ropengov.github.io/rogtemplate/reference/rog_pals.md)

## Examples

``` r
tmp <- tempfile(fileext = ".png")
rog_logo("test a package", tmp, overwrite = FALSE, favicons = FALSE)
#> B612 Mono font loaded
#> Logo created on /tmp/RtmpgCDbDq/file1b846de0384e.png

# Display
logo <- magick::image_read(tmp)

logo
#> # A tibble: 1 × 7
#>   format width height colorspace matte filesize density
#>   <chr>  <int>  <int> <chr>      <lgl>    <int> <chr>  
#> 1 PNG      518    600 sRGB       TRUE     32695 118x118

plot(logo)
```
