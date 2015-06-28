# vim:set ft=dockerfile:

# Base on VRT Base image
FROM vrtsystems/baseimage
MAINTAINER VRT Engineering <engineering@vrt.com.au>

# add our user and group first to make sure their IDs get assigned
# consistently, regardless of whatever dependencies get added later
RUN groupadd -r grafana && useradd -r -g grafana grafana


COPY grafana_latest_amd64.deb /tmp/

RUN apt-get update && apt-get -y install libfontconfig adduser openssl ca-certificates \
        && dpkg -i /tmp/grafana_latest_amd64.deb \
        && rm /tmp/grafana_latest_amd64.deb \
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
