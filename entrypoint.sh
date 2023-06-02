#!/bin/sh -l
 
# delimiter for trivy json reports
IFS=','
patched=""

for report in $1
do
    image="mcr.microsoft.com/oss/nginx/nginx:1.21.6"
    image_no_tag="mcr.microsoft.com/oss/nginx/nginx"
    patched_tag="patched"
    
    sudo copa patch -i "$image" -r /data/"$report" -t "patched_tag" --addr tcp://0.0.0.0:8888

    if [ $? -eq 0 ];  then
        patched+="$image_no_tag:$patched_tag,"
    else
        echo "Error patching image $image with copa"
    fi
done

echo "patched-images=$patched" >> $GITHUB_OUTPUT
