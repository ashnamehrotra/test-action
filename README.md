# Copa Docker Action

This action patches images using [Copa](https://github.com/project-copacetic/copacetic).

## Inputs

## `image`

**Required** The image reference to patch.

## `image-report`

**Required** The trivy json report of the image to patch.

## Outputs

## `patched-images`

Image reference of patched image.

## Example usage

```
name: patch images
on:
  push:
    branches:
      - main
jobs:
  build:
    name: Patch
    runs-on: ubuntu-latest
    env:
      Image: 'mcr.microsoft.com/oss/nginx/nginx:1.21.6'
    steps:
      - name: Run Trivy vulnerability scanner
        uses: aquasecurity/trivy-action@master
        with:
          scan-type: 'image'
          format: 'json'
          output: 'nginx.1.21.6.json'
          ignore-unfixed: true
          vuln-type: 'os
      - name: patch
        uses: actions/copa@v1
        with:
          image-reports: 'nginx.1.21.6.json'
      - name: Docker Push Image
        uses: docker/build-push-action@v4
        with:
          push: true
          tags: "mcr.microsoft.com/oss/nginx/nginx:patched"
```
