#!/bin/sh

dir=/root/workspace/$1

ffufdomain="$(echo $1 | httprobe --prefer-https)"
# ffuf -mc all -c -H "X-Forwarded-For: 127.0.0.1" -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0" -u "$1/FUZZ" -w /root/wordlist/dicc.txt -D -e js,php,bak,txt,asp,aspx,jsp,html,zip,jar,sql,json,old,gz,shtml,log,swp,yaml,yml,config,save,rsa,ppk -ac -o $dir/$1.tmp
# ffuf -mc all -c -H "X-Forwarded-For: 127.0.0.1" -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0" -u "$ffufdomain/FUZZ" -w ~/tools/dirsearch/db/dicc.txt -D -e js,php,bak,txt,asp,aspx,jsp,html,zip,jar,sql,json,old,gz,shtml,log,swp,yaml,yml,config,save,rsa,ppk -of csv -o $dir/$1.tmp
ffuf -t 80 -c -sf -fc '404,429,501,502,503' -H "X-Forwarded-For: 127.0.0.1" -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0" -D -e '.asp,.aspx,.backup,.bak,.conf,.config,.db,.gz,.gz.tar,.htaccess,.htm,.html,.js,.json,.jsp,.log,.old,.php,.py,.shtml,.sql,.swf,.swp,.tar.gz,.txt,.xml,.zip' -of csv -o $dir/$1.tmp -u "$ffufdomain/FUZZ" -w ~/tools/dirsearch/db/dicc.txt -mode clusterbomb -v -r true -recursion -recursion-depth 2

# cat $dir/$1.tmp | jq '[.results[]|{status: .status, length: .length, url: .url}]' | grep -oP "status\":\s(\d{3})|length\":\s(\d{1,7})|url\":\s\"(http[s]?:\/\/.*?)\"" | paste -d' ' - - - | awk '{print $2" "$4" "$6}' | sed 's/\"//g' > $dir/result_dir.txt
cat $dir/$1.tmp | csvcut -c 2,5,1,3,4 | csvlook | tee $dir/result_dir.txt
