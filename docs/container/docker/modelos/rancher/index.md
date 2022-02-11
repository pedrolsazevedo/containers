
```docker-cli
docker run -dit -name rancher-ui --restart=unless-stopped \
  -p 80:80 -p 443:443 \
  -v /opt/rancher:/var/lib/rancher \
  --privileged \
  rancher/rancher:latest
```

```yaml
version: '3.9'
services:
  rancher:
    image: 'rancher/rancher:latest'
    container_name: rancher-server
    privileged: true
    restart: unless-stopped
    ports:
      - '80:80'
      - '443:443'
    volumes:
      - '/opt/rancher:/var/lib/rancher'
```