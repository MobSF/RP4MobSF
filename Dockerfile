FROM nginx
LABEL maintainer="superpoussin22"

ENV LANG C.UTF-8 \
ENV FORWARD_PORT=80
ENV FORWARD_HOST=web

RUN apt-get update; apt-get install -y \
    openssl

RUN rm -rf /etc/nginx/conf.d/*; \
    mkdir -p /etc/nginx/external/pki

RUN sed -i 's/access_log.*/access_log \/dev\/stdout;/g' /etc/nginx/nginx.conf; \
    sed -i 's/error_log.*/error_log \/dev\/stdout info;/g' /etc/nginx/nginx.conf; \
    sed -i 's/^pid/daemon off;\npid/g' /etc/nginx/nginx.conf

#ADD ./conf/basic.conf /etc/nginx/conf.d/basic.conf
#ADD ./conf/ssl.conf /etc/nginx/conf.d/ssl.conf
#ADD ./auth.htpasswd /etc/nginx/auth.htpasswd
#ADD ./conf/auth.conf /opt/auth.conf

ADD entrypoint.sh /opt/entrypoint.sh
RUN chmod a+x /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["nginx"]
