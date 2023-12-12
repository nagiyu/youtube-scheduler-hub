#!/bin/sh

# Setup Appache rewrite_module
sudo a2enmod rewrite

# Setup DocumentRoot
sudo chmod 777 -R /var/www

# Setup Link
ln -s /app/server/dist /var/www/html

# Change Permittion
# sudo chmod -R 777 /app/server/storage/*
# sudo chmod -R 777 /app/server/bootstrap/cache

# Change Owner
sudo chown -R 1000 /app/server/vendor
sudo chown -R 1000 /app/server/node_modules
