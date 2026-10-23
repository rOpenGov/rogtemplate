# Changelog

## rogtemplate 0.0.2.9100

- Text links, Tango syntax colors and dark captions now meet accessible
  contrast targets. Inline links stay underlined, keyboard focus is
  visible and diffviewer text is readable in both modes. Footer
  backgrounds span the viewport without page overflow at intermediate
  widths ([\#24](https://github.com/rOpenGov/rogtemplate/issues/24)).
- Code blocks now keep long lines within their containers and preserve
  linked syntax colors. Callout animations respect reduced motion
  preferences, and narrow mobile layouts keep navigation controls on one
  row without sidebar or footer overflow
  ([\#24](https://github.com/rOpenGov/rogtemplate/issues/24)).
- Added a `NEWS.md` file to track package changes.
- Added rOpenGov color palette functions, including
  [`rog_orange_pal()`](https://ropengov.github.io/rogtemplate/reference/rog_pals.md).
- **rogtemplate** now supports **bslib** \>= 0.6.1 and **Bootstrap**
  v5.3.1.
- Added dark mode.
- Copy buttons now use dark text on hover and focus for better contrast,
  and Quarto callout icons adapt to the site theme and brand colors.
- Dark mode CSS now keeps generated styles synchronized and uses an
  accessible danger text color.
- [`rog_actions_pkgdown_branch()`](https://ropengov.github.io/rogtemplate/reference/rog_actions_pkgdown_branch.md)
  now writes project metadata to the requested `pkg` path and grants the
  generated **pkgdown** deployment workflow `contents: write`.
- [`rog_build()`](https://ropengov.github.io/rogtemplate/reference/rog_build.md)
  now respects the requested `pkg` path and keeps logo-only arguments
  out of the
  [`pkgdown::build_site()`](https://pkgdown.r-lib.org/reference/build_site.html)
  call.
- [`rog_dark_pal()`](https://ropengov.github.io/rogtemplate/reference/rog_pals.md),
  [`rog_gradient_pal()`](https://ropengov.github.io/rogtemplate/reference/rog_pals.md)
  and
  [`rog_orange_pal()`](https://ropengov.github.io/rogtemplate/reference/rog_pals.md)
  now return exact reversed scales when `rev = TRUE`.
