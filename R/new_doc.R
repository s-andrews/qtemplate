#' Create a new quarto document based on a template
#'
#' @param outfile The name of the new document to create (needs .qmd suffix)
#' @param template The name of the template (defaults to standard Babraham template)
#' @param author Your name for the report
#' @param title The title of the document
#' @param theme Which ggplot theme to install (default theme_bw)
#'
#' @returns Nothing, but a new document is created for you
#' @export
#'
#' @examples
#' new_doc("test.qmd", author="Jane Doe", title="My new analysis", theme="theme_dark")
new_doc <- function(outfile,template="babraham_bioinformatics.qmd", author="Simon Andrews", title="Enter Title Here", theme="theme_bw") {
  template_file <- system.file("extdata",template,package="qtemplate")
  readr::read_file(template_file) -> template_string

  list (
    title = title,
    author = author,
    theme = theme
  ) -> template_vars

  whisker::whisker.render(template_string,template_vars) -> filled_template

  readr::write_file(filled_template,outfile)
}
