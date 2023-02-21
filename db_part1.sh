echo "Which server is this?"
echo "Enter '1' for db server 1"
echo "Enter '2' for db server 2"
read db_num
cat db${db_num}.cnf

sudo apt-get update
# Install mariadb
sudo apt-get install python3-dev mariadb-server libmariadbclient-dev libssl-dev -y
# This essentially runs mysql_secure_installation script without prompts
sudo mysql -e "UPDATE mysql.user SET Password = PASSWORD('password') WHERE User = 'root'"
sudo mysql -e "DROP USER ''@'localhost'"
sudo mysql -e "DROP USER ''@'$(hostname)'"
sudo mysql -e "DROP DATABASE test"
sudo mysql -e "FLUSH PRIVILEGES"

# Change some config stuff necessary for db replication
sudo cp db${db_num}.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
sudo systemctl restart mariadb

# Create user that can access db remotely
sudo mysql -e "CREATE DATABASE myproject CHARACTER SET UTF8;"
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'192.168.100.%' IDENTIFIED BY 'password' WITH GRANT OPTION;"
sudo mysql -e "FLUSH PRIVILEGES"

# Create user for replication
sudo mysql -e "CREATE USER 'replication'@'%' identified by 'securepassword';"
sudo mysql -e "GRANT REPLICATION SLAVE ON *.* TO 'replication'@'%';"
sudo mysql -e "FLUSH PRIVILEGES"