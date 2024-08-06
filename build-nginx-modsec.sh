#!/bin/sh


checkfail() {
 ERRCODE=$1; shift;
 if test $ERRCODE -ne 0 ; then
   shift; 
   echo  $*
   exit $ERROCODE
 fi
}

cd /opt

# apt update && apt install -y nginx libnginx-mod-http-headers-more-filter libmodsecurity3 modsecurity-crs git wget curl gcc make 
# cd /opt && git clone --depth 1 https://github.com/SpiderLabs/ModSecurity-nginx.git

NGINX_VERSION=`nginx -V 2>&1 | head  -1|  awk '{ print $3; }' | sed 's%/%-%g'`
wget http://nginx.org/download/$NGINX_VERSION.tar.gz
tar -xvzmf $NGINX_VERSION.tar.gz
checkfail $? "Nginx download failed"
cd $NGINX_VERSION
checkfail $? "gcc make installs failed"

#export MODSECURITY_LIB="/usr/local/modsecurity/lib/"
#export MODSECURITY_INC="/usr/local/modsecurity/include/modsecurity/"

./configure --add-dynamic-module=/opt/ModSecurity-nginx
checkfail $? "nginx configure failed"

make modules
checkfail $? "make modules failed"

find . -name *.so > /opt/built-files.txt
mkdir -p /etc/nginx/modules
cp objs/*module.so /etc/nginx/modules
cp /opt/built-files.txt /etc/nginx/
ls -altr /opt/ModSecurity-nginx


### configure arguments: --with-cc-opt='-g -O2 -ffile-prefix-map=/build/nginx-zctdR4/nginx-1.18.0=. -flto=auto -ffat-lto-objects -flto=auto -ffat-lto-objects -fstack-protector-strong -Wformat -Werror=format-security -fPIC -Wdate-time -D_FORTIFY_SOURCE=2' --with-ld-opt='-Wl,-Bsymbolic-functions -flto=auto -ffat-lto-objects -flto=auto -Wl,-z,relro -Wl,-z,now -fPIC' --prefix=/usr/share/nginx --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log --lock-path=/var/lock/nginx.lock --pid-path=/run/nginx.pid --modules-path=/usr/lib/nginx/modules --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-compat --with-debug --with-pcre-jit --with-http_ssl_module --with-http_stub_status_module --with-http_realip_module --with-http_auth_request_module --with-http_v2_module --with-http_dav_module --with-http_slice_module --with-threads --add-dynamic-module=/build/nginx-zctdR4/nginx-1.18.0/debian/modules/http-geoip2 --with-http_addition_module --with-http_flv_module --with-http_geoip_module=dynamic --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module=dynamic --with-http_mp4_module --with-http_perl_module=dynamic --with-http_random_index_module --with-http_secure_link_module --with-http_sub_module --with-http_xslt_module=dynamic --with-mail=dynamic --with-mail_ssl_module --with-stream=dynamic --with-stream_geoip_module=dynamic --with-stream_ssl_module --with-stream_ssl_preread_module --add-dynamic-module=/build/nginx-zctdR4/nginx-1.18.0/debian/modules/http-headers-more-filter --add-dynamic-module=/build/nginx-zctdR4/nginx-1.18.0/debian/modules/http-auth-pam --add-dynamic-module=/build/nginx-zctdR4/nginx-1.18.0/debian/modules/http-cache-purge --add-dynamic-module=/build/nginx-zctdR4/nginx-1.18.0/debian/modules/http-dav-ext --add-dynamic-module=/build/nginx-zctdR4/nginx-1.18.0/debian/modules/http-ndk --add-dynamic-module=/build/nginx-zctdR4/nginx-1.18.0/debian/modules/http-echo --add-dynamic-module=/build/nginx-zctdR4/nginx-1.18.0/debian/modules/http-fancyindex --add-dynamic-module=/build/nginx-zctdR4/nginx-1.18.0/debian/modules/nchan --add-dynamic-module=/build/nginx-zctdR4/nginx-1.18.0/debian/modules/rtmp --add-dynamic-module=/build/nginx-zctdR4/nginx-1.18.0/debian/modules/http-uploadprogress --add-dynamic-module=/build/nginx-zctdR4/nginx-1.18.0/debian/modules/http-upstream-fair --add-dynamic-module=/build/nginx-zctdR4/nginx-1.18.0/debian/modules/http-subs-filter

