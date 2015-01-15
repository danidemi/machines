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
RUN ["/etc/init.d/mysql", "start"]

# Install Wordpress Cli
RUN mkdir -p /install/wordpress; \
 cd /install/wordpress; \
 wget https://raw.github.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
 chmod +x wp-cli.phar; \
 mv wp-cli.phar /usr/local/bin/wp

# wordpress-db
RUN ["echo \"CREATE DATABASE wordpress;\" > /tmp/param; /etc/init.d/mysql start; mysql -u root --password=cms < /tmp/param"]

# wordpress
RUN ["/etc/init.d/mysql start; mkdir /var/www/html/wordpress; cd /var/www/html/wordpress; wp core download --allow-root; wp core config --allow-root --dbname=wordpress --dbuser=root --dbpass=cms"]

# enable FTP
RUN adduser --disabled-password --gecos "" cms; \
 usermod -d /var/www/html cms; \
 usermod -g root cms; \
 mkdir -p /var/run/vsftpd/empty; \
 chmod -R ugo+rw /var/www;

RUN ["/bin/bash", "-c", "echo -e \"cms\\ncms\" > tmp/pwd; passwd cms < tmp/pwd"]

COPY bashrc.extension.txt /tmp/
RUN ["cat /tmp/bashrc.extension.txt >> /etc/bash.bashrc"]

EXPOSE 80
EXPOSE 20
EXPOSE 3306



