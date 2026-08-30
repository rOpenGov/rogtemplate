# Deploy a pkgdown site with GitHub Actions

Create a GitHub Action workflow that builds a
[pkgdown](https://CRAN.R-project.org/package=pkgdown) site from your
package and deploys it to the `gh-pages` branch.

## Usage

``` r
rog_actions_pkgdown_branch(pkg = ".", overwrite = TRUE)
```

## Arguments

- pkg:

  Path to the package.

- overwrite:

  Whether to overwrite the workflow if it already exists.

## Value

The function is called for its side effects and returns
`invisible(NULL)`.

## See also

Site setup helpers:
[`rog_add_template_pkgdown()`](https://ropengov.github.io/rogtemplate/reference/rog_add_template_pkgdown.md),
[`rog_build()`](https://ropengov.github.io/rogtemplate/reference/rog_build.md)
