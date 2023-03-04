echo "Which server is this?"
echo "Enter '1' for ws server 1"
echo "Enter '2' for ws server 2"
echo "Enter '3' for ws server 3"
read ws_num

# Install and start python virtual environment
sudo apt-get update
sudo apt install python3.8-venv -y
python3 -m venv venv
source venv/bin/activate

# Install django
pip install django==3.2

# Install mariadb
sudo apt-get install python3-dev mariadb-server libmariadbclient-dev libssl-dev -y
# This essentially runs mysql_secure_installation script without prompts
sudo mysql -e "UPDATE mysql.user SET Password = PASSWORD('password') WHERE User = 'root'"
sudo mysql -e "DROP USER ''@'localhost'"
sudo mysql -e "DROP USER ''@'$(hostname)'"
sudo mysql -e "DROP DATABASE test"
sudo mysql -e "FLUSH PRIVILEGES"

pip install mysqlclient packaging

#Install apache
sudo apt-get install apache2 libapache2-mod-wsgi-py3 -y

# Install django cms
pip install --upgrade pip
pip install django-cms
pip install django-filer
pip install djangocms-text-ckeditor django-storages
pip install djangocms-link djangocms-file djangocms-picture djangocms-video djangocms-googlemap djangocms-snippet djangocms-style

# Migrate data to db
if [ $ws_num = '1' ]
then
    python manage.py migrate
    # Create superuser
    export DJANGO_SUPERUSER_PASSWORD=password
    python manage.py createsuperuser --noinput --username user --email luke.morrissey@colorado.edu
fi
python manage.py collectstatic



# Add second database availability
echo "DATABASE_ROUTERS = ['myproject.db_router.DBRouter']" >> myproject/settings.py

sudo cp ws_config/ws-000-default.conf /etc/apache2/sites-available/000-default.conf

# Restart apache webserver
sudo service apache2 restart

echo "-----------------------------------------"
echo "Username is 'user'"
echo "Password is 'password'"

