# install_uninstall_paquetes.R


# if (!require(ggplot2)) {
#   install.packages("ggplot2")
#   library(ggplot2)
# }

# or if you want to parameterize it:

instalar <- c("ggplot2", "ggplot2movies")
for (pkg in instalar) {
    if (!require(pkg, character.only = TRUE)) {
        install.packages(pkg)
        if (!require(pkg, character.only = TRUE)) 
            stop("load failure: ", pkg)
    }
}



detach_package <- function(pkg, character.only = FALSE)
{
  if(!character.only)
  {
    pkg <- deparse(substitute(pkg))
  }
  search_item <- paste("package", pkg, sep = ":")
  while(search_item %in% search())
  {
    detach(search_item, unload = TRUE, character.only = TRUE)
  }
}

detach_package("vegan", TRUE)