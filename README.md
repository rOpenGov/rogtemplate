
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rogtemplate <a href='https://dieghernan.github.io/rogtemplate/'><img src='man/figures/logo.png' align="right" height="139" /></a>

<!-- badges: start -->

[![rOG-badge](https://dieghernan.github.io/rogtemplate//reference/figures/ropengov-badge.svg)](http://ropengov.org/)
[![R build
status](https://github.com/dieghernan/rogtemplate/workflows/R-CMD-check/badge.svg)](https://github.com/dieghernan/rogtemplate/actions)
[![lifecycle](https://lifecycle.r-lib.org/articles/figures/lifecycle-experimental.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

This package is a `pkgdown` template adapted to
[rOpenGov](http://ropengov.org/) site.

This is a private template for use by core rOpenGov packages. Please
don’t use it for your own code.

## Project setup

Add a `_pkgdown.yml` file that contains at least these lines:

``` yaml
template:
  package: rogtemplate
```

Also, add a `.Rbuildignore` file on the root of your repo with these
lines:

    ^\.github$
    ^pkgdown$
    ^_pkgdown\.yml$

## Using `rogtemplate`

It is possible to deploy your `pkgdown` site along with `rogtemplate`
via CI (GitHub Actions) or locally, that provides more control but it is
not automatic.

### Option A: Deploy using GitHub Actions

It is not necessary to install `rogtemplate` itself. Just copy [this
file](https://github.com/dieghernan/rogtemplate/blob/main/inst/yaml/rogtemplate-gh-pages.yaml)
into your `.github/workflows/` folder.

The action would create your site in the `gh-pages` branch.

### Option B: Deploy installing `rogtemplate`

Install the package from the GitHub repo.

``` r
library(remotes)
install_github("dieghernan/rogtemplate")
```

**TODO: Include r-universe instructions.**

You can use `rog_actions_pkgdown_branch()` for setting up the action
described before but the deployment would be still performed by a GitHub
action.

For building locally your package into your `docs` folder use:

``` r

rog_actions_pkgdown_branch::rog_build()

# or you can use also

pkgdown::build_site()
```

## Commit to GitHub and deploy

Last step is commit to GitHub, wait until the GitHub action ends (in the
case you chose to deploy in that way) and deploy the website via
*YOUR\_GITHUB\_REPO\>Settings\>GitHub Pages*.

## Extras

We provide also some additional extra functions for creating badges and
logos, see
[Extras](https://dieghernan.github.io/rogtemplate/reference/index.html)
for more info.
