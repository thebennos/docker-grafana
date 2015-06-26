# VRT Systems Docker Grafana

Docker image to run Grafana - derived from Grafana's official docker image, using vrtsystems/baseimage and the supervisord entry point.

The image uses a VRT fork of the Grafana 2.0.2 package with the
`singlestat-add-image` patch by Alex.

# How to use this image

Start your image binding the external port `3000`.

   docker run -i -p 3000:3000 vrtsystems/grafana

Try it out, default admin user is admin/admin.

## Configuring your Grafana container

All options defined in conf/grafana.ini can be overriden using environment variables, for example:

```
docker run -i -p 3000:3000 \
  -e "GF_SERVER_ROOT_URL=http://grafana.wide-sky.net"  \
  -e "GF_SECURITY_ADMIN_PASSWORD=secret  \
  vrtsystems/grafana
```

