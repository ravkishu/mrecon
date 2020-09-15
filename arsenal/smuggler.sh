#!/bin/sh

dir=/root/workspace/$1

# echo https://$1 | python3 /root/Tools/smuggler/smuggler.py > $dir/$1_smuggler
echo $1 | httprobe --prefer-https | python3 ~/tools/smuggler/smuggler.py | tee $dir/$1_smuggler

echo "Also Do manual testing via this command: 'python3 ~/tools/Smuggler/smuggler.py'"
