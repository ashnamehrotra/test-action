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

    echo "$image_no_tag:$patched_tag," >> $GITHUB_OUTPUT

    if [ $? -eq 0 ];  then
        echo "here"
        # patched+="$image_no_tag:$patched_tag,"
    else
        echo "Error patching image $image with copa"
    fi
done

# echo "patched-images=$PATCHED" >> $GITHUB_OUTPUT
