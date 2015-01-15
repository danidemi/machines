debconf-set-selections <<< 'mysql-server mysql-server/root_password password cms'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password cms'

apt-get install -y \
 apache2 \
 libapache2-mod-auth-mysql \
 libapache2-mod-php5 \
 mysql-server \
 php5 \
 php5-mysql \
 vsftpd \
 wget

mysql_install_db

/etc/init.d/mysql start

mkdir -p /install/wordpress; \
cd /install/wordpress; \
wget https://raw.github.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
chmod +x wp-cli.phar; \
mv wp-cli.phar /usr/local/bin/wp

mysql -u root --password=cms <<< "CREATE DATABASE wordpress;"

/etc/init.d/mysql start 
mkdir /var/www/html/wordpress
cd /var/www/html/wordpress
wp core download --allow-root
wp core config --allow-root --dbname=wordpress --dbuser=root --dbpass=cms

# enable FTP
adduser --disabled-password --gecos "" cms
usermod -d /var/www/html cms
usermod -g root cms
mkdir -p /var/run/vsftpd/empty
chmod -R ugo+rw /var/www

passwd cms <<TAG
cms
cms
TAG


