#!/bin/sh

image=$1
report=$2
patched_tag=$3

# run copa to patch image
if copa patch -i "$image" -r ./data/"$report" -t "$patched_tag" --addr tcp://127.0.0.1:8888;
then
    patched_image="$image_no_tag:$new_tag"
    echo "patched-image=$patched_image" >> "$GITHUB_OUTPUT"
else
    echo "Error patching image $image with copa"
    exit 1
fi
