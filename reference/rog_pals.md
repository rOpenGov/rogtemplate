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

  Number of colors to generate.

- alpha:

  Alpha transparency for the generated colors. Use `1` for fully opaque
  colors.

- rev:

  Should the palette order be reversed?

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
