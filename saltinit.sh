#!/bin/bash
################################################################
# Code by Jioh L. Jung
################################################################
SALT_SHARED_SECRET=${SALT_SHARED_SECRET:-"salt123"}

#> log level.
#  One of 'all', 'garbage', 'trace', 'debug', 'profile', 'info', 'warning',
#         'error', 'critical', 'quiet'.
#    Default: 'warning'.
SALT_DEBUG_LEVEL=${SALT_DEBUG_LEVEL:-"warning"}

#echo "Set PASSWORD=> '${SALT_SHARED_SECRET}'"
echo "salt:${SALT_SHARED_SECRET}" | chpasswd

if [ -f "/etc/salt/master.d/auth.conf" ]; then
  echo "Auth Config Existed - Pass to reconfig"
else
cat > /etc/salt/master.d/auth.conf <<EOF
external_auth:
  pam:
    salt:
      - .*
      - '@runner'
      - '@wheel'
      - '@jobs'
EOF
fi

if [ -f "/etc/salt/master.d/admin.conf" ]; then
  echo "Web Admin Page(SaltGUI) Existed - Pass to reconfig"
else
cat > /etc/salt/master.d/admin.conf <<EOF
rest_cherrypy:
  port: 8000
  host: 0.0.0.0
  disable_ssl: true
  app: /opt/SaltGUI-master/saltgui/index.html
  static: /opt/SaltGUI-master/saltgui/static
  static_path: /static
EOF
fi

echo "> salt-master starting <"
salt-master -d \
	--log-file=/var/log/salt/master \
        --log-file-level=${SALT_DEBUG_LEVEL}
echo "> salt-api starting <"
salt-api -d \
	--log-file=/var/log/salt/api \
        --log-file-level=${SALT_DEBUG_LEVEL}
sleep inf
