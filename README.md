# Nginx with IP2Proxy HTTP Module

### Configuration

```
Syntax      : ip2proxy
Value       : on | off
Default     : off
Context     : http, server, location
Description : Enable of disable IP2Proxy module.
```

```
Syntax      : ip2proxy_database
Value       : [Absolute path to IP2Proxy database]
Default     : none
Context     : http, server, location
Description : The absolute path to IP2Proxy BIN database file.
```

```
Syntax      : ip2proxy_access_type
Value       : file_io | shared_memory | cache_memory
Default     : file_io
Context     : http, server, location
Description : Define the lookup mode for best performance practice.
```

```
Syntax      : ip2proxy_reverse_proxy
Value       : on | off
Default     : off
Context     : http, server, location
Description : Detect X-Forwareded-For header for actual visitor IP if Nginx is behind a reverse proxy.
```

### Example of nginx.conf

```
http {
        ...

        ip2proxy on;
        ip2proxy_database /ip2proxy/databases/DB4.BIN;
        ip2proxy_access_type shared_memory;
        ip2proxy_reverse_proxy on;
        
        # Add custom headers so the values are accessible from PHP
        add_header IP2Proxy-Country-Code $ip2proxy_country_short;
        add_header IP2Proxy-Country-Name $ip2proxy_country_long;
        add_header IP2Proxy-Region $ip2proxy_region;
        add_header IP2Proxy-City $ip2proxy_city;
        add_header IP2Proxy-ISP $ip2proxy_isp;
        add_header IP2Proxy-Is-Proxy $ip2proxy_is_proxy;
        add_header IP2Proxy-Proxy-Type $ip2proxy_proxy_type;

        ...
}

```
