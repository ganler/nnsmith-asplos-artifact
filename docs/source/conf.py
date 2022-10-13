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
    "myst_parser",
    "sphinx.ext.githubpages",
    "sphinx.ext.autosectionlabel",
    "sphinx.ext.intersphinx",
]

myst_enable_extensions = ["colon_fence"]
html_theme_options = {"pygment_light_style": "emacs", "pygment_dark_style": "native"}


templates_path = ["_templates"]
exclude_patterns = []


# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = "pydata_sphinx_theme"
html_logo = "https://github.com/ganler/nnsmith-logo/raw/master/nnsmith-logo.svg"
html_static_path = ["_static"]
