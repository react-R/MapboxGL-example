#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
MapboxGL <- function(map, width = NULL, height = NULL, elementId = NULL) {

  # describe a React component to send to the browser for rendering.
  component <- reactR::reactMarkup(map)

  # create widget
  htmlwidgets::createWidget(
    name = 'MapboxGL',
    component,
    width = width,
    height = height,
    package = 'MapboxGL',
    elementId = elementId
  )
}

#' Shiny bindings for MapboxGL
#'
#' Output and render functions for using MapboxGL within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a MapboxGL
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name MapboxGL-shiny
#'
#' @export
MapboxGLOutput <- function(outputId, width = '100%%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'MapboxGL', width, height, package = 'MapboxGL')
}

#' @rdname MapboxGL-shiny
#' @export
renderMapboxGL <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, MapboxGLOutput, env, quoted = TRUE)
}

#' Called by HTMLWidgets to produce the widget's root element.
#' @rdname MapboxGL-shiny
MapboxGL_html <- function(id, style, class, ...) {
  htmltools::tagList(
    # Necessary for RStudio viewer version < 1.2
    reactR::html_dependency_corejs(),
    reactR::html_dependency_react(),
    reactR::html_dependency_reacttools(),
    htmltools::tags$div(id = id, class = class)
  )
}
