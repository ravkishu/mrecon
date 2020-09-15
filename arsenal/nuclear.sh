#!/bin/bash

dir=/root/workspace/$1

# cat $dir/$1_subdomains | httpx -silent | sort -u | nuclei -c 200 -silent -t /root/Tools/nuclei-templates/ -o $dir/$1_nuclei
cat $dir/$1_subdomains | httpx -silent | sort -u | nuclei -silent -t ~/nuclei-templates/ | tee $dir/$1_nuclei
