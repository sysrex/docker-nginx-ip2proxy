FROM debian:buster

RUN apt-get update && apt-get install -y wget git build-essential zlib1g-dev libpcre3 libpcre3-dev libssl-dev libtool autoconf automake

RUN mkdir /usr/local/src/ip2proxy-dev && cd /usr/local/src/ip2proxy-dev

RUN cd /usr/local/src/ip2proxy-dev \
    && git clone https://github.com/ip2location/ip2proxy-c.git \
    && ( \
        cd ip2proxy-c \
        && autoreconf -i -v --force \
        &&  ./configure \
        && make \
        && make install \
    ) \
    && ldconfig

RUN cd /usr/local/src/ip2proxy-dev \
    && git clone https://github.com/ip2location/ip2proxy-nginx

RUN wget http://nginx.org/download/nginx-1.25.1.tar.gz \
    && tar -xvzf nginx-1.25.1.tar.gz \
    && ( \
        cd nginx-1.25.1 \
        && ./configure \
            --sbin-path=/usr/sbin/nginx \
            --conf-path=/etc/nginx/nginx.conf \
            --with-http_ssl_module \
            --with-stream \
            --with-stream_ssl_module \
            --pid-path=/run/nginx.pid \
            --with-http_realip_module \
            --add-module=/usr/local/src/ip2proxy-dev/ip2proxy-nginx \
        && make \
        && make install \
    )

RUN mkdir /etc/nginx/conf.d \
    && mkdir /etc/nginx/sites-enabled/

EXPOSE 80
