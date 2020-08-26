# Portainer templates helper

This helper container is designed to help you apply specific operations on a template file.

# Usage

## Upgrading templates used in Portainer < 2.0 to 2.0 format

```
# specify the path to your original templates.json file
docker run --rm -v /tmp/templates.json:/src/templates.json -v /tmp/output:/dist portainer/helper-templates
2020/08/26 00:51:27 New template file successfully created at /dist/templates-upgraded.json

# the new template file will be available in /tmp/output
ls /tmp/output 
templates-upgraded.json

```
