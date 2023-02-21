echo "What is the ip of the other DB?"
read db_ip
echo "The following two can be found by running (SHOW MASTER STATUS;) on the other DB"
echo "What is the master log file name?"
read master_file
echo "What is the master log position?"
read log_position


sudo mysql -e "STOP SLAVE;"
sudo mysql -e "CHANGE MASTER TO MASTER_HOST = '${db_ip}', MASTER_USER = 'replication', MASTER_PASSWORD = 'securepassword', MASTER_LOG_FILE = '${master_file}', MASTER_LOG_POS = ${log_position};"
sudo mysql -e "START SLAVE;"