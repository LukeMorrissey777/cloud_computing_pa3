sudo apt-get update 
sudo apt-get install bind9
sudo apt-get install dnsutils

sudo cp dns_config/db.172 /etc/bind/db.172
sudo cp dns_config/named.conf.local /etc/bind/named.conf.local
sudo cp dns_config/db.lukemorrisseycc.com /etc/bind/db.lukemorrisseycc.com

sudo systemctl restart bind9