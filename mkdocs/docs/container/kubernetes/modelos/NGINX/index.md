```yaml
# docker-compose.yaml
version: '3.9'
services:
  nginx:
    container_name: nginx-lb
    labels:
        - app=nginx
        - function=loadbalancer
    restart: unless-stopped
    ports:
        - '80:80'
        - '443:443'
        - '6443:6443'
        - '9345:9345'
    volumes:
        - '/opt/nginx/nginx.conf:/etc/nginx/nginx.conf'
    image: 'nginx:latest'
```

```conf
# nginx.conf
worker_processes 4;
worker_rlimit_nofile 40000;
events {
    worker_connections 8192;
}
http {
    server {
        listen         80;
        return 301 https://$host$request_uri;
    }
}
stream {
    ## LB for the RKE
    ## KUBE-API
    upstream rke2_api {
        server 10.21.250.67:6443 max_fails=3 fail_timeout=5s;
        server 10.21.250.68:6443 max_fails=3 fail_timeout=5s;
        server 10.21.250.69:6443 max_fails=3 fail_timeout=5s;
        least_conn;
    }
    ## Master
    upstream rke2_master {
        server 10.21.250.67:443 max_fails=3 fail_timeout=5s;
        server 10.21.250.68:443 max_fails=3 fail_timeout=5s;
        server 10.21.250.69:443 max_fails=3 fail_timeout=5s;
        least_conn;
    }
    ## Node register in Master
    upstream rke2_register {
        server 10.21.250.67:9345 max_fails=3 fail_timeout=5s;
        server 10.21.250.68:9345 max_fails=3 fail_timeout=5s;
        server 10.21.250.69:9345 max_fails=3 fail_timeout=5s;
        least_conn;
    }
    ## LB for the K8S Workers
    upstream rke2_workers {
        least_conn;
        server 10.21.250.76:443 max_fails=3 fail_timeout=5s;
        server 10.21.250.77:443 max_fails=3 fail_timeout=5s;
        server 10.21.250.78:443 max_fails=3 fail_timeout=5s;
    }
    server {
        listen     443;
        proxy_pass rke2_workers;
    }
    server {
        listen     6443;
        proxy_pass rke2_api;
    }
    server {
        listen     9345;
        proxy_pass rke2_register;
    }
}
```