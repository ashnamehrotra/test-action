#!/bin/sh -l
 
# delimiter for trivy json reports
IFS=','
patched=()

for report in $1
do
    image = "mcr.microsoft.com/oss/nginx/nginx:1.21.6"
    tag = "patched"
    
    sudo copa patch -i "$image" -r /data/"$report" -t "tag" --addr tcp://0.0.0.0:8888
    if [[ $? -eq 0 ]]; then
        patched+=("$str1:$str2")
    fi
done

echo "patched-images=$patched" >> $GITHUB_OUTPUT
