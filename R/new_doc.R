#' Create a new quarto document based on a template
#'
#' @param outfile The name of the new document to create (needs .qmd suffix)
#' @param template The name of the template (defaults to standard Babraham template)
#' @param author Your name for the report
#' @param title The title of the document
#' @param overwrite A logical to say if we should force overwriting if the outfile exists
#' @param theme Which ggplot theme to install (default theme_bw)
#'
#' @returns Nothing, but a new document is created for you
#' @export
#'
#' @examples
#' new_doc("test.qmd", author="Jane Doe", title="My new analysis", theme="theme_dark")
new_doc <- function(
    outfile,
    template="babraham_bioinformatics.qmd",
    author="Simon Andrews",
    title="Enter Title Here",
    theme="theme_bw",
    overwrite=FALSE) {
  template_file <- system.file("extdata",template,package="qtemplate")

  if (!endsWith(tolower(template),".qmd")) {
    stop("Template ",template," doesn't end with .qmd - can't be right")
  }

  if (!endsWith(tolower(outfile),".qmd")) {
    stop("Outfile ",outfile," doesn't end with .qmd - it needs to!")
  }


  if (stringr::str_detect("[/\\:]",template)) {
    stop(paste0("Invalid chars in template name"))
  }

  if(!file.exists(template_file)) {
    stop(paste0("Unknown template ",template))
  }

  if(file.exists(outfile)) {
    if(overwrite) {
      warning(paste0("Outfile ",outfile," exists, but going ahead as overwrite is true"))
    }
    else {
      stop(paste0("Outfile ",outfile," already exists - stopping"))
    }
  }

  readr::read_file(template_file) -> template_string

  list (
    title = title,
    author = author,
    theme = theme
  ) -> template_vars

  whisker::whisker.render(template_string,template_vars) -> filled_template

  readr::write_file(filled_template,outfile)
}
