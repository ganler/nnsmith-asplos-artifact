# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = "NNSmith ASPLOS Artifact"
copyright = "2022, Jiawei Liu"
author = "Jiawei Liu"

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = [
    "sphinx.ext.githubpages",
    "sphinx.ext.autosectionlabel",
    "sphinx.ext.intersphinx",
    "myst_parser",
]

myst_enable_extensions = ["colon_fence"]
pygments_style = "sphinx"
pygments_dark_style = "monokai"


templates_path = ["_templates"]
exclude_patterns = []


# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = "furo"
html_logo = "https://github.com/ganler/nnsmith-logo/raw/master/nnsmith-logo.svg"
html_static_path = ["_static"]
