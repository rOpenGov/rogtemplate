load_font_rogtemplate <- function(family = "B612") {
  fonts <- list.files(system.file("fonts", package = "rogtemplate"),
    pattern = "ttf$", recursive = TRUE, full.names = TRUE
  )



  sysfonts::font_add(family,
    regular = as.character(fonts[4]),
    bold = as.character(fonts[1]),
    italic = as.character(fonts[3]),
    bolditalic = as.character(fonts[2])
  )

  showtext::showtext_auto()

  return(family)
}
