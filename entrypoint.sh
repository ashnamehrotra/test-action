#!/bin/sh -l

image=$1
report=$2

# delimiter to parse image into image name and image tag
IFS=":" read -r image_no_tag tag <<< $image

# new patched image tag
patched_tag="patched"

# run copa
sudo copa patch -i "$image" -r /data/"$report" -t "$patched_tag" --addr tcp://0.0.0.0:8888

# check copa output
if [ $? -eq 0 ];  then
    patched-image="$image_no_tag:$patched_tag"
    echo "::set-output name=patched-image::$patched-image"
else
    echo "Error patching image $image with copa"
fi
