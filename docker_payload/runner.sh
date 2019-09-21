#!/bin/bash

if [ -z "$(ls -A /var/www/html/magento2)" ]; then
   mv /magento2/* /magento2/.* /var/www/html/magento2/
   find . -type f -exec chmod 664 {} \;
   find . -type d -exec chmod 775 {} \;
   find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} + 
   find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} +
   chown -R :www-data .
   chmod -R a+w+r var
   chmod -R a+w+r app
   chmod u+x bin/magento

   echo "CREATE DATABASE IF NOT EXISTS $DB_NAME;" | mysql -h $DB_HOST -P 3306 -u $DB_USER -p$DB_PASS
  #Install Magneto
   bin/magento setup:install \
   --base-url=$BASE_URL \
   --db-host=$DB_HOST \
   --db-name=$DB_NAME \
   --db-user=$DB_USER \
   --db-password=$DB_PASS \
   --backend-frontname=$BACKEND_FRONTNAME \
   --admin-firstname=$ADMIN_FIRST_NAME \
   --admin-lastname=$ADMIN_LAST_NAME \
   --admin-email=$ADMIN_EMAIL \
   --admin-user=$ADMIN_USERNAME \
   --admin-password=$ADMIN_PASSWORD \
   --language=$LANGUAGE \
   --currency=$CURRENCY \
   --timezone=$TIMEZONE \
   --session-save="db" \
   --use-rewrites=1 >> /var/log/installMagento.log 2>&1
   bin/magento cron:install
else
   echo "Not Empty"
fi

apache2ctl -D FOREGROUND &

cat /var/log/installMagento.log
tailf /var/log/apache2/*.log

