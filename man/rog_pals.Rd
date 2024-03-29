% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rog_pals.R
\name{rog_pals}
\alias{rog_pals}
\alias{rog_orange_pal}
\alias{rog_dark_pal}
\alias{rog_gradient_pal}
\alias{rog_qualitative_pal}
\title{rOpenGov color palettes}
\usage{
rog_orange_pal(n = 4, alpha = 0.9, rev = FALSE)

rog_dark_pal(n = 4, alpha = 0.9, rev = FALSE)

rog_gradient_pal(n = 4, alpha = 0.9, rev = FALSE)

rog_qualitative_pal(n = 6, alpha = 0.9, rev = FALSE)
}
\arguments{
\item{n}{the number of colors (\eqn{\ge 1}) to be in the
    palette.}

\item{alpha}{an alpha-transparency level in the range [0,1]
    (0 means transparent and 1 means opaque), see argument
    \code{alpha} in \code{\link[grDevices]{hsv}} and \code{\link[grDevices]{hcl}}, respectively.\cr
    A \code{\link{missing}}, i.e., not explicitly specified
    \code{alpha} is equivalent to \code{alpha = NULL}, which does \emph{not}
    add opacity codes (\code{"FF"}) to the individual color hex codes.}

\item{rev}{logical indicating whether the ordering of the colors should
    be reversed.}
}
\value{
Color palettes
}
\description{
Color palettes based on the color scheme of rOpenGov
}
\examples{

scales::show_col(rog_orange_pal(9))

scales::show_col(rog_dark_pal(9))

scales::show_col(rog_gradient_pal(9))

scales::show_col(rog_qualitative_pal(9))
}
\seealso{
\code{\link[grDevices:palettes]{grDevices::hcl.colors()}}

Other extras: 
\code{\link{rog_add_template_pkgdown}()},
\code{\link{rog_badge_ropengov}()},
\code{\link{rog_load_font}()},
\code{\link{rog_logo}()}
}
\concept{extras}
\concept{rog_plot}
