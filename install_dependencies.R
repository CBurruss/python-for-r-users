<<<<<<< HEAD
# Script to install required R packages
packages <- c(
  "tidyverse",
  "naniar", 
  "glue",
  "tidygeocoder",
  "sf",
  "IRkernel"
)

# Install packages if not already installed
installed_packages <- packages %in% rownames(installed.packages())
if (any(!installed_packages)) {
  install.packages(packages[!installed_packages])
}

# Print installation summary
cat("R package installation check:\n")
for (pkg in packages) {
  if (requireNamespace(pkg, quietly = TRUE)) {
    cat(pkg, "is installed\n")
  } else {
    cat(pkg, "is missing!\n")
  }
}

# Register IRkernel for Jupyter 
=======
# Script to install required R packages
packages <- c(
  "tidyverse",
  "naniar", 
  "glue",
  "tidygeocoder",
  "sf",
  "IRkernel"
)

# Install packages if not already installed
installed_packages <- packages %in% rownames(installed.packages())
if (any(!installed_packages)) {
  install.packages(packages[!installed_packages])
}

# Print installation summary
cat("R package installation check:\n")
for (pkg in packages) {
  if (requireNamespace(pkg, quietly = TRUE)) {
    cat(pkg, "is installed\n")
  } else {
    cat(pkg, "is missing!\n")
  }
}

# Register IRkernel for Jupyter 
>>>>>>> fe5f15f937115c969d3e9d68b066e124261233e9
IRkernel::installspec()