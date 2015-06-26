#!/bin/bash
# vim: set ts=8 sts=4 et tw=72 sw=4:

# set -m

if [ "$1" = 'supervisor' ]; then
    # Run up the server via supervisord...
    echo "Starting Supervisord..."
    exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
fi

if [ "$1" = 'grafana' ]; then
    # Run as grafana user
    echo "Starting grafana as grafana user..."
    exec gosu grafana "$@"
fi

# Anything else as root...
echo "Custom command..."
exec "$@"
