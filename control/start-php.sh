# -*-shell-script-*-

#Ensure proper enviornment variables
export LD_LIBRARY_PATH=$app_dir/lib/:/usr/local/lib/:/usr/lib/
export PATH=\$PATH:\$LD_LIBRARY_PATH

httpd -k start -f "$app_dir/conf/httpd.conf" -D FOREGROUND

#check that it's started properly
curl localhost:$app_port/check.php
