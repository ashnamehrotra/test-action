#!/bin/sh -l

image=$1
report=$2

# parse image into image name and image tag
image_no_tag=$(echo "$image" | cut -d':' -f1)
tag=$(echo "$image" | cut -d':' -f2)

# new patched image tag
patched_tag="$tag-patched"

# run copa to patch image
sudo copa patch -i "$image" -r /data/"$report" -t "$patched_tag" --addr tcp://0.0.0.0:8888

# check copa output
if [ $? -eq 0 ];  then
    patched_image="$image_no_tag:$patched_tag"
    echo "::set-output name=patched-image::$patched_image"
else
    echo "Error patching image $image with copa"
fi
