# Create base image
FROM python:latest
RUN pip install mkdocs-material \
mkdocs-git-revision-date-plugin \
mkdocs-git-revision-date-localized-plugin \
mkdocs-markdownextradata-plugin \
git+https://github.com/sebastienwarin/mkdocs-mermaid-plugin \
mkdocs[i18n]