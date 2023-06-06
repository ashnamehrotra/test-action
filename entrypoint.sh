#!/bin/sh -l
 
# delimiter for trivy json reports
IFS=','
export PATCHED=""

for report in $1
do
    image="docker.io/ashnam/nginx:1.21.6"
    image_no_tag="docker.io/ashnam/nginx"
    patched_tag="patched"
    
    sudo copa patch -i "$image" -r /data/"$report" -t "$patched_tag" --addr tcp://0.0.0.0:8888

    if [ $? -eq 0 ];  then
        PATCHED="$PATCHED,$image_no_tag:$patched_tag"
    else
        echo "Error patching image $image with copa"
    fi
done

echo "::set-output name=patched-images::$PATCHED"
