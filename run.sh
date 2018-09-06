export CONF_DIR='/home/debian/nginx_mobsfv2/conf/conf.d'
export PKI_DIR='/home/debian/nginx_mobsfv2/conf/pki'
export AUTH_DIR='/home/debian/nginx_mobsfv2/conf/auth'
docker run -d \
-p 80:80 -p 443:443 \
-e 'DH_SIZE=512' \
-e 'FORWARD_HOST=172.17.0.2' \
-e 'FORWARD_PORT=8000' \
-v $CONF_DIR:/etc/nginx/conf.d:rw \
-v $PKI_DIR:/etc/nginx/pki:rw \
-v $AUTH_DIR:/etc/nginx/auth:ro \
--name nginx_mobsf \
devopssea.bzh/nginx_mobsf  

