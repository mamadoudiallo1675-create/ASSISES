# Site Assises CNJ-Mali : PHP 8.3 + Apache. Construire : docker build -t assises .
FROM php:8.3-apache
RUN apt-get update && apt-get install -y --no-install-recommends libpng-dev libfreetype6-dev libjpeg-dev \
 && docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install -j"$(nproc)" gd pdo_mysql \
 && a2enmod rewrite headers \
 && sed -ri 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf \
 && rm -rf /var/lib/apt/lists/*
COPY . /var/www/html/
# Les clés viennent des variables d'environnement (voir .env.example), jamais de l'image.
RUN chown -R www-data:www-data /var/www/html
EXPOSE 80
