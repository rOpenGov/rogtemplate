# Create a GitHub Action that deploys a pkgdown site

Create a GitHub Action workflow that builds a
[pkgdown](https://CRAN.R-project.org/package=pkgdown) site from your
package and deploys it to the `gh-pages` branch.

## Usage

``` r
rog_actions_pkgdown_branch(pkg = ".", overwrite = TRUE)
```

## Arguments

- pkg:

  Path to package.

- overwrite:

  Overwrite the workflow if it already exists.

## Value

The function is called for its side effects and returns
`invisible(NULL)`.

## See also

[`rog_build()`](https://ropengov.github.io/rogtemplate/reference/rog_build.md).

site setup helpers:
[`rog_add_template_pkgdown()`](https://ropengov.github.io/rogtemplate/reference/rog_add_template_pkgdown.md),
[`rog_build()`](https://ropengov.github.io/rogtemplate/reference/rog_build.md)
