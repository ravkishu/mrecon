#!/bin/sh

dir=/root/workspace/$1

mkdir $dir

echo $1 | httpx | python3 ~/tools/FavFreak/favfreak.py > $dir/$1_faver

cat $dir/$1_faver | grep 'h]' | cut -d ] -f2 | cut -d " " -f2 | tee $dir/$1_favhash_domain
