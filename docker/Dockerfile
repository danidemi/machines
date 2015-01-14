# Build an image for a container running different CMS.
# The goal of this container is not to be used to actually host a CMS, but just to have a personal
# playground for different CMS.
FROM ubuntu:14.04

RUN ["/bin/bash", "-c", "debconf-set-selections <<< 'mysql-server mysql-server/root_password password cms'"]
RUN ["/bin/bash", "-c", "debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password cms'"]

RUN apt-get install -y \
	apache2 \
	libapache2-mod-auth-mysql \
	libapache2-mod-php5 \
	mysql-server \
	php5 \
	php5-mysql \
	vsftpd \
	wget

RUN mysql_install_db

# Install Wordpress Cli
RUN	mkdir -p /install/wordpress; \
	cd /install/wordpress; \
	wget https://raw.github.com/wp-cli/builds/gh-pages/phar/wp-cli.phar ; \
	chmod +x wp-cli.phar; \
	mv wp-cli.phar /usr/local/bin/wp

# wordpress-db
RUN mysql -u root --password=cms <<EOFMYSQL \
	CREATE DATABASE wordpress; \
EOFMYSQL

# wordpress
RUN	mkdir /var/www/html/wordpress; \
	cd /var/www/html/wordpress; \
	wp core download --allow-root; \
	wp core config --allow-root --dbname=wordpress --dbuser=root --dbpass=cms

# enable FTP
RUN	adduser --disabled-password --gecos "" csm; \
	usermod -d /var/www/html csm; \
	usermod -g root csm # change csm's primary group to root; \
	mkdir -p /var/run/vsftpd/empty; \
	chmod -R ugo+rw /var/www; \
chgpasswd cms <<TAG \
cms \
cms \
TAG

EXPOSE 80
EXPOSE 20



