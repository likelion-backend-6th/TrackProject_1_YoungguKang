FROM ubuntu:22.04

RUN apt-get update && apt install -y nginx vim
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/lib/nginx

COPY ./twitter/twitter/django.nginx /etc/nginx/sites-available/django
RUN ln -s /etc/nginx/sites-available/django /etc/nginx/sites-enabled/django

WORKDIR /etc/nginx

RUN mkdir /var/www/html/static

COPY ./scripts/nginx_entry /entrypoint
RUN sed -i 's/\r$//g' /entrypoint
RUN chmod +x /entrypoint

ENTRYPOINT [ "/entrypoint" ]
CMD ["nginx"]

EXPOSE 80
EXPOSE 443