# Portainer templates helper

This helper container is designed to help you apply specific operations on a template file.

# Usage

## Upgrading templates used in Portainer < 2.0 to 2.0 format

```
# specify the path to your original templates.json file
docker run --rm -v /path/to/templates.json:/src/templates.json -v /tmp/output:/dist portainer/helper-templates

# the new template file will be available in /tmp/output
ls /tmp/output

```
