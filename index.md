# rogtemplate

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

You can use
[`rog_actions_pkgdown_branch()`](https://ropengov.github.io/rogtemplate/reference/rog_actions_pkgdown_branch.md)
for setting up the action described before but the deployment would be
still performed by a GitHub action.

For building locally your package into your `docs` folder use:

``` r
rogtemplate::rog_build()

# or you can use also

rogtemplate::rog_add_template_pkgdown()
pkgdown::build_site()
```

Note that
[`rogtemplate::rog_add_template_pkgdown()`](https://ropengov.github.io/rogtemplate/reference/rog_add_template_pkgdown.md)
creates a `_pkgdown.yml` file (or modify an existing one) with the
following lines:

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

All contributions to this project are gratefully acknowledged using the
[`allcontributors` package](https://github.com/ropensci/allcontributors)
following the [allcontributors](https://allcontributors.org)
specification. Contributions of any kind are welcome!

### Code

[TABLE]

### Issues

[TABLE]
