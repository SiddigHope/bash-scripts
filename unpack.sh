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
        decompress=$(eval "unzip -o -t $i")
    if [ -z "$show" ]; then
        if [ $? = 0 ]; then
            successful=$((successful + 1));
        fi
    else
        echo "Unpacking ${i}..."
        successful=$((successful + 1));
    fi
else
if [ "$extention" = "gz" ]; then
        decompress=$(eval "gunzip -f -d -t $i")
    if [ -z "$show" ]; then
        if [ $? = 0 ]; then
            successful=$((successful + 1));
        fi
    else
        echo "Unpacking ${i}..."
        successful=$((successful + 1));
    fi
else
if [ "$extention" = "bz2" ]; then
        decompress=$(eval "bunzip2 -d -q -t $i")
    if [ -z "$show" ]; then
        if [ $? = 0 ]; then
            successful=$((successful + 1))
        fi
    else
        echo "Unpacking ${i}..."
        successful=$((successful + 1));
    fi
else
if [ "$extention" = "cmpr" ]; then
        decompress=$(eval "uncompress -d -t $i")
    if [ -z "$show" ]; then
        if [ $? = 0 ]; then
            successful=$((successful + 1))
        fi
    else
        echo "Unpacking ${i}..."
        successful=$((successful + 1));
    fi
fi
fi
fi
fi
done

echo "Decompressed ${successful} archive(s)"
