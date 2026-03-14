# Creates a GitHub action that deploys on `gh-pages` branch

The GitHub action created would build a `pkgdown` of your package in the
`gh-pages` branch of your repo.

## Usage

``` r
rog_actions_pkgdown_branch(pkg = ".", overwrite = TRUE)
```

## Arguments

- pkg:

  Path to package.

- overwrite:

  Overwrite the action if it was already present.

## See also

[`rog_build()`](https://ropengov.github.io/rogtemplate/reference/rog_build.md)
