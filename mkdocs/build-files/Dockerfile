# Create base image
FROM python:latest AS base-mkdocs-material
RUN pip install mkdocs-material \
mkdocs-git-revision-date-plugin \
mkdocs-git-revision-date-localized-plugin \
mkdocs-markdownextradata-plugin \
git+https://github.com/sebastienwarin/mkdocs-mermaid-plugin \
mkdocs[i18n] \
markdown

# Build the site
# FROM base-mkdocs-material AS build-mkdocs-material
# COPY . /app
# WORKDIR /app
# RUN mkdocs build --site-dir public --config-file /app/mkdocs.yml

## Create image with only the static site
# FROM build-mkdocs-material AS site-mkdocs-material
# COPY mkdocs.yml /app/public/
# WORKDIR /app/
# EXPOSE 8000
# ENTRYPOINT ["mkdocs"]
# CMD ["serve"]