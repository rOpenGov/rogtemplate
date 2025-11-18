# Configure `rogtemplate` for your pkgdown site

Add the corresponding configuration to your `_pkgdown.yml`. If it is not
present, it would create a file on `pkgdown/_pkgdown.yml`. It would also
add the corresponding lines to your .Rbuildignore.

## Usage

``` r
rog_add_template_pkgdown()
```

## Details

It also adds the corresponding urls to the `_pkgdown.yml` file and the
DESCRIPTION file if not present:

- https://ropengov.github.io/pkgname/

- https://github.com/ropengov/pkgname

## See also

[`vignette("pkgdown", package = "pkgdown")`](https://pkgdown.r-lib.org/articles/pkgdown.html),
[`vignette("linking", package = "pkgdown")`](https://pkgdown.r-lib.org/articles/linking.html),
[`usethis::use_tidy_description()`](https://usethis.r-lib.org/reference/tidyverse.html).

Other extras:
[`rog_badge_ropengov()`](https://ropengov.github.io/rogtemplate/reference/rog_badge_ropengov.md),
[`rog_load_font()`](https://ropengov.github.io/rogtemplate/reference/rog_load_font.md),
[`rog_logo()`](https://ropengov.github.io/rogtemplate/reference/rog_logo.md),
[`rog_pals`](https://ropengov.github.io/rogtemplate/reference/rog_pals.md)

## Examples

``` r
if (FALSE) { # \dontrun{
rog_add_template_pkgdown()
} # }
```
