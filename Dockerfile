# vim:set ft=dockerfile:

# Base on VRT Base image
FROM vrtsystems/baseimage
MAINTAINER VRT Engineering <engineering@vrt.com.au>

# add our user and group first to make sure their IDs get assigned
# consistently, regardless of whatever dependencies get added later
RUN groupadd -r grafana && useradd -r -g grafana grafana


ENV GRAFANA_VERSION 2.0.2

COPY grafana_2.0.2-singlestat-image_amd64.deb /tmp/

RUN apt-get update && apt-get -y install libfontconfig adduser openssl ca-certificates \
	&& curl https://grafanarel.s3.amazonaws.com/builds/grafana_${GRAFANA_VERSION}_amd64.deb > /tmp/grafana_amd64.deb \
        && dpkg -i /tmp/grafana_*.deb \
        && rm /tmp/grafana_*.deb \
        && rm -rf /var/lib/apt/lists/*


ENV GF_CONFIG /etc/grafana/grafana.ini
COPY grafana.ini /etc/grafana/


EXPOSE 3000

VOLUME ["/var/lib/grafana"]
VOLUME ["/var/log/grafana"]
VOLUME ["/etc/grafana"]

WORKDIR /usr/share/grafana

COPY docker-entrypoint.sh /usr/local/bin/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#ENTRYPOINT ["/usr/sbin/grafana-server", "--config", "/etc/grafana/grafana.ini"]

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["supervisor"]
