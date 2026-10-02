# Load the rogtemplate font

Load the current rOpenGov font, [B612
Mono](https://fonts.google.com/specimen/B612+Mono).

## Usage

``` r
rog_load_font()
```

## Value

A [character](https://rdrr.io/r/base/character.html) string containing
the font family name, `"B612 Mono"`.

## See also

[sysfonts](https://CRAN.R-project.org/package=sysfonts)'s
[`sysfonts::font_add()`](https://rdrr.io/pkg/sysfonts/man/font_add.html)
for registering fonts and
[showtext](https://CRAN.R-project.org/package=showtext)'s
[`showtext::showtext_auto()`](https://rdrr.io/pkg/showtext/man/showtext_auto.html)
for rendering them in plots.

Package asset helpers:
[`rog_badge_ropengov()`](https://ropengov.github.io/rogtemplate/reference/rog_badge_ropengov.md),
[`rog_logo()`](https://ropengov.github.io/rogtemplate/reference/rog_logo.md)

## Examples

``` r
rog_load_font()
#> ✔ Loaded the "B612 Mono" font.
#> [1] "B612 Mono"
```
