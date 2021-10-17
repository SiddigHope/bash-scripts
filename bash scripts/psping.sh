#!/bin/bash

while getopts u:c:t: flag
do
    case "${flag}" in
        u) username=${OPTARG};;
        c) count=${OPTARG};;
        t) timeout=${OPTARG};;
    esac
done

i=1;
for process in "$@" 
do
    i=$((i + 1));
done

if [ -z "$username" ]; then
string="Pinging ‘${process}’ for any user"
command_string="ps -aux | grep ${process} | wc -l";
else
string="Pinging ‘${process}’ for user ‘${username}’"
command_string="ps -u ${username} --no-heading | grep ${process} | wc -l";
fi


if [ -z "$timeout" ]; then
timeout=1
fi

commando=$(eval "$command_string");

echo $string

s=1;
if [ -z "$count" ]; then
while true; do echo -n "${process}: ${commando} instance(s)...\n"; sleep ${timeout}; done
else
# echo "sd"
while [ $s -le $count ]
do 
    s=$((s + 1)) 
    echo -n "${process}: ${commando} instance(s)...\n"; sleep ${timeout}; 
done
fi