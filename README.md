
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rogtemplate <a href='https://ropengov.github.io/rogtemplate/'><img src="man/figures/logo.png" align="right" height="139"/></a>

<!-- badges: start -->

[![rOG-badge](https://ropengov.github.io/rogtemplate//reference/figures/ropengov-badge.svg)](https://ropengov.org/)
[![R build
status](https://github.com/ropengov/rogtemplate/workflows/R-CMD-check/badge.svg)](https://github.com/rOpenGov/rogtemplate/actions)
[![r-universe](https://ropengov.r-universe.dev/badges/rogtemplate)](https://ropengov.r-universe.dev/rogtemplate)
[![lifecycle](https://lifecycle.r-lib.org/articles/figures/lifecycle-experimental.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)

<!-- badges: end -->

This package is a **pkgdown** template adapted to
[rOpenGov](https://ropengov.org/) site.

This is a private template for use by core rOpenGov packages. Please
don’t use it for your own code.

## Using rogtemplate

It is possible to deploy your **pkgdown** site along with
**rogtemplate** via CI (GitHub Actions) or locally, that provides more
control but it is not automatic.

### Option A: Deploy using GitHub Actions

It is not necessary to install **rogtemplate** itself. First copy [this
file](https://github.com/rOpenGov/rogtemplate/blob/main/inst/yaml/rogtemplate-gh-pages.yaml)
into your `.github/workflows/` folder.

Next go to *YOUR_GITHUB_REPO\>Settings\>GitHub Pages* and deploy your
website from the `gh-pages` branch.

### Option B: Deploy installing rogtemplate

You can install **rogtemplate** using the
[r-universe](https://ropengov.r-universe.dev/rogtemplate):

``` r
install.packages("rogtemplate",
  repos = c("https://ropengov.r-universe.dev", "https://cloud.r-project.org")
)
```

You can use also the **remotes** package:

``` r
library(remotes)
install_github("ropengov/rogtemplate", dependencies = TRUE)
```

You can use `rog_actions_pkgdown_branch()` for setting up the action
described before but the deployment would be still performed by a GitHub
action.

For building locally your package into your `docs` folder use:

``` r
rogtemplate::rog_build()

# or you can use also

rogtemplate::rog_add_template_pkgdown()
pkgdown::build_site()
```

Note that `rogtemplate::rog_add_template_pkgdown()` creates a
`_pkgdown.yml` file (or modify an existing one) with the following
lines:

``` yaml

template:
  bootstrap: 5
  package: rogtemplate
```

These lines tells **pkgdown** to use **rogtemplate**.

## Commit to GitHub and deploy

Last step is commit to GitHub, wait until the GitHub action ends (in the
case you chose to deploy in that way) and deploy the website via
*YOUR_GITHUB_REPO\>Settings\>GitHub Pages*.

## Extras

We provide also some additional extra functions for creating badges and
logos, see
[Extras](https://ropengov.github.io/rogtemplate/reference/index.html)
for more info.

## Contributors

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->

All contributions to this project are gratefully acknowledged using the
[`allcontributors` package](https://github.com/ropensci/allcontributors)
following the [allcontributors](https://allcontributors.org)
specification. Contributions of any kind are welcome!

### Code

<table>
<tr>
<td align="center">
<a href="https://github.com/dieghernan">
<img src="https://avatars.githubusercontent.com/u/25656809?v=4" width="100px;" class="border border-dark rounded-circle" alt=""/>
</a><br>
<a href="https://github.com/rOpenGov/rogtemplate/commits?author=dieghernan">dieghernan</a>
</td>
<td align="center">
<a href="https://github.com/stephbuon">
<img src="https://avatars.githubusercontent.com/u/52008049?v=4" width="100px;" class="border border-dark rounded-circle" alt=""/>
</a><br>
<a href="https://github.com/rOpenGov/rogtemplate/commits?author=stephbuon">stephbuon</a>
</td>
<td align="center">
<a href="https://github.com/maelle">
<img src="https://avatars.githubusercontent.com/u/8360597?v=4" width="100px;" class="border border-dark rounded-circle" alt=""/>
</a><br>
<a href="https://github.com/rOpenGov/rogtemplate/commits?author=maelle">maelle</a>
</td>
</tr>
</table>

### Issues

<table>
<tr>
<td align="center">
<a href="https://github.com/pitkant">
<img src="https://avatars.githubusercontent.com/u/69813611?u=824c10fc689a7f3589c9640bb7edf23513a12e42&v=4" width="100px;" class="border border-dark rounded-circle" alt=""/>
</a><br>
<a href="https://github.com/rOpenGov/rogtemplate/issues?q=is%3Aissue+author%3Apitkant">pitkant</a>
</td>
<td align="center">
<a href="https://github.com/muuankarski">
<img src="https://avatars.githubusercontent.com/u/1525240?v=4" width="100px;" class="border border-dark rounded-circle" alt=""/>
</a><br>
<a href="https://github.com/rOpenGov/rogtemplate/issues?q=is%3Aissue+author%3Amuuankarski">muuankarski</a>
</td>
</tr>
</table>
<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->
