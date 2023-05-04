# Copa Docker Action

This action patches images using [Copa](https://github.com/project-copacetic/copacetic).

## Inputs

## `image-reports`

**Required** The list of trivy json reports from images to patch.

## `buildkitd-address`

**Required** Address of running Buildkitd container.

## Outputs

## `patched-images`

The list of new patched images.

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
      - name: Set up Docker Buildx to start Buildkit
        uses: docker/setup-buildx-action@v2
        with: 
          buildkitd-flags: '--addr tcp://0.0.0.0:8888'
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
