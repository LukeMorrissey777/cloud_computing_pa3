# Install apache
sudo apt-get update
sudo apt-get install apache2 -y

# Install apache modules
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2enmod proxy_balancer
sudo a2enmod lbmethod_byrequests

sudo cp lb_config/lb-000-default.conf /etc/apache2/sites-available/000-default.conf

sudo service apache2 restart