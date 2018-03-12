FROM alpine:3.7
MAINTAINER Toshiyuki HIRANO <hiracchi@gmail.com>


RUN apk update \
  && apk add bash curl \
    apache2 \
    php7 \
    php7-apache2 php7-cgi php7-common php7-fileinfo php7-gd \
    php7-iconv php7-imagick php7-intl php7-json \
    php7-mbstring php7-mcrypt \
    php7-openssl php7-session php7-xml \
    php7-zip php7-zlib \
    imagemagick \
  && rm -rf /var/cache/apk/*

RUN mkdir /web \
  && chown -R apache:apache /web \
  && mkdir -p /run/apache2 \
  && sed -i 's|^#ServerName .*|ServerName localhost:80|g' /etc/apache2/httpd.conf \
  && sed -i 's#^DocumentRoot ".*#DocumentRoot "/web"#g' /etc/apache2/httpd.conf \
  && sed -i 's#<Directory "/var/www/localhost/htdocs">#<Directory "/web">#' /etc/apache2/httpd.conf

#  && sed -i 's#AllowOverride none#AllowOverride All#' /etc/apache2/httpd.conf

ADD scripts/ /usr/local/bin/
EXPOSE 80
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["/usr/local/bin/run.sh"]
# CMD ["tail -f /dev/null"]
