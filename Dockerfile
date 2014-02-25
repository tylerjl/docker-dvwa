FROM dockerfiles/centos-lamp
MAINTAINER Tyler Langlois <ty@tjll.net>

# Operating in the webroot
WORKDIR /var/www/html

# Install DVWA files
RUN wget https://github.com/RandomStorm/DVWA/archive/v1.0.8.tar.gz -O- | tar xvz --strip-components=1
RUN ln -s README.{md,txt}
RUN ln -s CHANGELOG.{md,txt}

# Setup DB user
RUN service mysqld start && mysqladmin -uroot password $(awk '/db_password/{print $NF}' config/config.inc.php | sed -r "s/.*'([^']+)'.*/\1/") && service mysqld stop

EXPOSE 80

CMD ["supervisord", "-n"]
