# Install and start python virtual environment
sudo apt-get update
sudo apt install python3.8-venv -y
python3 -m venv venv
source venv/bin/activate

# Install django
pip install django==3.2

pip install mysqlclient packaging

#Install apache
sudo apt-get install apache2 libapache2-mod-wsgi-py3 -y

# Install django cms
pip install --upgrade pip
pip install django-cms
pip install django-filer
pip install djangocms-text-ckeditor
pip install djangocms-link djangocms-file djangocms-picture djangocms-video djangocms-googlemap djangocms-snippet djangocms-style

# Migrate data to db
python manage.py migrate --database=db1
python manage.py collectstatic
sudo mv 000-default.conf /etc/apache2/sites-available/

# Create superuser
export DJANGO_SUPERUSER_PASSWORD=password
python manage.py createsuperuser --noinput --username user --email luke.morrissey@colorado.edu

# Restart apache webserver
sudo service apache2 restart

echo "-----------------------------------------"
echo "Username is 'user'"
echo "Password is 'password'"

