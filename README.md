# Copa Docker Action

This action patches images using [Copa](https://github.com/project-copacetic/copacetic).

## Inputs

## `image`

**Required** The image reference to patch.

## `image-report`

**Required** The trivy json report of the image to patch.

## `patched-tag`

**Required** The patched image tag to append to the original tag.

## Output

## `patched-image`

Image reference of patched image.

## Example usage

```
on: [push]

jobs:
    test:
        runs-on: ubuntu-latest

        strategy:
          fail-fast: false
          matrix:
            # provide relevant list of images to scan on each run
            images: ['docker.io/ashnam/nginx:1.21.6', 'docker.io/ashnam/opa:0.46.0']

        steps:
        - name: Checkout repository
          uses: actions/checkout@v2

        - name: Set up Docker Buildx
          uses: docker/setup-buildx-action@v2

        - name: Run Trivy vulnerability scanner
          uses: aquasecurity/trivy-action@master
          with:
            scan-type: 'image'
            format: 'json'
            output: 'report.json'
            ignore-unfixed: true
            vuln-type: 'os'
            image-ref: ${{ matrix.images }}

        - name: Copa Action
          id: copa
          uses: ashnamehrotra/test-action@v1.6.4
          with:
            image: ${{ matrix.images }}
            image-report: 'report.json'

        - name: Login to Docker Hub
          uses: docker/login-action@v2
          with:
            username: 'ashnam'
            password: ${{ secrets.DOCKERHUB_TOKEN }}

        - name: Docker Push Patched Image
          run: |
            docker push ${{ steps.copa.outputs.patched-image }}
```
