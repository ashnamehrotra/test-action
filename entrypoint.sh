#!/bin/sh -l

# for each image, run copa
# if no errors, add to a list
# save list into $GITHUB_OUTPUT


buildkitd --version
copa patch -i mcr.microsoft.com/oss/nginx/nginx:1.21.6 -r /data/nginx.1.21.6.json -t 1.21.6-patched --addr tcp://0.0.0.0:8888


#for img in "$@"
#do
    # run copa
#    echo "$img"
#    copa patch -i mcr.microsoft.com/oss/nginx/nginx:1.21.6 -r nginx.1.21.6.json -t 1.21.6-patched
#done
