#!/bin/sh -l
 
# delimiter for trivy json reports
IFS=','

for img in $1
do
    echo $img
    # hardcoded for now, change to image name, image report, and buildkitd address
    copa patch -i mcr.microsoft.com/oss/nginx/nginx:1.21.6 -r /data/nginx.1.21.6.json -t patched --addr "$2"
done
