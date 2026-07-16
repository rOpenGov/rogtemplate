# rogtemplate 0.0.2.9000

- Added a `NEWS.md` file to track package changes.
- Added rOpenGov color palette functions, see `rog_orange_pal()`.
- Adapted to **bslib** >= 0.6.1 and Bootstrap v5.3.1 changes.
- Added dark mode.
- Dark mode CSS now keeps generated styles synchronized and uses an accessible danger text color.
- `rog_actions_pkgdown_branch()` now writes project metadata to the requested `pkg` path and grants the generated pkgdown deployment workflow `contents: write`.
- `rog_build()` now respects the requested `pkg` path and keeps logo-only arguments out of the `pkgdown::build_site()` call.
