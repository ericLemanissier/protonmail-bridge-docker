echo [127.0.0.1]:1025 $1:$2 >/etc/postfix/sasl_passwd
postmap /etc/postfix/sasl_passwd
service postfix restart
service postfix status
