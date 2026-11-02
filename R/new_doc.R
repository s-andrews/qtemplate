#' Create a new quarto document based on a template
#'
#' @param template The name of the template (defaults to a generic)
#' @param logo The name of an inbuilt logo file, or the URL where a PNG logo file can be found
#' @param outfile The name of the new document to create (defaults to [template].qmd)
#' @param author The name to include as the document author (defaults to the users username)
#' @param theme Which ggplot theme to install (default theme_bw)
#' @param code_fold Whether to hide code in compiled documents (default TRUE)
#' @param overwrite A logical to say if we should force overwriting if the outfile exists
#'
#' @returns Nothing, but a new document is created for you
#' @export
#'
#' @examples
#' new_doc(outfile="test.qmd", theme="theme_dark", author="Simon Andrews")
new_doc <- function(
    template="generic",
    logo = "biotrain",
    outfile = NULL,
    author = NULL,
    theme="theme_bw",
    code_fold=TRUE,
    overwrite=FALSE) {


  c(
    "biotrain" = "https://biotrain.tv/static/images/logo_light_background.png",
    "bi" = "https://www.bioinformatics.babraham.ac.uk/bioinformatics_logo_quarto.png"
  ) -> logos

  if (!startsWith(logo,"http")) {
    if (!logo %in% names(logos)) {
      stop(paste0("Unknown logo '",logo,"' valid ones are: ",names(logos)))
    }
    logos[logo] -> logo
  }

  if (stringr::str_detect("[/\\:]",template)) {
    stop(paste0("Invalid chars in template name"))
  }

  template_file <- system.file("extdata",paste0(template,".qmd"),package="qtemplate")

  if(!file.exists(template_file)) {
    stop(paste0("Unknown template ",template))
  }

  if (is.null(outfile)) {
    # We make a generic name
    paste0(template,".qmd") -> outfile
  }

  if (!endsWith(tolower(outfile),".qmd")) {
    paste0(outfile,".qmd") -> outfile
  }

  if (is.null(author)) {
    Sys.info()[["user"]] -> author
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
    logo = logo,
    theme = theme,
    codefold = dplyr::if_else(code_fold,"true","false")
  ) -> template_vars

  whisker::whisker.render(template_string,template_vars) -> filled_template

  readr::write_file(filled_template,outfile)

  message(paste0("Created ",outfile))
}
