FROM centos:latest

LABEL maintainer="apaydin541@gmail.com"

# -----------------------------------------------------------------------------
# Install PHP Latest
# -----------------------------------------------------------------------------
RUN dnf -y install https://rpms.remirepo.net/enterprise/remi-release-8.rpm
RUN dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
RUN dnf -y module install php:remi-7.4
RUN yum -y update
RUN yum -y --setopt=tsflags=nodocs --nogpgcheck install \
        php-cli \
        php-fpm \
        php-gd \
        php-common \
        php-intl \
        php-json \
        php-mbstring \
        php-process \
        php-opcache \
        php-pdo \
        php-pear \
        php-pecl-redis \
        php-pecl-memcached \
        php-mysqlnd \
        php-tidy \
        php-openssl \
        php-xml \
        php-zip \
        #php-ldap  \
        #php-bcmath \
        #php-mcrypt \
        #php-soap \
        #php-xmlrpc \
        && yum clean all


# -----------------------------------------------------------------------------
# Composer
# -----------------------------------------------------------------------------
RUN php -r "copy('https://getcomposer.org/installer', '/composer-setup.php');"
RUN php /composer-setup.php --install-dir=/usr/local/bin --filename=composer


# -----------------------------------------------------------------------------
# UTC Timezone & Networking
# -----------------------------------------------------------------------------
RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime && echo "NETWORKING=yes" > /etc/sysconfig/network

# -----------------------------------------------------------------------------
# Copy Files
# -----------------------------------------------------------------------------
COPY ./php/*.ini /etc/php.d/
COPY ./php-fpm/www.conf /etc/php-fpm.d/
RUN mkdir /var/run/php-fpm

# -----------------------------------------------------------------------------
# Create PHP-FPM & Nginx User
# -----------------------------------------------------------------------------
#RUN useradd -s /bin/false nginx

# -----------------------------------------------------------------------------
# Config Loader
# -----------------------------------------------------------------------------
COPY ./loadConfig.sh /loadConfig.sh
RUN chmod +x /loadConfig.sh
ENTRYPOINT [ "/loadConfig.sh" ]

# Set Workdir
WORKDIR /app/

EXPOSE 9000
CMD ["php-fpm", "-F"]
