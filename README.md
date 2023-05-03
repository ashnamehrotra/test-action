# Hello world docker action

This action prints "Hello World" or "Hello" + the name of a person to greet to the log.

## Inputs

## `images`

**Required** The list of images to patch. Separated by whitespace as arguments. Default `""`. This could be supplied by a trivy scan action? (or we can include this and list of images would be all images that the user wants to scan rather than patch)

## Outputs

## `patched-images`

The list of new patched images.

## Example usage

uses: actions/hello-world-docker-action@v2
with:
  who-to-greet: 'Mona the Octocat'