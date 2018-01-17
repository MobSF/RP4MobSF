# RP4MobSF
## a nginx reverse proxy with ssl and auth for MobSF

## This docker image will let you run a ssl reverse proxy with basic authentication in front of your mobsf 


1) to build the image 

   * if you are behing a proxy 
     * docker build --no-cache --build-arg http_proxy=${http_proxy} --build-arg https_proxy=${https_proxy}  -t rp4mobsf:latest .

   * if not :
     * docker build --no-cache  -t rp4mobsf:latest . 

2) you have a run.sh you can customize for your need :

 > export EXT_DIR='/home/debian/nginx_mobsfv2/conf'
 > docker run -d \
 > -p 80:80 -p 443:443 \
 > -e 'DH_SIZE=512' \
 > -e 'FORWARD_HOST=172.17.0.2' \
 > -e 'FORWARD_PORT=8000' \
 > -v $EXT_DIR:/etc/nginx/external/ \
 > --name rp4mobsf \
 > rp4mobsf:latest 

3) Parameters:


   * EXT_DIR is the path to your conf directory which contain configuration and certificate
   * FORWARD_HOST is the @IP or FQDN or your MobSF server 
   * FORWARD_PORT is the port used to access MOBSF web interface

4) Default user :

   * Default user is foo password bar

5) Managing password 

* if you want to change or add user, you must use htpasswd binary to generate password and put the poassword in the auth.htppasswd file located in your conf directory 

  * syntax will be :

    * htpasswd -b ./conf/auth.htpasswd foo bar  (for user foo with password bar)

  * to install and use htpasswd on your system refer too : 
    * https://httpd.apache.org/docs/current/programs/htpasswd.html
    
6) Certificates 

  * if you already have certificates put it in conf/pki/  ($EXT_DIR/pki/)
  * if you don't have the image will create autosigned certificates


This image is based on:
MarvAmBass/docker-nginx-ssl-secure
