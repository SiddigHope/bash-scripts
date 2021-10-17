#!/bin/bash

# zipdir=/mnt/www/log/_tmp
# cd $zipdir

while getopts f:v:t: flag
do
    case "${flag}" in
        f) files=${OPTARG};;
        v) show=${OPTARG};;
        t) traverse=${OPTARG};;
    esac
done


successful=0
for i in "$@"
do
extention=$(echo "$i" | sed 's/^.*\.//')
# echo $extention
if [ "$extention" = "zip" ]; then 
    if [ -z "$show" ]; then
        decompress=$(eval "unzip -o -t $i")
        if [ $? = 0 ]; then
            successful=$((successful + 1));
        fi
    else
        unzip -o -t "$i";
    fi
else
if [ "$extention" = "gz" ]; then
    if [ -z "$show" ]; then
        decompress=$(eval "gunzip -d -t $i")
        if [ $? = 0 ]; then
            successful=$((successful + 1));
        fi
    else
        gunzip -d -t "$i"
    fi
else
if [ "$extention" = "bz2" ]; then
    if [ -z "$show" ]; then
        decompress=$(eval "bunzip2 -o -t $i")
        if [ $? = 0 ]; then
            successful=$((successful + 1))
        fi
    else
        bunzip2 -o -t "$i"
    fi
else
if [ "$extention" = "cmpr" ]; then
    if [ -z "$show" ]; then
        decompress=$(eval "uncompress -d -t $i")
        if [ $? = 0 ]; then
            successful=$((successful + 1))
        fi
    else
        uncompress -o -t "$i"
    fi
fi
fi
fi
fi
done

echo "Decompressed ${successful} archive(s)"

# for i in *.zip
# do
#     folder=${i::-4}
#         mkdir -p  $folder
#     unzip -o $i -d $folder && rm $i
#     subdirs=$(find $folder -type d | wc -l)
#     if [[ $subdirs -eq 2 ]]; then
#         mv ./$folder/* ./
#         rm -r $folder
#     else if [[ $subdirs -gt 1 ]]; then
#         mv ./$folder/*/* ./
#         rm -r $folder
#     fi
#     fi
# done