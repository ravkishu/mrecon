#!/bin/sh

dir=/root/workspace/$1
mkdir $dir

# echo https://$1 | python3 /root/Tools/smuggler/smuggler.py > $dir/$1_smuggler
echo $1 | httpx | python3 ~/tools/smuggler/smuggler.py | tee $dir/$1_smuggler
