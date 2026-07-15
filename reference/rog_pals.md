# rOpenGov color palettes

Color palettes based on the rOpenGov color scheme.

## Usage

``` r
rog_orange_pal(n = 4, alpha = 0.9, rev = FALSE)

rog_dark_pal(n = 4, alpha = 0.9, rev = FALSE)

rog_gradient_pal(n = 4, alpha = 0.9, rev = FALSE)

rog_qualitative_pal(n = 6, alpha = 0.9, rev = FALSE)
```

## Arguments

- n:

  the number of colors (\\\ge 1\\) to be in the palette.

- alpha:

  an alpha-transparency level in the range \[0,1\] (0 means transparent
  and 1 means opaque), see argument `alpha` in
  [`hsv`](https://rdrr.io/r/grDevices/hsv.html) and
  [`hcl`](https://rdrr.io/r/grDevices/hcl.html), respectively.  
  A [`missing`](https://rdrr.io/r/base/missing.html), i.e., not
  explicitly specified `alpha` is equivalent to `alpha = NULL`, which
  does *not* add opacity codes (`"FF"`) to the individual color hex
  codes.

- rev:

  logical indicating whether the ordering of the colors should be
  reversed.

## Value

Color palettes.

## See also

grDevices'
[`grDevices::hcl.colors()`](https://rdrr.io/r/grDevices/palettes.html).

## Examples

``` r
scales::show_col(rog_orange_pal(9))


scales::show_col(rog_dark_pal(9))


scales::show_col(rog_gradient_pal(9))


scales::show_col(rog_qualitative_pal(9))
```
