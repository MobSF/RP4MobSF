export EXT_DIR='/home/debian/nginx_mobsfv2/conf'
docker run -d \
-p 80:80 -p 443:443 \
-e 'DH_SIZE=512' \
-e 'FORWARD_HOST=172.17.0.2' \
-e 'FORWARD_PORT=8000' \
-v $EXT_DIR:/etc/nginx/external/ \
--name nginx_mobsf \
devopssea.bzh/nginx_mobsf  

