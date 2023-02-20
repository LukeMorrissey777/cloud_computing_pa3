sudo apt-get update
# Install mariadb
sudo apt-get install python3-dev mariadb-server libmariadbclient-dev libssl-dev -y
# This essentially runs mysql_secure_installation script without prompts
sudo mysql -e "UPDATE mysql.user SET Password = PASSWORD('password') WHERE User = 'root'"
sudo mysql -e "DROP USER ''@'localhost'"
sudo mysql -e "DROP USER ''@'$(hostname)'"
sudo mysql -e "DROP DATABASE test"
sudo mysql -e "FLUSH PRIVILEGES"

# Create maria-db database
sudo mysql -e "CREATE DATABASE myproject CHARACTER SET UTF8;"
sudo mysql -d "GRANT ALL PRIVILEGES ON *.* TO 'root'@'192.168.100.%' IDENTIFIED BY 'my-new-password' WITH GRANT OPTION;"
sudo mysql -e "FLUSH PRIVILEGES"