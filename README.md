# qtemplate - Quickly make new standard Quarto Documents

This R package was designed to be used by the Babraham Bioinformatics group for their analysis work.  It provides a simple way to make a new quarto document based on a template.  Using this is a quick way to start new projects.


## Installation

You can install this package directly from github using:

```
remotes::install_github("s-andrews/qtemplate")
```

..or..

```
devtools::install_github("s-andrews/qtemplate")
```

## Usage

The package only provides a single function ``new_doc``.  This requires the name of the new quarto document you want to create, which must end with a .qmd extension.

You can then optionally provide additional information

* **title**: The title for the document - must end with ```.qmd```
* **author**: Your name to go in the author field
* **theme**: The name of a ggplot theme to use, eg "theme_bw", "theme_dark" etc.

By default the new file won't be created if a file with that name exists already. If you *really* want to do that you can set ```overwrite=TRUE```




