#!/bin/bash

# zipdir=/mnt/www/log/_tmp
# cd $zipdir

successful=0

while getopts f:v:r: flag
do
    case "${flag}" in
        f) files=${OPTARG};;
        v) show=${OPTARG};;
        r) traverse=${OPTARG};;
    esac
done

# for file in $traverse/*
# do
#     echo $file
#     #whatever you need with "$file"
# done

# cd /traverse/

 if [ -z "$traverse" ]; then
        traverse=""
else
    # cd $traverse
    for i in $traverse/*
    do
    extention=$(echo "$i" | sed 's/^.*\.//')
    # echo $i
    if [ "$extention" = "zip" ]; then 
            decompress=$(eval "unzip -o $i -d $traverse")
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
            decompress=$(eval "gunzip --f -d -q -t -c $i > $i")
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
            decompress=$(eval "bunzip2 -d -q $i -c $traverse")
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
            decompress=$(eval "uncompress -f -d -q -t -c $i > $i")
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
fi

cd ..

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
