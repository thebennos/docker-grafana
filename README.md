# VRT Systems Docker Grafana

Docker image to run Grafana - derived from Grafana's official docker image, using vrtsystems/baseimage and the supervisord entry point.

The image uses a VRT fork of the Grafana 2.0.2 package with the
[singlestat-add-image](https://github.com/vrtsystems/grafana/commit/804d7e95cf5e107dbf14ee09242fdf99a4281ae3) patch by Alex.

# How to use this image

To try it out, start your image binding the external port `3000` (default admin login is admin/admin).

	docker run -i -p 3000:3000 vrtsystems/grafana

See below how you can override default credentials if you're running this in production.


## Configuring your Grafana container

All options defined in conf/grafana.ini can be overriden using environment variables, for example:

	docker run -i -p 3000:3000 \
	  -e "GF_SERVER_ROOT_URL=http://grafana.mydomain.com"  \
	  -e "GF_SECURITY_ADMIN_PASSWORD=secret  \
	  vrtsystems/grafana


