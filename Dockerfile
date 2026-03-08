# Imagen base oficial de PHP con Apache
FROM php:8.2-apache

# Instalar extensiones necesarias
RUN docker-php-ext-install pdo pdo_mysql mbstring

# Habilitar mod_rewrite para Laravel
RUN a2enmod rewrite

# Copiar el proyecto al contenedor
COPY . /var/www/html/

# Configurar Apache para que la raíz sea /var/www/html/public
WORKDIR /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Cambiar configuración de Apache
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|' /etc/apache2/sites-available/000-default.conf

# Exponer puerto
EXPOSE 80

# Iniciar Apache
CMD ["apache2-foreground"]
