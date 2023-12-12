FROM php:7.4-apache

# Define
ARG USERNAME
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Install and Setup
RUN apt -y update && \
    apt -y upgrade && \
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt -y install vim sudo tzdata git wget nodejs python3-pip libzip-dev cron && \
    npm install -g yarn && \
    yarn global add @vue/cli

# Setup Composer
WORKDIR /var
RUN wget -O composer-setup.php https://getcomposer.org/installer && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    composer self-update

# Setup php.ini, extentions
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini" && \
    sed -ri -e 's/;extension=mysqli/extension=mysqli/g' $PHP_INI_DIR/php.ini && \
    docker-php-ext-install mysqli pdo_mysql zip

# Add User
RUN useradd --uid ${USER_UID} --create-home --shell /bin/bash -G sudo,root ${USERNAME} && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Setting setup.sh
COPY setup.sh /var/setup.sh
RUN chmod 700 /var/setup.sh && \
    chown ${USERNAME}:${USERNAME} /var/setup.sh

# User Settings
USER 1000
ENV PATH $PATH:/home/${USERNAME}/.composer/vendor/bin
RUN composer global require "laravel/installer=^4.0"

CMD sh /var/setup.sh && sudo sudo apache2-foreground
