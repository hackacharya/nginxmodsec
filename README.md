
# Notes
---------
Some dockerfiles for bulding nginx with modsec
Dockerfiles for building nginx with more filters and modsec 

docker-entrypoint scripts are from default nginx package.


# Building
---------

# if you want cacheless build set this evenv

make NGXBLD_ARGS="--no-cache" 

make ubuntu


make debian

make alpine # work TBD.

# To build and include modsec seperately - work to be done

make modsec


## Random notes.
---------

# To load the mod_security module
# /usr/lib/nginx/modules/ngx_http_modsecurity_module.so
# Mod security configuration 

# Relavent config files.
/etc/nginx/modsecurity.conf
/etc/nginx/sites-available/default-modsecurity.conf
/etc/nginx/modsecurity_includes.conf
/etc/nginx/modules-enabled/50-mod-http-headers-more-filter.conf
/etc/nginx/modules-enabled/10-mod-http-ndk.conf
/etc/nginx/modules-enabled/50-mod-http-modsecurity.conf

# CRS config files
/etc/modsecurity/crs/crs-setup.conf

# Modules at /usr/share/nginx/modules
load_module modules/ngx_http_headers_more_filter_module.so;
load_module modules/ngx_http_modsecurity.so
load_module modules/ndk_http_module.so


# We need atleast the following modules.
nginx version: nginx/1.25.5
built by gcc 12.2.0 (Debian 12.2.0-14) 
built with OpenSSL 3.0.9 30 May 2023 (running with OpenSSL 3.0.11 19 Sep 2023)
TLS SNI support enabled
configure arguments: --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --user=nginx --group=nginx --with-compat --with-file-aio --with-threads --with-http_addition_module --with-http_auth_request_module --with-http_dav_module --with-http_flv_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-http_v3_module --with-mail --with-mail_ssl_module --with-stream --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-cc-opt='-g -O2 -ffile-prefix-map=/data/builder/debuild/nginx-1.25.5/debian/debuild-base/nginx-1.25.5=. -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC' --with-ld-opt='-Wl,-z,relro -Wl,-z,now -Wl,--as-needed -pie'




Other modules part of 1.25.5 default build.
/usr/lib/nginx/modules

-rw-r--r-- 1 root root   19864 Apr 16 15:39 ngx_stream_geoip_module.so
-rw-r--r-- 1 root root   19864 Apr 16 15:39 ngx_stream_geoip_module-debug.so
-rw-r--r-- 1 root root   23400 Apr 16 15:39 ngx_http_xslt_filter_module.so
-rw-r--r-- 1 root root   23400 Apr 16 15:39 ngx_http_xslt_filter_module-debug.so
-rw-r--r-- 1 root root   27568 Apr 16 15:39 ngx_http_image_filter_module.so
-rw-r--r-- 1 root root   27568 Apr 16 15:39 ngx_http_image_filter_module-debug.so
-rw-r--r-- 1 root root   20232 Apr 16 15:39 ngx_http_geoip_module.so
-rw-r--r-- 1 root root   20232 Apr 16 15:39 ngx_http_geoip_module-debug.so
-rw-r--r-- 1 root root  980264 May  1 00:00 ngx_stream_js_module.so
-rw-r--r-- 1 root root  984360 May  1 00:00 ngx_stream_js_module-debug.so
-rw-r--r-- 1 root root 1002184 May  1 00:00 ngx_http_js_module.so
-rw-r--r-- 1 root root 1006280 May  1 00:00 ngx_http_js_module-debug.so


# Root /usr/share/nginx/html

1.24 our build vs 1.25.5 default configure diffs
 ---------------------------
1. user nginx
2. pid directory
3. > --with-http_geoip_module=dynamic 
4. > --with-http_image_filter_module=dynamic 
5. > --with-http_perl_module=dynamic 
6. > --with-stream=dynamic 
7. > --with-stream_geoip_module=dynamic
8  > --user=www-data


# 
modsecurity_includes.conf --> modsecurity.conf
			  --> crs.load --> crs rule sets /usr/share
