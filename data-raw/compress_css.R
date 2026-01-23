# Compress with sass
library(sass)

lns <- readLines("inst/pkgdown/assets/BS5/rogtemplate.css")

sass(
  lns,
  "inst/pkgdown/assets/BS5/rogtemplate.min.css",
  cache = NULL,
  options = sass_options(output_style = "compressed")
)
